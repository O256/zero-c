.PHONY: all clean

all: mbr.bin

mbr.bin: mbr.asm
	nasm -fbin mbr.asm -o mbr.bin

clean:
	-del -f *.bin
	-del -f *.o