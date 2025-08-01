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

// Runs the regular (non-pipelined) lookup-based compander.
// Input: path to WAV file.
// Output: writes to "outputs/lookup_regular.wav".
// Returns 0 on success, nonzero on error.
int lookup_compander_regular(const char *filename);

// Runs the pipelined lookup-based compander.
// Input: path to WAV file.
// Output: writes to "outputs/lookup_pipelined.wav".
// Returns 0 on success, nonzero on error.
int lookup_compander_pipelined(const char *filename);

#endif // LOOKUP_COMPANDER_H
