

// BATCH WAV IO

// main function (runs the batch companding functions on wav file input, outputs to wav file)
int main(int argc, char *argv[]) {
    // validate arguments
    if (argc != 3) {
        printf("Incorrect arguments, please use: %s input_file.wav output_file.wav\n", argv[0]);
        return(1);
    }

    // open input_file and output_file
    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {
        perror("input_file failed to open");
        return(1);
    }
    FILE *output_file = fopen(argv[2], "wb");
    if (!output_file){
        perror("output_file failed to open");
        return(1);
    }

    // copy wav header from input_file to output_file
    uint8_t header[44];
    fread(header, 1, 44, input_file);
    fwrite(header, 1, 44, output_file);

    // compand samples from the input_file in batches (of up to 8 samples per batch) and write them to the output_file
    Batch16Bit input_batch;
    while((input_batch.count = (uint8_t)fread(input_batch.data, sizeof(int16_t), 8, input_file)) > 0) {
        Batch8Bit compressed_batch = compress_batch(input_batch);
        Batch16Bit decompressed_batch = expand_batch(compressed_batch);
        fwrite(decompressed_batch.data, sizeof(int16_t), decompressed_batch.count, output_file);
    }

    // close input_file and output_file
    fclose(input_file);
    fclose(output_file);
    
    // return without errors
    return 0;
}



int main(int argc, char *argv[]) {
    
    if (argc != 3) {
        printf("Incorrect arguments, please use: %s input_file.wav output_file.wav\n", argv[0]);
        return(1);
    }

    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {
        perror("input_file failed to open");
        return(1);
    }
    FILE *output_file = fopen(argv[2], "wb");
    if (!output_file){
        perror("output_file failed to open");
        return(1);
    }

    uint8_t header[44];
    fread(header, 1, 44, input_file);
    fwrite(header, 1, 44, output_file);

    int16_t sample;
    while(fread(&sample, sizeof(int16_t), 1, input_file) == 1) {

        uint8_t compressed_codeword = compress2(sample);
        int16_t new_sample = expand2(compressed_codeword);


        fwrite(&new_sample, sizeof(int16_t), 1, output_file);
    }

    fclose(input_file);
    fclose(output_file);
       
    // TEST BENCHMARK CODE
    /*

    int16_t inputs[8] = {
        0b0000000000011110,
        0b0000000000111110,
        0b0000000001111100,
        0b0000000011111000,
        0b0000000111110000,
        0b0000001111100000,
        0b0000011111000000,
        0b0000111110000000,
    };

    for (int i=0; i<=7; i++) {
       
        uint8_t compressed_codeword = compress2(inputs[i]);
        int16_t new_sample = expand2(compressed_codeword);
        printf("Input: %d, Codeword: %d, Output: %d\n", inputs[i], compressed_codeword, new_sample);
    }

    
void print_binary16(uint16_t val) {
    for (int i = 15; i >= 0; i--) {
        printf("%d", (val >> i) & 1);
        if (i % 4 == 0) printf(" "); 
    }
}

int main() {
    int16_t inputs[16] = {
        0b0000000000000000,
        0b0000000011110000,
        0b0000000100000000,
        0b0000000111110000,
        0b0000001000000000,
        0b0000001111100000,
        0b0000010000000000,
        0b0000011111000000,
        0b0000100000000000,
        0b0000111110000000,
        0b0001000000000000,
        0b0001111100000000,
        0b0010000000000000,
        0b0011111000000000,
        0b0100000000000000,
        12345//0b0111110000000000
    };

    for (int i = 0; i <= 15; i++) {
        uint8_t compressed_codeword = compress1(inputs[i]) ^ 0x55;
        int16_t new_sample = expand1(compressed_codeword ^ 0x55);

        printf("Input:            ");
        print_binary16((uint16_t)inputs[i]);
        printf("  (%5d)\n", inputs[i]);

        printf("Input >> 3:       ");
        print_binary16((uint16_t)inputs[i] >> 3);
        printf("  (%5d)\n", inputs[i] >> 3);

        printf("Compressed Code:  ");
        print_binary16((uint16_t)compressed_codeword);
        printf("  (%5d)\n", compressed_codeword);

        printf("Expanded Out >> 3:");
        print_binary16((uint16_t)new_sample >> 3);
        printf("  (%5d)\n", new_sample >> 3);

        printf("Expanded Output:  ");
        print_binary16((uint16_t)new_sample);
        printf("  (%5d)\n", new_sample);

        printf("--------------------------------------------------\n");
    }

    for (int i = 0; i <=15; i++) {
        inputs[i] *= -1;
    }
    
    printf("\n\nNEGATIVE INPUTS:\n\n");
    for (int i = 0; i <= 15; i++) {
        uint8_t compressed_codeword = compress1(inputs[i]) ^ 0x55;
        int16_t new_sample = expand1(compressed_codeword ^ 0x55);

        printf("Input:            ");
        print_binary16((uint16_t)inputs[i]);
        printf("  (%5d)\n", inputs[i]);

        printf("Input >> 3:       ");
        print_binary16((uint16_t)inputs[i] >> 3);
        printf("  (%5d)\n", inputs[i] >> 3);

        printf("Compressed Code:  ");
        print_binary16((uint16_t)compressed_codeword);
        printf("  (%5d)\n", compressed_codeword);

        printf("Expanded Out >> 3:");
        print_binary16((uint16_t)new_sample >> 3);
        printf("  (%5d)\n", new_sample >> 3);

        printf("Expanded Output:  ");
        print_binary16((uint16_t)new_sample);
        printf("  (%5d)\n", new_sample);

        printf("--------------------------------------------------\n");
    }
    */

    return(0);
}


