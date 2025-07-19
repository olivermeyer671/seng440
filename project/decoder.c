/* 
# DECODER LOGIC

## PROCEDURE:
    1. Receive 8-bit compressed codeword with inverted even bits
    2. Invert again the even bits of the compressed codeword
    3. Extract Sign, Chord, and Step bits from the compressed codeword (sign bit: 1 = negative for A-law)
    4. Use the 3 bits of the Chord number to determine position of the first set bit (no initial set bit in chord 0 for A-law)
    5. Following the first set bit, the step bits are added to the decompressed codeword.
    6. Now have 12 magnitude bits, along with a 13th bit that is always zero.
    7. Left-shift by 3 bits to get the 16 bit decompressed codeword in absolute value.
    8. If sign bit = 1 (is negative): Invert the bits and add 1.
    9. This is the decompressed sample.
    10. Return sample to wav file.

## INPUT:
    - 8-Bit compressed codeword with even bits inverted


## OUTPUT:
    - 16-bit decompressed sample 
    - (With only 13 significant bits)

*/