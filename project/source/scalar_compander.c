#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


/*
    ________________________COMPANDING TABLE_______________________
    0000 0000 000A BCDX | -> | S000 ABCD | -> | 0000 0000 000A BCD1     (CHORD 0)
    0000 0000 001A BCDX | -> | S001 ABCD | -> | 0000 0000 001A BCD1     (CHORD 1)
    0000 0000 01AB CDXX | -> | S010 ABCD | -> | 0000 0000 01AB CD10     (CHORD 2)
    0000 0000 1ABC DXXX | -> | S011 ABCD | -> | 0000 0000 1ABC D100     (CHORD 3)
    0000 0001 ABCD XXXX | -> | S100 ABCD | -> | 0000 0001 ABCD 1000     (CHORD 4)
    0000 001A BCDX XXXX | -> | S101 ABCD | -> | 0000 001A BCD1 0000     (CHORD 5)
    0000 01AB CDXX XXXX | -> | S110 ABCD | -> | 0000 01AB CD10 0000     (CHORD 6)
    0000 1ABC DXXX XXXX | -> | S111 ABCD | -> | 0000 1ABC D100 0000     (CHORD 7)

*/

#define INVERT_EVEN_BITS_MASK   (0x55U)


/* Compresses a 16-bit signed integer sample, returns 8-bit unsigned compressed_codeword */
uint8_t compress_scalar(int16_t sample) {

    /* Extract sign mask: 0x0000 (positive) or 0xFFFF (negative) */
    uint16_t sign_mask = (uint16_t)(sample >> 15U);

    /* Compute magnitude: if negative, (2's complement = (~sample) + 1) */
    uint16_t magnitude = ((uint16_t)sample ^ sign_mask) - sign_mask;

    /* Bit-shift the magnitude right by 3 */
    magnitude >>= 3U;

    /* - Count leading_zeros using gcc __builtin_clz() intrinsic function 
       - OR with 1 to avoid undefined clz behaviour on zero
       - Subtract 16 since clz operates on 32-bit value
    */
    uint16_t leading_zeros = __builtin_clz(magnitude | 1) - 16;
    

    /* Clamp leading_zeroes to a maximum of 11 (range: [4,11] -> 8 possible values) */
    if (leading_zeros > 11) 
    {
        leading_zeros = 11;
    } 

    /* Compute chord (range: [0,7]) */
    uint8_t chord = 11 - leading_zeros;      

    /* Extract step bits: chord 0 must also be bit-shifted right by one */
    uint8_t step = (magnitude >> (chord + (chord == 0))) & 0x0F;

    /* Assemble compressed_codeword */
    uint8_t compressed_codeword = ((sign_mask & 0x01) << 7U) | ((chord & 0x07) << 4U) | (step);

    /* Invert even bits for transmission */
    compressed_codeword ^= INVERT_EVEN_BITS_MASK;

    /* compressed_codeword transmitted over the air */
    return compressed_codeword;
}

/* Decompresses an 8-bit unsigned compressed_codeword, returns 16-bit signed integer sample */
int16_t expand_scalar(uint8_t compressed_codeword) {

    /* Invert even bits again to get compressed_codeword */
    compressed_codeword ^= INVERT_EVEN_BITS_MASK;

    /* Extract sign bit as 1 or 0 */
    uint8_t sign = (compressed_codeword >> 7U) & 0x01;

    /* Extract chord as range [0,7] */
    uint8_t chord = (compressed_codeword >> 4U) & 0x07;

    /* Extract step as last four bits */
    uint8_t step = (compressed_codeword) & 0x0F;

    /* Construct magnitude from components */
    uint16_t magnitude;
    if (chord == 0)
    {
        magnitude = ((step << 1U) | 1);
    }
    else
    {
        magnitude = (0x10 | step) << (chord - 1);
    }

    /* Bit-shift the magnitude left by 3 */
    magnitude <<= 3U;

    /* Convert magnitude back to signed sample */
    int16_t sample;
    if (sign == 1) 
    {
        sample = -(int16_t)magnitude;
    }
    else 
    {
        sample = (int16_t)magnitude;

    }

    /* Decompressed Codeword is returned */
    return sample;
}
