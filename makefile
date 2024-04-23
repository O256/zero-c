.PHONY: all run clean

all: run

run: mbr.bin
	bochs -qf bochsrc
	# bochsdbg -qf bochsrc

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin