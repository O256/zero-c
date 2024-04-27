.PHONY: all clean

all: libc.a

libc.a: stdio.c func.asm string.c draw.c font.c
	nasm -f elf64 func.asm -o func.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin stdio.c -o stdio.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin string.c -o string.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin draw.c -o draw.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin font.c -o font.o
	x86_64-elf-ar -crv --target=elf64-x86-64 libc.a stdio.o func.o string.o draw.o font.o

clean:
	-del -f *.o
	-del -f libc.a