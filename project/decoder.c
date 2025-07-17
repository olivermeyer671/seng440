/* 
# DECODER LOGIC

## PROCEDURE:
    1. Receive 8-bit compressed codeword in reverse byte order
    2. Reverse the byte order of the compressed codeword
    3. Extract Sign, Chord, and Step bits from the compressed codeword
    4. Use Chord number to determine 

## INPUT:
    - 8-Bit compressed codeword in reverse byte order


## OUTPUT:
    - 14-bit decompressed sample 
    - (but stored in 16-bit integer)

*/