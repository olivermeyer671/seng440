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
    uint8x8_t signs_8bit = vmovn_u16(vshl_n_u16(signs, 7)); //shift operations on 16-bit lanes is more efficient

    // get 13-bit shifted absolutes
    uint16x8_t absolutes = vshrq_n_u16(vreinterpretq_u16_s16(vabsq_s16(samples)), 3);

    // get chord segments
    uint16x8_t leading_zeros = vclzq_u16(absolutes);
    uint16x8_t chords = vqsubq_u16(vdupq_n_u16(11), leading_zeros); // range [0,7] (if clz=3,2,1, chord could be 8,9,10 -> should not happen since 13-bit positive integer)
    uint8x8_t chords_8bit = vmovn_u16(vshl_n_u16(chords, 4));

    // get step bits (must be done without NEON since variable shifts are not supported)
    uint16_t absolutes_array[8] = {0};
    vst1q_u16(absolutes_array, absolutes);
    uint16_t chords_array[8] = {0};
    vst1q_u16(chords_array, chords);
    uint16_t steps_array[8] = {0};
    for (uint8_t i = 0; i < input_batch.count; i++) {
        steps_array[i] = ((absolutes_array[i] >> (chords_array[i] + (chords_array[i] == 0))) & 0x0F);
    }
    uint8x8_t steps_8bit = vmovn_u16(vld1_u16(steps_array));

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
    uint8x8_t signs = vshr_n_u8(codewords, 7); // unsigned right-shift of all bits, will be zero-padded so does not need masking
    uint8x8_t chords = vand_u8(vshr_n_u8(codewords, 4), vdup_n_u8(0x07));
    uint8x8_t steps = vand_u8(codewords, vdup_n_u8(0x0F));

    // assemble 16-bit decompressed output samples (must be done without NEON since variable shifts are not supported)
    uint8_t signs_array[8] = {0};
    vst1_u8(signs_array, signs);
    uint8_t chords_array[8] = {0};
    vst1_u8(chords_array, chords);
    uint8_t steps_array[8] = {0};
    vst1_u8(steps_array, steps);
    int16_t output_array[8] = {0};
    for (uint8_t i = 0; i < input_batch.count; i++) {
        uint16_t decompressed_absolute = (chords_array[i] == 0) ? ((steps_array[i] << 1) | 1) : (0x10 | steps_array[i]) << (chords_array[i] - 1);
        decompressed_absolute <<= 3;
        int16_t decompressed_sample = signs_array[i] ? -(int16_t)decompressed_absolute : (int16_t)decompressed_absolute;
        output_array[i] = decompressed_sample;
    }
    int16x8_t output_samples = vld1q_s16(output_array);

    // create output struct (for edge case where final input is less than 8 samples and a count is required)
    Batch16Bit output;
    vst1_s16(output.data, output_samples);
    output.count = input_batch.count;

    // return the output
    return output;
}



// BATCH WAV IO

// main function (runs the batch companding functions on wav file input, outputs to wav file)
int main(int argc, char *argv[]) {
    // validate arguments
    if (argc != 3) {
        printf("Incorrect arguments, please use: %s input_file.wav output_file.wav\n", argv[0]);
        return(1);
    }

    // open input_file and output_file
    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {
        perror("input_file failed to open");
        return(1);
    }
    FILE *output_file = fopen(argv[2], "wb");
    if (!output_file){
        perror("output_file failed to open");
        return(1);
    }

    // copy wav header from input_file to output_file
    uint8_t header[44];
    fread(header, 1, 44, input_file);
    fwrite(header, 1, 44, output_file);

    // compand samples from the input_file in batches (of up to 8 samples per batch) and write them to the output_file
    Batch16Bit input_batch;
    while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
        Batch8Bit compressed_batch = compress_batch(input_batch);
        Batch16Bit decompressed_batch = expand_batch(compressed_batch);
        fwrite(decompressed_batch.data, sizeof(int16_t), decompressed_batch.count, output_file);
    }

    // close input_file and output_file
    fclose(input_file);
    fclose(output_file);
    
    // return without errors
    return 0;
}
