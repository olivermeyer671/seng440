#ifndef LOOKUP_COMPANDER_H
#define LOOKUP_COMPANDER_H

#include <stdint.h>

// Loads the A-law compression and expansion lookup tables from CSV files.
// Must be called once before any companding is performed.
void load_lookup_tables(void);

// Looks up the A-law codeword for a given 16-bit sample.
uint8_t compress_lookup(int16_t sample);

// Looks up the expanded 16-bit sample for a given A-law codeword.
int16_t expand_lookup(uint8_t codeword);

#endif // LOOKUP_COMPANDER_H
