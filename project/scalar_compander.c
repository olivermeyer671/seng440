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



uint8_t compress_scalar(int16_t sample) {
    //if (sample == 0) return 0xD5;
    uint16_t mask = sample >> 15;       // 0x0000 if positive, 0xFFFF if negative
    uint16_t magnitude = (sample ^ mask) - mask + (sample == -32768);   // 0??? ???? ???? ????
    magnitude >>= 3;                                                    // 0000 ???? ???? ???X
    uint16_t leading_zeros = __builtin_clz(magnitude | 1) - 16;         //                      (lz range [0,16])
    leading_zeros = (leading_zeros > 11) ? 11 : leading_zeros;                         // 0000 0000 000        (lz range [4,11])
    uint8_t chord = 11 - leading_zeros;                                 // 0000 7654 321A BCDX  (msb chord locations range [0,7])
    uint8_t step = (magnitude >> (chord + (chord == 0))) & 0x0F;
    uint8_t compressed_codeword = ((mask & 0x01) << 7) | ((chord & 0x07) << 4) | (step);
    compressed_codeword ^= 0x55;        // Flip even bits for transmission
    // Compressed codeword is now transmitted over the air.
    return compressed_codeword;
}


int16_t expand_scalar(uint8_t compressed_codeword) {
    //if (compressed_codeword == 0xD5) return 0;
    compressed_codeword ^= 0x55;
    uint8_t sign = (compressed_codeword >> 7) & 0x01;
    uint8_t chord = (compressed_codeword >> 4) & 0x07;
    uint8_t step = (compressed_codeword) & 0x0F;
    uint16_t magnitude = (chord == 0) ? ((step << 1) | 1) : (0x10 | step) << (chord - 1);
    magnitude <<= 3;
    int16_t sample = sign ? -(int16_t)magnitude : (int16_t)magnitude;
    return sample;
}
