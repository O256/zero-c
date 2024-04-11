.PHONY: all
all: mbr.bin

mbr.bin: mbr.nas
	nasm mbr.nas -o mbr.bin

.PHONY: clean
clean:
	-del -f .DS_Store
	-del -f *.bin 