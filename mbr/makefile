.PHONY: all clean build_asm

all: mbr.bin

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin

clean:
	-rm -f *.bin
	-rm -f *.o