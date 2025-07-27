#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <arm_neon.h>
#include <string.h>



/*
   ___________________________________________________________________
   |______________________SIMD A-Law Compander_______________________|
   |                                                                 |
   |     - This program uses the ARM NEON library of SIMD intrinsic  |
   |       functions to compand audio samples in parallel            |
   |                                                                 |
   |     - SIMD: Single Instruction Multiple Data                    |
   |_________________________________________________________________|
   |________________________COMPANDING TABLE_________________________|
   | 0000 0000 000A BCDX | -> | S000 ABCD | -> | 0000 0000 000A BCD1 |     (CHORD 0)
   | 0000 0000 001A BCDX | -> | S001 ABCD | -> | 0000 0000 001A BCD1 |     (CHORD 1)
   | 0000 0000 01AB CDXX | -> | S010 ABCD | -> | 0000 0000 01AB CD10 |     (CHORD 2)
   | 0000 0000 1ABC DXXX | -> | S011 ABCD | -> | 0000 0000 1ABC D100 |     (CHORD 3)
   | 0000 0001 ABCD XXXX | -> | S100 ABCD | -> | 0000 0001 ABCD 1000 |     (CHORD 4)
   | 0000 001A BCDX XXXX | -> | S101 ABCD | -> | 0000 001A BCD1 0000 |     (CHORD 5)
   | 0000 01AB CDXX XXXX | -> | S110 ABCD | -> | 0000 01AB CD10 0000 |     (CHORD 6)
   | 0000 1ABC DXXX XXXX | -> | S111 ABCD | -> | 0000 1ABC D100 0000 |     (CHORD 7)
   |_________________________________________________________________| 

*/



// DATA STRUCTS

// decompressed 16-bit sample batch (up to 8 samples per batch)
typedef struct {
    int16_t data[8];
    uint8_t count;
} Batch16Bit;

// compressed 8-bit codeword batch (up to 8 samples per batch)
typedef struct {
    uint8_t data[8];
    uint8_t count;
} Batch8Bit;



// BATCH COMPANDING FUNCTIONS

// compresses batch with NEON intrinsics
Batch8Bit compress_batch(Batch16Bit input_batch) {
    // copy data samples into zero initialized array
    int16_t sample_array[8] = {0};
    memcpy(sample_array, input_batch.data, input_batch.count*sizeof(int16_t));

    // get neon vector of samples
    int16x8_t samples = vld1q_s16(sample_array);

    // extract the sign bits to bit 7 of an 8-bit lane
    uint16x8_t signs = vshrq_n_u16(vreinterpretq_u16_s16(samples), 15);
    uint8x8_t signs_8bit = vmovn_u16(vshlq_n_u16(signs, 7)); //shift operations on 16-bit lanes is more efficient

    // get 13-bit shifted absolutes
    uint16x8_t absolutes = vshrq_n_u16(vreinterpretq_u16_s16(vabsq_s16(samples)), 3);

    // get chord segments
    uint16x8_t leading_zeros = vclzq_u16(absolutes);
    uint16x8_t chords = vqsubq_u16(vdupq_n_u16(11), leading_zeros); // range [0,7] (if clz=3,2,1, chord could be 8,9,10 -> should not happen since 13-bit positive integer)
    uint8x8_t chords_8bit = vmovn_u16(vshlq_n_u16(chords, 4));

    // get step bits (variable shifts only supported on left-shift, must left-shift by a negative)
    // get shift magnitude (right-shift = chord + (chord==0))
    uint16x8_t shifts = vaddq_u16(chords, vandq_u16(vceqq_u16(chords, vdupq_n_u16(0)), vdupq_n_u16(1))); 
    // variable shift left by a negative to shift right
    int16x8_t negative_shifts = vnegq_s16(vreinterpretq_s16_u16(shifts));
    // shift and mask to get lower 4 bits
    uint16x8_t shifted_steps = vandq_u16(vshlq_u16(absolutes, negative_shifts), vdupq_n_u16(0x0F));
    // step bits in 8-bit format
    uint8x8_t steps_8bit = vmovn_u16(shifted_steps);

    // assemble 8-bit compressed codewords
    uint8x8_t codewords = vorr_u8(signs_8bit, vorr_u8(chords_8bit, steps_8bit));

    // invert even bits of codewords for transmission
    codewords = veor_u8(codewords, vdup_n_u8(0x55));

    // create output struct (for edge case where final input is less than 8 samples and a count is required)
    Batch8Bit output;
    vst1_u8(output.data, codewords);
    output.count = input_batch.count;

    // return the output
    return output;

}

// expands batch with NEON intrinsics
Batch16Bit expand_batch(Batch8Bit input_batch) {
    // copy data codewords into zero initialized array
    uint8_t codeword_array[8] = {0};
    memcpy(codeword_array, input_batch.data, input_batch.count*sizeof(uint8_t));

    // get neon vector of samples (also invert even bits to get true codeword)
    uint8x8_t codewords = veor_u8(vld1_u8(codeword_array), vdup_n_u8(0x55));

    // extract sign, chord, and step bits for all lanes
    uint16x8_t signs = vmovl_u8(vshr_n_u8(codewords, 7)); // unsigned right-shift of all bits, will be zero-padded so does not need masking
    uint16x8_t chords = vmovl_u8(vand_u8(vshr_n_u8(codewords, 4), vdup_n_u8(0x07)));
    uint16x8_t steps = vmovl_u8(vand_u8(codewords, vdup_n_u8(0x0F)));


    //reassemble the 16-bit signed sample
    // formula: absolute = (chord == 0) ? (step << 1) | 1 : ((0x10 | step) << (chord)) | (1 << (chord - 1)) 
    // get steps with trailing bit (step = (step << 1) | 1)
    steps = vorrq_u16(vshlq_n_u16(steps, 1), vdupq_n_u16(1));
    
    // get (chord - 1)
    uint16x8_t chords_minus_one = vqsubq_u16(chords, vdupq_n_u16(1));

    // get 0x20 | steps
    uint16x8_t steps_with_leading_bit = vorrq_u16(steps, vdupq_n_u16(0x20));

    //get shifted steps for chords 1-7
    uint16x8_t shifted_steps = vshlq_u16(steps_with_leading_bit, vreinterpretq_s16_u16(chords_minus_one));

    // get absolute = (chord==0) ? steps : shifted_steps
    uint16x8_t is_zero = vceqq_u16(chords, vdupq_n_u16(0));
    uint16x8_t absolutes = vbslq_u16(is_zero, steps, shifted_steps);

    // left shift by 3 to get 16-bit form
    absolutes = vshlq_n_u16(absolutes, 3);

    //get true signed sample values
    int16x8_t signed_samples = vreinterpretq_s16_u16(absolutes);
    uint16x8_t sign_masks = vceqq_u16(signs, vdupq_n_u16(1));
    signed_samples = vbslq_s16(sign_masks, vnegq_s16(signed_samples), signed_samples);

    
    // create output struct (for edge case where final input is less than 8 samples and a count is required)
    Batch16Bit output;
    vst1q_s16(output.data, signed_samples);
    output.count = input_batch.count;

    // return the output
    return output;
}
