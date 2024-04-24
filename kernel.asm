[bits 32] ; 这里声明按照32位指令汇编

; C0H0S2
begin:
    mov ax, 00011_00_0b ; 选择3号段，数据段
    mov ss, ax ; 设置栈段寄存器

    mov ax, 00010_00_0b; 选择2号段，显存段
    mov ds, ax ; 设置数据段寄存器

    mov [0x0000], byte '_'
    mov [0x0001], byte 0x0f
    mov [0x0002], byte '1'
    mov [0x0003], byte 0x0f
    mov [0x0004], byte '_'
    mov [0x0005], byte 0x0f

    call f_test

    mov [0x0030], byte '_'
    mov [0x0031], byte 0x0f
    mov [0x0032], byte '2'
    mov [0x0033], byte 0x0f
    mov [0x0034], byte '_'
    mov [0x0035], byte 0x0f

    hlt ; 暂停CPU

f_test:
    mov [0x0020], byte '_'
    mov [0x0021], byte 0x0f
    mov [0x0022], byte '3'
    mov [0x0023], byte 0x0f
    mov [0x0024], byte '_'
    mov [0x0025], byte 0x0f

    ret

times 1024-($-begin) db 0 ; 填充剩余的空间
