.PHONY: all clean build_asm

all: kernel.bin

libc.a:
	pushd "../libc/" && $(MAKE) libc.a && popd
# cd ../libc && $(MAKE) clean && $(MAKE) libc.a && cd ../kernel

kernel.bin: kernel.asm entry.c libc.a main.cpp
# x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin -I../libc/include/ entry.c -o entry.o
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin -I../libc/include/ entry.c -o entry.o
	x86_64-elf-g++ -c -m64 -march=x86-64 -fno-builtin -I../libc/include/ main.cpp -o main.o
	nasm kernel.asm -f elf64 -o kernel.o
# x86_64-elf-ld -m elf_i386 -Ttext=0 kernel.o entry.o -L../libc/ -lc -o kernel.out
# x86_64-elf-objcopy -I elf32-i386 -S -R ".eh_frame" -R ".comment" -O binary kernel.out kernel.bin
	x86_64-elf-ld -m elf_x86_64 -Ttext=0x8000 kernel.o entry.o main.o -L../libc/ -lc -o kernel.out
	x86_64-elf-objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary kernel.out kernel.bin

build_asm:
	x86_64-elf-gcc -S -masm=intel -m64 -march=x86-64 -fno-builtin -I../libc/include/ entry.c -o entry.s

clean:
	-rm -f *.o
	-rm -f *.out
	-rm -f *.bin
