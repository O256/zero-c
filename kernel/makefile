.PHONY: all clean

all: kernel.bin

libc.a: 
	pushd "../libc/" && $(MAKE) libc.a && popd
# cd ../libc && $(MAKE) clean && $(MAKE) libc.a && cd ../kernel

kernel.bin: kernel.asm entry.c libc.a
	x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin -I../libc/include/ entry.c -o entry.o
	nasm kernel.asm -f elf -o kernel.o
	x86_64-elf-ld -m elf_i386 -Ttext=0 kernel.o entry.o -L../libc/ -lc -o kernel.out
	x86_64-elf-objcopy -I elf32-i386 -S -R ".eh_frame" -R ".comment" -O binary kernel.out kernel.bin

clean: 
	-del -f *.o
	-del -f *.out
	-del -f *.bin
