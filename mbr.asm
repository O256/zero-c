mov ax, 0xb800
mov ds, ax
mov [0x0000], byte 'H'
hlt

times 510-($-$$) db 0
dw 0xaa55