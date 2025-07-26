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


int compress1(int sample) {
    // get sign and magnitude of sample
    int sign = 0;
    int magnitude = sample;
    if (sample < 0) {
        sign = 1;
        magnitude *= -1;
    }
    // right-shift magnitude by 3 to get 13 significant bits (a-law standard)
    magnitude >>= 3;
    // count leading zeros, account for undefined behavior at zero magnitude
    int leading_zeros = __builtin_clz(magnitude | 1) - 16; //range [4,16]
    leading_zeros = (leading_zeros > 11) ? 11 : leading_zeros; //range[4,11] (7 possible chords)
    // determine chord
    int chord = 11 - leading_zeros;
    // extract step
    int step = (magnitude >> (chord + (chord == 0))) & 0x0F;
    // build compressed codeword from sign, chord, and step bits
    int compressed_codeword = (sign << 7) | ((chord) << 4) | (step);
    // invert even bits of compressed codeword for transmission
    compressed_codeword ^= 0b01010101;
    return compressed_codeword;
}

int expand1(int compressed_codeword) {
    // invert again the even bits of the transmitted compressed codeword
    compressed_codeword ^= 0b01010101;
    // extract sign, chord, and step bits from compressed codeword
    int sign    = (compressed_codeword & 0b10000000) >> 7;
    int chord   = (compressed_codeword & 0b01110000) >> 4;
    int step    = compressed_codeword & 0b00001111;
    // rebuild absolute valued sample from step bits, leading/trailing ones
    int magnitude;
    if (chord ==0) {
        magnitude = (step << 1) | 0b00000001;
    } else {
        magnitude = (0b00010000 | step | 0b00000001 ) << (chord - 1);
    }
    // left-shift by 3 bits to get back to 16-bit sample
    magnitude <<= 3;
    // rebuild true sample from signed magnitude 
    int sample = (sign == 1) ? -magnitude : magnitude;
    return sample;
}
