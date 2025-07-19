/* 
# ENCODER LOGIC (A-Law)

## PROCEDURE:
    1. Extract sign, convert 2's complement sample to it's absolute magnitude representation
    2. Find the Chord (count the leading zeroes until most significant bit in sample)
    3. Extract the 4 step bits through masking
    4. Assemble Sign, Chord, and Step Bits into the compressed codeword (sign bit: 1 = negative for A-law)
    5. Invert the codeword bitwise (even bits only) for transmission

## INPUT:
    - Expects a 13-Bit sample in 2's complement format
    - .wav files:
        - Assuming LPCM Format:
            - Linear Pulse Code Modulation
            - 16-bit uncompressed audio samples
            - Sample rate of 44100 Hz
        - Discard the three least significant bits (through masking?) to get the 13-bit sample
        - Sample will be at minimum an int16_t (signed 16-bit integer defined in c99)
    - Example:
        - 16 bit signed integer input sample in 2's complement (2^16 possible values)
        - Range: (-2^15) -> (+2^15 - 1) = (-32,768 -> 32,767)
        - Assume 16 bit input of -12,345 in decimal (wav sample input will be in 2's complement binary)
        - Convert absolute to binary:                                                       0011 0000 0011 1001
        - Sign is negative, convert to negative 2's complement (invert bits and add 1):     1100 1111 1100 0111
        - This is the true input to our algorithm from the wav file.
        - Record first bit (sign bit) from input (1 is negative in 2's complement): sign bit = 1                                                                       
        - Convert to absolute value (invert bits and add 1):                                0011 0000 0011 1001     -> 0d12345
        - Shift right by 3 bits to get 13 bit input (13th bit is always zero):              0000 0110 0000 0111
        - Now have 12 magnitude bits:                                                       ---- 0110 0000 0111
        - Construct the compressed codeword from the sign bit, the position of the highest set magnitude bit, and four subsequent step bits
        - Sign bit: 1
        - Highest set magnitude bit position (12 bits [11,0]): 0110 0000 0111 -> Bit 10 is first set: corresponds to 6 in binary (range [7,0]): bx110
        - Four subsequent bits after the highest set magnitude bit (bits [9,6]): 10 00
        - Compressed codeword (sign bit | chord | step bits): 1110 1000
        - Invert even bits for transmission:                  1011 1101

    

## OUTPUT:
    - Returns an 8-Bit compressed codeword with inverted even bits (for transmission?)
    - At minimum will return an int8_t (signed 8-bit integer defined in c99)


## MASKING:
    - 

*/

int signum ( int sample ) {
    if( sample < 0)
        return(1) ; /* sign is ’1’ for negative samples */
    else:
        return(0) ; /* sign is ’0’ for positive samples */
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
