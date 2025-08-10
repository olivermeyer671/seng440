# compiler and flags
CC = gcc
CFLAGS = -Iinclude -mfpu=neon -march=armv7-a -O3

# source files
SRCS = source/main.c source/scalar_compander.c source/simd_compander.c source/lookup_compander.c

# object files
OBJS = build/main.o build/scalar_compander.o build/simd_compander.o build/lookup_compander.o

# executable output
TARGET = build/compander

# default rule
all: $(TARGET)

# build executable
$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET)

# compile the .o files 
build/main.o: source/main.c
	$(CC) $(CFLAGS) -c source/main.c -o build/main.o

build/scalar_compander.o: source/scalar_compander.c
	$(CC) $(CFLAGS) -c source/scalar_compander.c -o build/scalar_compander.o

build/simd_compander.o: source/simd_compander.c
	$(CC) $(CFLAGS) -c source/simd_compander.c -o build/simd_compander.o

build/lookup_compander.o: source/lookup_compander.c
	$(CC) $(CFLAGS) -c source/lookup_compander.c -o build/lookup_compander.o

# clean
clean:
	rm -rf build/*

# run with default input
run: $(TARGET)
	$(TARGET) inputs/karma.wav


