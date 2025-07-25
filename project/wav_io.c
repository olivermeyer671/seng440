#include <stdio.h>
#include <stdint.h>

int main(int argc, char *argv[]) {

    if (argc != 3) {
        printf("Incorrect arguments, please use: %s input_file.wav output_file.wav\n", argv[0]);
        return(1);
    }

    FILE *input_file = fopen(argv[1], "rb");
    if (!input_file) {
        perror("input_file failed to open\n");
        return(1);
    }
    FILE *output_file = fopen(argv[2], "wb");
    if (!output_file){
        perror("output_file failed to open\n");
        return(1);
    }

    uint8_t header[44];
    fread(header, 1, 44, input_file);
    fwrite(header, 1, 44, output_file);

    int16_t sample;
    while(fread(&sample, sizeof(int16_t), 1, input_file) == 1) {

        //Modify the input sample here
        int16_t new_sample = sample / 10;


        fwrite(&new_sample, sizeof(int16_t), 1, output_file);
    }

    fclose(input_file);
    fclose(output_file);

    return(0);
}