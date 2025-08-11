#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "scalar_compander.h"
#include "simd_compander.h"
#include "lookup_compander.h"


int scalar_regular(char *filename) {
    // SCALAR COMPANDING

    // open input_file and output_file
    FILE *input_scalar = fopen(filename, "rb");
    if (!input_scalar) {
        perror("input file failed to open");
        return(1);
    }
    FILE *output_scalar = fopen("outputs/scalar_output.wav", "wb");
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

    return 0;
}

int scalar_pipelined(char *filename) {
    // SCALAR COMPANDING

    // open input_file and output_file
    FILE *input_scalar = fopen(filename, "rb");
    if (!input_scalar) {
        perror("input file failed to open");
        return(1);
    }
    FILE *output_scalar = fopen("outputs/scalar_pipelined_output.wav", "wb");
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
    fread(&input_sample, sizeof(int16_t), 1, input_scalar);
    uint8_t prev_comp = compress_scalar(input_sample);
    int16_t prev_decomp = expand_scalar(prev_comp);
    size_t read;
    do {
        read = fread(&input_sample, sizeof(int16_t), 1, input_scalar);
        int16_t output_sample = expand_scalar(prev_comp);
        fwrite(&prev_decomp, sizeof(int16_t), 1, output_scalar);
        prev_decomp = output_sample;
        if (read) {
            prev_comp = compress_scalar(input_sample);
        }
    } while (read);
    fwrite(&prev_decomp, sizeof(int16_t), 1, output_scalar);

    fclose(input_scalar);
    fclose(output_scalar);

    return 0;
}

int simd_regular(char *filename) {
    // SIMD COMPANDING
    
    // open input_file and output_file
    FILE *input_simd = fopen(filename, "rb");
    if (!input_simd) {
        perror("input file failed to open");
        return(1);
    }
    FILE *output_simd = fopen("outputs/simd_output.wav", "wb");
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


int simd_pipelined(char *filename) {
    // SIMD COMPANDING WITH PIPELINING
    
    // open input_file and output_file
    FILE *input_simd = fopen(filename, "rb");
    if (!input_simd) {
        perror("input file failed to open");
        return(1);
    }
    FILE *output_simd = fopen("outputs/simd_pipelined_output.wav", "wb");
    if (!output_simd){
        perror("output file failed to open");
        return(1);
    }

    // write header
    uint8_t header_simd[44];
    fread(header_simd, 1, 44, input_simd);
    fwrite(header_simd, 1, 44, output_simd);    

    Batch16Bit input_a, input_b;
    Batch8Bit comp_a, comp_b;
    Batch16Bit decomp_a;

    if ((input_a.count = (uint8_t)fread(input_a.data, sizeof(int16_t), 8, input_simd)) > 0) comp_a = compress_batch(input_a);
    if ((input_b.count = (uint8_t)fread(input_b.data, sizeof(int16_t), 8, input_simd)) > 0) comp_b = compress_batch(input_b);
    do {
        decomp_a = expand_batch(comp_a);
        fwrite(decomp_a.data, sizeof(int16_t), decomp_a.count, output_simd);
        input_a = input_b;
        comp_a = comp_b;
        if ((input_b.count = (uint8_t)fread(input_b.data, sizeof(int16_t), 8, input_simd)) > 0) comp_b = compress_batch(input_b);
    } while (input_a.count > 0);

    fclose(input_simd);
    fclose(output_simd);

    return 0;

}

// Baqar addition
// Pipelined: always have one "in flight" sample; overlap steps for speed.
int lookup_compander_pipelined(const char *filename) {
    FILE *in = fopen(filename, "rb");
    if (!in) {
        perror("input file failed to open");
        return 1;
    }
    FILE *out = fopen("outputs/lookup_pipelined.wav", "wb");
    if (!out) {
        perror("output file failed to open");
        fclose(in);
        return 1;
    }
    uint8_t header[44];
    fread(header, 1, 44, in);
    fwrite(header, 1, 44, out);

    int16_t curr_sample, next_sample;
    uint8_t curr_codeword, next_codeword;
    int16_t curr_expanded;

    // Pipeline: read first sample
    if (fread(&curr_sample, sizeof(int16_t), 1, in) != 1) {
        fclose(in);
        fclose(out);
        return 0; // No data; just header
    }
    curr_codeword = compress_lookup(curr_sample);
    curr_expanded = expand_lookup(curr_codeword);

    while (fread(&next_sample, sizeof(int16_t), 1, in) == 1) {
        next_codeword = compress_lookup(next_sample);
        fwrite(&curr_expanded, sizeof(int16_t), 1, out);

        curr_codeword = next_codeword;
        curr_expanded = expand_lookup(curr_codeword);
    }
    fwrite(&curr_expanded, sizeof(int16_t), 1, out);

    fclose(in);
    fclose(out);
    return 0;
}

//B



int main(int argc, char *argv[]) {
    // validate arguments
    if (argc != 2) {
        printf("Incorrect arguments, please use: %s input_file.wav\n", argv[0]);
        return(1);
    }

    load_lookup_tables();

    int iterations = 2;
    clock_t start;
    clock_t end;
    clock_t total_start;
    clock_t total_end;
    double elapsed;
    char *format = "%-35s : %10.0f ms\n";

    FILE *stats = fopen("statistics.txt", "w");
    if (!stats) {
        perror("error opening statistics.txt");
        return 1;
    }

    fprintf(stats, "A-Law Audio Compression and Expansion Test Results (average execution time for %d iterations)\n\n", iterations);
    printf("\nA-Law Audio Compression and Expansion Test Results (average execution time for %d iterations)\n\n", iterations);


    total_start = clock();
    start = clock();
    for (int i = 0; i < iterations; i++) {
        lookup_compander_regular(argv[1]);
    }
    end = clock();
    elapsed = (double)(end-start) / CLOCKS_PER_SEC * 1000;
    fprintf(stats, format, "Lookup Table Compander Regular", (elapsed / iterations));
    printf(format, "Lookup Table Compander Regular", (elapsed / iterations));

    start = clock();
    for (int i = 0; i < iterations; i++) {
        lookup_compander_pipelined(argv[1]);  
    }
    end = clock();
    elapsed = (double)(end-start) / CLOCKS_PER_SEC * 1000;
    fprintf(stats, format, "Lookup Table Compander Pipelined", (elapsed / iterations));
    printf(format, "Lookup Table Compander Pipelined", (elapsed / iterations));


    start = clock();
    for (int i = 0; i < iterations; i++) {
        scalar_regular(argv[1]);
    }
    end = clock();
    elapsed = (double)(end-start) / CLOCKS_PER_SEC * 1000;
    fprintf(stats, format, "Scalar Compander Regular", (elapsed / iterations));
    printf(format, "Scalar Compander Regular", (elapsed / iterations));


    start = clock();
    for (int i = 0; i < iterations; i++) {
        scalar_pipelined(argv[1]);
    }
    end = clock();
    elapsed = (double)(end-start) / CLOCKS_PER_SEC * 1000;
    fprintf(stats, format, "Scalar Compander Pipelined", (elapsed / iterations));
    printf(format, "Scalar Compander Pipelined", (elapsed / iterations));


    start = clock();
    for (int i = 0; i < iterations; i++) {
        simd_regular(argv[1]);
    }
    end = clock();
    elapsed = (double)(end-start) / CLOCKS_PER_SEC * 1000;
    fprintf(stats, format, "SIMD Compander Regular", (elapsed / iterations));
    printf(format, "SIMD Compander Regular", (elapsed / iterations));


    start = clock();
    for (int i = 0; i < iterations; i++) {
        simd_pipelined(argv[1]);
    }
    end = clock();
    elapsed = (double)(end-start) / CLOCKS_PER_SEC * 1000;
    fprintf(stats, format, "SIMD Compander Pipelined", (elapsed / iterations));
    printf(format, "SIMD Compander Pipelined", (elapsed / iterations));


    total_end = clock();
    elapsed = (double)(total_end-total_start) / CLOCKS_PER_SEC;
    fprintf(stats, "%-35s : %10.0f s\n", "Total Test-Bench Execution Time", (elapsed));    
    printf("%-35s : %10.0f s\n\n", "Total Test-Bench Execution Time", (elapsed));    


    fclose(stats);


    return 0;
}
