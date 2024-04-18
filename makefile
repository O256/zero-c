.PHONY: all run clean

all: run

run: mbr.bin
	qemu-system-x86_64 mbr.bin

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin