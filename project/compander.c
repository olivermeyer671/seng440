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

uint8_t compress2(int16_t sample) {
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

int16_t expand2(uint8_t compressed_codeword) {
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

int main(int argc, char *argv[]) {
    
    if (argc != 3) {
        printf("Incorrect arguments, please use: %s input_file.wav output_file.wav\n", argv[0]);
        return(1);
    }

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

    uint8_t header[44];
    fread(header, 1, 44, input_file);
    fwrite(header, 1, 44, output_file);

    int16_t sample;
    while(fread(&sample, sizeof(int16_t), 1, input_file) == 1) {

        uint8_t compressed_codeword = compress2(sample);
        int16_t new_sample = expand2(compressed_codeword);


        fwrite(&new_sample, sizeof(int16_t), 1, output_file);
    }

    fclose(input_file);
    fclose(output_file);
       
    // TEST BENCHMARK CODE
    /*

    int16_t inputs[8] = {
        0b0000000000011110,
        0b0000000000111110,
        0b0000000001111100,
        0b0000000011111000,
        0b0000000111110000,
        0b0000001111100000,
        0b0000011111000000,
        0b0000111110000000,
    };

    for (int i=0; i<=7; i++) {
       
        uint8_t compressed_codeword = compress2(inputs[i]);
        int16_t new_sample = expand2(compressed_codeword);
        printf("Input: %d, Codeword: %d, Output: %d\n", inputs[i], compressed_codeword, new_sample);
    }

    
void print_binary16(uint16_t val) {
    for (int i = 15; i >= 0; i--) {
        printf("%d", (val >> i) & 1);
        if (i % 4 == 0) printf(" "); 
    }
}

int main() {
    int16_t inputs[16] = {
        0b0000000000000000,
        0b0000000011110000,
        0b0000000100000000,
        0b0000000111110000,
        0b0000001000000000,
        0b0000001111100000,
        0b0000010000000000,
        0b0000011111000000,
        0b0000100000000000,
        0b0000111110000000,
        0b0001000000000000,
        0b0001111100000000,
        0b0010000000000000,
        0b0011111000000000,
        0b0100000000000000,
        12345//0b0111110000000000
    };

    for (int i = 0; i <= 15; i++) {
        uint8_t compressed_codeword = compress1(inputs[i]) ^ 0x55;
        int16_t new_sample = expand1(compressed_codeword ^ 0x55);

        printf("Input:            ");
        print_binary16((uint16_t)inputs[i]);
        printf("  (%5d)\n", inputs[i]);

        printf("Input >> 3:       ");
        print_binary16((uint16_t)inputs[i] >> 3);
        printf("  (%5d)\n", inputs[i] >> 3);

        printf("Compressed Code:  ");
        print_binary16((uint16_t)compressed_codeword);
        printf("  (%5d)\n", compressed_codeword);

        printf("Expanded Out >> 3:");
        print_binary16((uint16_t)new_sample >> 3);
        printf("  (%5d)\n", new_sample >> 3);

        printf("Expanded Output:  ");
        print_binary16((uint16_t)new_sample);
        printf("  (%5d)\n", new_sample);

        printf("--------------------------------------------------\n");
    }

    for (int i = 0; i <=15; i++) {
        inputs[i] *= -1;
    }
    
    printf("\n\nNEGATIVE INPUTS:\n\n");
    for (int i = 0; i <= 15; i++) {
        uint8_t compressed_codeword = compress1(inputs[i]) ^ 0x55;
        int16_t new_sample = expand1(compressed_codeword ^ 0x55);

        printf("Input:            ");
        print_binary16((uint16_t)inputs[i]);
        printf("  (%5d)\n", inputs[i]);

        printf("Input >> 3:       ");
        print_binary16((uint16_t)inputs[i] >> 3);
        printf("  (%5d)\n", inputs[i] >> 3);

        printf("Compressed Code:  ");
        print_binary16((uint16_t)compressed_codeword);
        printf("  (%5d)\n", compressed_codeword);

        printf("Expanded Out >> 3:");
        print_binary16((uint16_t)new_sample >> 3);
        printf("  (%5d)\n", new_sample >> 3);

        printf("Expanded Output:  ");
        print_binary16((uint16_t)new_sample);
        printf("  (%5d)\n", new_sample);

        printf("--------------------------------------------------\n");
    }
    */

    return(0);
}