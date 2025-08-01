#include "lookup_compander.h"
#include <stdio.h>
#include <stdlib.h>

#define NUM_SAMPLES 65536
#define NUM_CODEWORDS 256

// These arrays are populated from CSV at startup.
static uint8_t sample_to_codeword[NUM_SAMPLES];
static int16_t codeword_to_sample[NUM_CODEWORDS];

// Internal helper: load the compress lookup table from CSV.
static void load_compress_lookup(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Could not open compress lookup table: %s\n", filename);
        exit(EXIT_FAILURE);
    }
    char line[128];
    fgets(line, sizeof(line), file); // skip CSV header
    int sample, codeword, idx = 0;
    while (fgets(line, sizeof(line), file) && idx < NUM_SAMPLES) {
        if (sscanf(line, "%d,%d", &sample, &codeword) == 2) {
            sample_to_codeword[idx++] = (uint8_t)codeword;
        }
    }
    fclose(file);
    if (idx != NUM_SAMPLES) {
        fprintf(stderr, "Compress table rows: %d (expected %d)\n", idx, NUM_SAMPLES);
        exit(EXIT_FAILURE);
    }
}


int lookup_compander_regular(const char *filename) {
    FILE *in = fopen(filename, "rb");
    if (!in) {
        perror("input file failed to open");
        return 1;
    }
    FILE *out = fopen("outputs/lookup_regular.wav", "wb");
    if (!out) {
        perror("output file failed to open");
        fclose(in);
        return 1;
    }
    uint8_t header[44];
    fread(header, 1, 44, in);
    fwrite(header, 1, 44, out);

    int16_t sample;
    while (fread(&sample, sizeof(int16_t), 1, in) == 1) {
        uint8_t codeword = compress_lookup(sample);
        int16_t expanded = expand_lookup(codeword);
        fwrite(&expanded, sizeof(int16_t), 1, out);
    }

    fclose(in);
    fclose(out);
    return 0;
}



// Internal helper: load the expand lookup table from CSV.
static void load_expand_lookup(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Could not open expand lookup table: %s\n", filename);
        exit(EXIT_FAILURE);
    }
    char line[128];
    fgets(line, sizeof(line), file); // skip CSV header
    int codeword, sample, idx = 0;
    while (fgets(line, sizeof(line), file) && idx < NUM_CODEWORDS) {
        if (sscanf(line, "%d,%d", &codeword, &sample) == 2) {
            codeword_to_sample[idx++] = (int16_t)sample;
        }
    }
    fclose(file);
    if (idx != NUM_CODEWORDS) {
        fprintf(stderr, "Expand table rows: %d (expected %d)\n", idx, NUM_CODEWORDS);
        exit(EXIT_FAILURE);
    }
}

// Public: loads both lookup tables.
void load_lookup_tables(void) {
    // These filenames must match your CSVs in the working directory.
    load_compress_lookup("xlaw_compress_lookup.csv");
    load_expand_lookup("alaw_expand_lookup.csv");
}

// Public: returns the codeword for a 16-bit sample.
uint8_t compress_lookup(int16_t sample) {
    return sample_to_codeword[(uint16_t)(sample + 32768)];
}

// Public: returns the expanded sample for a codeword.
int16_t expand_lookup(uint8_t codeword) {
    return codeword_to_sample[codeword];
}


