.PHONY: all run clean

all: run

run: a.img
	bochsdbg -qf bochsrc
	# bochs -qf bochsrc

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin

kernel.bin: kernel.asm
	nasm -fbin kernel.asm -o kernel.bin

a.img: mbr.bin kernel.bin
	dd if=/dev/zero of=a.img bs=512 count=3
	dd if=mbr.bin of=a.img bs=512 count=1 conv=notrunc
	dd if=kernel.bin of=a.img bs=512 count=1 seek=1 conv=notrunc

clean:
	-del -f mbr.bin
	-del -f kernel.bin
	-del -f a.img