[bits 32] ; 这里声明按照32位指令汇编

; C0H0S2
begin:
    mov ax, 00011_00_0b ; 选择3号段，数据段
    mov ss, ax ; 设置栈段寄存器

    mov ax, 00010_00_0b; 选择2号段，显存段
    mov ds, ax ; 设置数据段寄存器

    push 0x0f420f41; 0x0f41是字符‘A’的ASCII码, 0x0f42是字符‘B’的ASCII码
    pop edx; 将字符‘A’‘B’的ASCII码压入edx寄存器
    mov [0x0000], edx; 将edx寄存器的值存入0x0000地址处

    hlt ; 暂停CPU
    times 1024-($-begin) db 0 ; 填充剩余的空间
