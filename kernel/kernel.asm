[bits 32] ; 这里声明按照32位指令汇编
section .text

; C0H0S2
begin:
    mov ax, 00100_00_0b
    mov es, ax

    mov ecx, 1024
    mov ebx, 0x20000

    mov eax, 00100001_000_0_0_0_0_0_0_0_1_1b 
    mov [es:0x20000], eax

    ; 把0x21000~0x213ff范围的256个页表项进行配置，对应低1MB物理内存
    mov ecx, 256
    mov ebx, 0x21000
    mov edx, 0x00000_003

    .loop:
        mov [es:ebx], edx
        add ebx, 4
        add edx, 0x0001_000
        loop .loop
    
    mov eax, 00100000_00000000_0_0_00b ; 设置页目录表地址
    mov cr3, eax ; 设置页目录表地址    

    cli ; 关闭中断

    mov eax, cr0
    or eax, 0x80000000 ; 设置CR0的PG位
    mov cr0, eax ; 设置CR0的PG位

    

    mov ax, 00011_00_0b ; 选择3号段，数据段
    mov ss, ax ; 设置栈段寄存器
    mov ds, ax ; 设置数据段寄存器
    mov es, ax ; 设置附加段寄存器

    mov eax, 0x1000
    mov esp, eax ; 设置栈指针
    mov ebp, eax ; 记录初始栈顶

    extern Entry
    call Entry

    hlt

