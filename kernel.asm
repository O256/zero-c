[bits 32] ; 这里声明按照32位指令汇编

; C0H0S2
begin:
    mov ax, 00011_00_0b ; 选择3号段，数据段
    mov ss, ax ; 设置栈段寄存器

    mov eax, 0x1000
    mov esp, eax ; 设置栈指针
    mov ebp, eax ; 记录初始栈顶

    mov ax, 00010_00_0b; 选择2号段，显存段
    mov ds, ax ; 设置数据段寄存器

    mov [es:0x2000], dword 0

    mov al, byte 'H'
    mov ah, byte 0x0f ; 白底黑字
    push eax
    call print
    pop eax
    call print1

    hlt

print1:
    mov al, byte 'e'
    mov ah, byte 0x0f ; 白底黑字
    push eax
    call print
    pop eax

    mov al, byte 'l'
    mov ah, byte 0x0f ; 白底黑字
    push eax
    call print
    pop eax

    mov al, byte 'l'
    mov ah, byte 0x0f ; 白底黑字
    push eax
    call print
    pop eax

    mov al, byte '0'
    mov ah, byte 0x0f ; 白底黑字
    push eax
    call print
    pop eax

print:
    push ebp
    mov ebp, esp
    push eax
    push edx
    mov edx, [ss: ebp + 8]
    mov eax, [es: 0x2000]
    sal eax, 1
    mov [eax], dx
    inc dword [es: 0x2000]

    pop edx
    pop eax
    pop ebp
    ret

times 1024-($-begin) db 0 ; 填充剩余的空间
