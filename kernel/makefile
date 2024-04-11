.PHONY: all
all: kernel_final.bin

kernel.o: kernel.nas
	nasm kernel.nas -f elf64 -o kernel.o

graphic_ui.o: graphic_ui.cpp graphic_ui.hpp
	x86_64-elf-g++ -c -std=c++17 -m64 -march=x86-64 -fno-builtin -I../libc/include graphic_ui.cpp -o graphic_ui.o -Wall -Werror -Wextra

main.o: main.cpp graphic_ui.hpp
	x86_64-elf-g++ -c -std=c++17 -m64 -march=x86-64 -fno-builtin -I../libc/include main.cpp -o main.o -Wall -Werror -Wextra

entry.o: entry.c ../libc/include/stdio.h
# 需要用-I制定头文件扫描位置
	x86_64-elf-gcc -c -m64 -march=x86-64 -fno-builtin -I../libc/include entry.c -o entry.o -Wall -Werror -Wextra

../libc/libc.a:
# pushd ../libc && $(MAKE) clean && $(MAKE)  libc.a && popd
	cd ../libc && make libc.a && cd ../kernel

kernel_final.out: kernel.o entry.o main.o graphic_ui.o ../libc/libc.a 
# 需要用-L指定静态链接库位置
# -lc表示链接libc.a
# 注意kernel.o要放在第一个
	x86_64-elf-ld -m elf_x86_64 -Ttext=0x8000 kernel.o entry.o main.o graphic_ui.o -L../libc -lc -o kernel_final.out

kernel_final.bin: kernel_final.out
	x86_64-elf-objcopy -I elf64-x86-64 -S -R ".eh_frame" -R ".comment" -O binary kernel_final.out kernel_final.bin

.PHONY: clean
clean:
	-del -f .DS_Store
	-del -f *.bin 
	-del -f *.o
	-del -f *.out