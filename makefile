.PHONY: all run clean

all: run

run: mbr.bin
	bochsdbg -qf bochsrc

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin