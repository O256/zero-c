.PHONY: all clean

all: libc.a

libc.a: stdio.c func.asm string.c
	nasm -f elf func.asm -o func.o
	x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin stdio.c -o stdio.o
	x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin string.c -o string.o
	x86_64-elf-ar -crv --target=elf32-i386 libc.a stdio.o func.o string.o

clean:
	-del -f *.o
	-del -f libc.a