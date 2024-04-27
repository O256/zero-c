.PHONY: all clean

all: libc.a

libc.a: stdio.c func.asm string.c draw.c font.c
	nasm -f elf func.asm -o func.o
	x86_64-elf-gcc -c -m32 -fno-builtin -march=i386 stdio.c -o stdio.o
	x86_64-elf-gcc -c -m32 -fno-builtin -march=i386 string.c -o string.o
	x86_64-elf-gcc -c -m32 -fno-builtin -march=i386 draw.c -o draw.o
	x86_64-elf-gcc -c -m32 -fno-builtin -march=i386 font.c -o font.o
	x86_64-elf-ar -crv --target=elf32-i386 libc.a stdio.o func.o string.o draw.o font.o

clean:
	-del -f *.o
	-del -f libc.a