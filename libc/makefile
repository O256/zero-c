.PHONY: all
all: libc.a

asm_func.o: asm_func.nas
	nasm asm_func.nas -f elf -o asm_func.o

stdio.o: stdio.c
	x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin -I./include/ stdio.c -o stdio.o

string.o: string.c
	x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin -I./include/ string.c -o string.o

libc.a: asm_func.o stdio.o string.o
	x86_64-elf-ar -crv --target=elf32-i386 libc.a $^

.PHONY: clean
clean: 
	-del -f *.o
	-del -f libc.a