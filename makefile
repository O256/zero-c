.PHONY: all run clean

all: run

run: a.img
	bochsdbg -qf bochsrc
# bochs -qf bochsrc

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin

kernel.bin: kernel.asm entry.c
	x86_64-elf-gcc -c -m32 -march=i386 entry.c -o entry.o
# x86_64-elf-gcc -S -masm=intel -c -m32 -march=i386 entry.c -o entry.gas
	nasm kernel.asm -f elf -o kernel.o
	x86_64-elf-ld -m elf_i386 kernel.o entry.o -o kernel.out
	x86_64-elf-objcopy -I elf32-i386 -S -R ".eh_frame" -R ".comment" -O binary kernel.out kernel.bin
# nasm -fbin kernel.asm -o kernel.bin

a.img: mbr.bin kernel.bin
	dd if=/dev/zero of=a.img bs=512 count=20000
	dd if=mbr.bin of=a.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=a.img bs=512 count=1 seek=1 conv=notrunc

clean:
	-del -f *.bin
	-del -f *.img
	-del -f *.out
	-del -f *.o
	-del -f *.gas