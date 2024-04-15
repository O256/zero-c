.PHONY: all
all: sys

.PHONY: run
run: bochsrc sys
	bochsdbg -qf bochsrc

a.img:
	del -f a.img
	bximage -q -func=create -hd=4096M $@

mbr/mbr.bin:
	pushd mbr && $(MAKE) clean && $(MAKE) mbr.bin && popd

kernel/kernel_final.bin:
	pushd kernel && $(MAKE) clean && $(MAKE)  kernel_final.bin && popd

sys: a.img mbr/mbr.bin kernel/kernel_final.bin
	dd if=mbr/mbr.bin of=a.img conv=notrunc
	dd if=kernel/kernel_final.bin of=a.img bs=512 seek=1 conv=notrunc

.PHONY: clean
clean:
	-del -f .DS_Store
	-del -f *.img
	pushd mbr && $(MAKE) clean && popd
	pushd kernel && $(MAKE) clean && popd
	pushd libc && $(MAKE) clean && popd
