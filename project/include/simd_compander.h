#ifndef SIMD_COMPANDER_H
#define SIMD_COMPANDER_H

#include <stdint.h>


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


// FUNCTIONS

// compresses batch with NEON intrinsics
Batch8Bit compress_batch(Batch16Bit input_batch);

// expands batch with NEON intrinsics
Batch16Bit expand_batch(Batch8Bit input_batch);


#endif