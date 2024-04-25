[bits 32] ; 这里声明按照32位指令汇编
section .text

; C0H0S2
begin:
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

