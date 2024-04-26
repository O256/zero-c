.PHONY: all run clean

all: run

run: a.img
# bochs -qf bochsrc
	bochsdbg -qf bochsrc

mbr/mbr.bin:
	pushd mbr && $(MAKE) clean && $(MAKE) mbr.bin && popd

kernel/kernel.bin:
	pushd kernel && $(MAKE) clean && $(MAKE) kernel.bin && popd

a.img: mbr/mbr.bin kernel/kernel.bin
	dd if=/dev/zero of=a.img bs=512 count=2000000
	dd if=mbr/mbr.bin of=a.img bs=512 count=1 conv=notrunc
	dd if=kernel/kernel.bin of=a.img bs=512 count=10 seek=1 conv=notrunc

clean:
	pushd mbr && $(MAKE) clean && popd
	pushd kernel && $(MAKE) clean && popd
	pushd libc && $(MAKE) clean && popd

	-del -f *.img
	-del -f *.lock
	
