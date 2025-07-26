#ifndef SCALAR_COMPANDER_H
#define SCALAR_COMPANDER_H

#include <stdint.h>


// FUNCTIONS


uint8_t compress_scalar(int16_t sample);


int16_t expand_scalar(uint8_t compressed_codeword);


#endif