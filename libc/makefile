.PHONY: all
all: libc.a

font.o: font.c
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin font.c -o font.o

stdio.o: stdio.c include/stdio.h
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin stdio.c -o stdio.o

string.o: string.c include/string.h
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin string.c -o string.o

math.o: string.c include/math.h
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin math.c -o math.o

asm_func.o: asm_func.nas
	nasm asm_func.nas -f elf64 -o asm_func.o

libc.a: asm_func.o stdio.o string.o math.o font.o
# $^表示所有依赖文件
# ar是制作静态链接库的工具
	x86_64-elf-ar -crv --target=elf64-x86-64 libc.a $^

.PHONY: clean
clean:
	-del -f *.o libc.a