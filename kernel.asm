; C0H0S2
begin:
    mov ax, 00010_00_0b ; 选择2号段，0号偏移，显存段
    mov ds, ax
    mov [0x0000], byte 'H'
    mov [0x0001], byte 0x0f
    mov [0x0002], byte 'e'
    mov [0x0003], byte 0x0f
    mov [0x0004], byte 'l'
    mov [0x0005], byte 0x0f
    mov [0x0006], byte 'l'
    mov [0x0007], byte 0x0f
    mov [0x0008], byte 'o'
    mov [0x0009], byte 0x0f
    mov [0x000a], byte ' '
    mov [0x000b], byte 0x0f
    mov [0x000c], byte 'W'
    mov [0x000d], byte 0x0f
    mov [0x000e], byte 'o'
    mov [0x000f], byte 0x0f
    mov [0x0010], byte 'r'
    mov [0x0011], byte 0x0f
    mov [0x0012], byte 'l'
    mov [0x0013], byte 0x0f
    mov [0x0014], byte 'd'
    mov [0x0015], byte 0x0f
    mov [0x0016], byte '!'
    mov [0x0017], byte 0x0f

    hlt ; 暂停CPU
    times 1024-($-begin) db 0 ; 填充剩余的空间
