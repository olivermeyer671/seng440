/* 
# ENCODER LOGIC

## PROCEDURE:
    1. Convert sample to it's sign-magnitude representation
    2. Find the Chord (count the leading zeroes until most significant bit in sample)
    3. Extract the 4 step bits through masking
    4. Assemble Sign, Chord, and Step Bits into the compressed codeword
    5. Invert the codeword bitwise for transmission

## INPUT:
    - Expects a 14-Bit sample in 2's complement format
    - .wav files:
        - Assuming LPCM Format:
            - Linear Pulse Code Modulation
            - 16-bit uncompressed audio samples
            - Sample rate of 44100 Hz
        - Discard the two least significant bits (through masking?) to get the 14-bit sample
        - Sample will be at minimum an int16_t (signed 16-bit integer defined in c99)
    - Example:
        - 16 bit signed integer input sample in 2's complement (2^16 possible values)
        - Range: (-2^15) -> (+2^15 - 1) = (-32,768 -> 32,767)
        - Assume 16 bit input of -12,345 in decimal
        - Convert absolute to binary:                                               0011 0000 0011 1001
        - Convert to 2's complement (invert bits and add 1):                        1100 1111 1100 0111
        - Bit-shift two bits right to get 14-bit 2's complement integer:            1111 0011 1111 0001
        - Convert to sign-magnitude (sign is first bit, invert bits and add 1):     0000 1100 0000 1111
        - First bit was 1, therefore sign is negative. Now have 13 magnitude bits:     0 1100 0000 1111


## OUTPUT:
    - Returns an 8-Bit compressed codeword in reverse byte order (for transmission?)
    - At minimum will return an int8_t (signed 8-bit integer defined in c99)


## MASKING:
    - 

*/

int signum ( int sample ) {
    if( sample < 0)
        return( 0) ; /* sign is ’0’ for negative samples */
    else:
        return( 1) ; /* sign is ’1’ for positive samples */
}
int magnitude ( int sample ) {
    if( sample < 0) {
        sample = - sample ;
    }
    return( sample );
}

char codeword_compression ( unsigned int sample_magnitude , int sign ) {

    int chord , step ;
    int codeword_tmp ;

    if( sample_magnitude & (1 << 12) ) {
        chord = 0x7 ;
        step = ( sample_magnitude >> 8) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 11) ) {
        chord = 0x6 ;
        step = ( sample_magnitude >> 7) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 10) ) {
        chord = 0x5 ;
        step = ( sample_magnitude >> 6) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 9) ) {
        chord = 0x4 ;
        step = ( sample_magnitude >> 5) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
    if( sample_magnitude & (1 << 8) ) {
        chord = 0x3 ;
        step = ( sample_magnitude >> 4) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 7) ) {
        chord = 0x2 ;
        step = ( sample_magnitude >> 3) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 6) ) {
        chord = 0x1 ;
        step = ( sample_magnitude >> 2) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }

    if( sample_magnitude & (1 << 5) ) {
        chord = 0x0 ;
        step = ( sample_magnitude >> 1) & 0xF ;
        codeword_tmp = ( sign << 7) & ( chord << 4) & step ;
        return ( (char) codeword_tmp );
    }
}

int main() {
    int sample = -12345; // sample example
    int sign = signum(sample);
    unsigned int magnitude = magnitude(sample);
    int codeword = codeword_compression(magnitude, sign);
}
