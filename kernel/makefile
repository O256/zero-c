.PHONY: all
all: kernel_final.bin

kernel.o: kernel.nas
	nasm kernel.nas -f elf -o kernel.o

entry.o: entry.c ../libc/include/stdio.h
# 需要用-I制定头文件扫描位置
	x86_64-elf-gcc -c -m32 -march=i386 -fno-builtin -I../libc/include entry.c -o entry.o

../libc/libc.a:
# pushd ../libc && $(MAKE) clean && $(MAKE) libc.a && popd
	cd ../libc && $(MAKE) clean && $(MAKE) libc.a && cd ../kernel

kernel_final.out: kernel.o entry.o ../libc/libc.a
# 需要用-L指定静态链接库位置
# -lc表示链接libc.a
# 注意kernel.o要放在第一个
	x86_64-elf-ld -m elf_i386 -Ttext=0 kernel.o entry.o -L../libc -lc -o kernel_final.out

kernel_final.bin: kernel_final.out
	x86_64-elf-objcopy -I elf32-i386 -S -R ".eh_frame" -R ".comment" -O binary kernel_final.out kernel_final.bin

.PHONY: clean
clean:
	-del -f .DS_Store
	-del -f *.bin 
	-del -f *.o
	-del -f *.out