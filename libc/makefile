.PHONY: all clean

all: libc.a

libc.a: stdio.c func.asm
	nasm -f elf func.asm -o func.o
	x86_64-elf-gcc -c -m32 -march=i386 stdio.c -o stdio.o
	ar rcs libc.a stdio.o func.o

clean:
	-del -f *.o
	-del -f libc.a