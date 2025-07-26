#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#include "scalar_compander.h"
#include "simd_compander.h"



int main(int argc, char *argv[]) {
    // validate arguments
    if (argc != 2) {
        printf("Incorrect arguments, please use: %s input_file.wav\n", argv[0]);
        return(1);
    }


    // SCALAR COMPANDING

    // open input_file and output_file
    FILE *input_scalar = fopen(argv[1], "rb");
    if (!input_scalar) {
        perror("input file failed to open");
        return(1);
    }
    FILE *output_scalar = fopen("output/scalar_output.wav", "wb");
    if (!output_scalar){
        perror("output file failed to open");
        return(1);
    }

    //write header
    uint8_t header_scalar[44];
    fread(header_scalar, 1, 44, input_scalar);
    fwrite(header_scalar, 1, 44, output_scalar);
 

    // compand scalar samples from the input_scalar file and write them to the output_scalar file
    int16_t input_sample;
    while(fread(&input_sample, sizeof(int16_t), 1, input_scalar)) {
        uint8_t compressed_codeword = compress_scalar(input_sample);
        int16_t output_sample = expand_scalar(compressed_codeword);
        fwrite(&output_sample, sizeof(int16_t), 1, output_scalar);
    }

    fclose(input_scalar);
    fclose(output_scalar);




    // SIMD COMPANDING
    
    // open input_file and output_file
    FILE *input_simd = fopen(argv[1], "rb");
    if (!input_simd) {
        perror("input file failed to open");
        return(1);
    }
    FILE *output_simd = fopen("output/simd_output.wav", "wb");
    if (!output_simd){
        perror("output file failed to open");
        return(1);
    }

    // write header
    uint8_t header_simd[44];
    fread(header_simd, 1, 44, input_simd);
    fwrite(header_simd, 1, 44, output_simd);    

    // compand samples from the input_simd file in batches (of up to 8 samples per batch) and write them to the output_simd file
    Batch16Bit input_batch;
    while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_simd)) > 0) {
        Batch8Bit compressed_batch = compress_batch(input_batch);
        Batch16Bit decompressed_batch = expand_batch(compressed_batch);
        fwrite(decompressed_batch.data, sizeof(int16_t), decompressed_batch.count, output_simd);
    }

    fclose(input_simd);
    fclose(output_simd);


    return 0;
}
