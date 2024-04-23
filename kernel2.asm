; C0H0S2
begin:
    ; 开启A20M，允许超1M的地址反转
    in al, 0x92 
    and al, 11111101b
    out 0x92, al

    mov ax, 0xff00
    mov es, ax

    mov [es:0xf000], byte 0xaa ; 实模式下，内存地址位 es << 4 + 0xf000 获得， 所以这里的地址是 0xff00 << 4 + 0xf000 = 0x10e000

    hlt ; 暂停CPU
    times 1024-($-begin) db 0 ; 填充剩余的空间
