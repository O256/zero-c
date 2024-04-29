.PHONY: all clean build_asm

all: libc.a

libc.a: stdio.c func.asm string.c draw.c font.c math.c
	nasm -f elf64 func.asm -o func.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin stdio.c -o stdio.o
	x86_64-elf-gcc -c -m64 -march=x86-64 string.c -o string.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin draw.c -o draw.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin font.c -o font.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin math.c -o math.o

	x86_64-elf-g++ -c -std=c++17 -m64 -march=x86-64 -fno-builtin graphic.cpp -o graphic.o

	x86_64-elf-ar -crv --target=elf64-x86-64 libc.a stdio.o func.o string.o draw.o font.o graphic.o math.o

build_asm:
	x86_64-elf-gcc -S -masm=intel -m64 -march=x86-64 -fno-builtin stdio.c -o stdio.s
	x86_64-elf-gcc -S -masm=intel -m64 -march=x86-64 -fno-builtin string.c -o string.s
	x86_64-elf-gcc -S -masm=intel -m64 -march=x86-64 -fno-builtin draw.c -o draw.s
	x86_64-elf-gcc -S -masm=intel -m64 -march=x86-64 -fno-builtin font.c -o font.s

clean:
	-rm -f *.o
	-rm -f libc.a