; 默认为VGA模式，显示字符'H'
; 80×25×16色， 一个字符占2个字节，一个字符对应一个字符单元，字符+颜色信息
; 颜色信息：0-2位为背景色，4-6位为前景色，7位为闪烁，3位是否高亮
; 对应的显存地址范围为0xb8000~0xb8f9f
; 三大流行汇编风格：AT&T、Intel、NASM
; 对应的汇编器分别位：gas、masm、nasm

mov al, 0x03
mov ah, 0x00
int 0x10

mov ax, 0xb800
mov ds, ax
mov [0x0000], byte 'H'
mov [0x0001], byte 0x0f

mov [0x0002], byte 'e'
mov [0x0003], byte 0x8f

mov [0x0004], byte 'l'
mov [0x0005], byte 0x0f

mov [0x0006], byte 'l'
mov [0x0007], byte 0x0f

mov [0x0008], byte 'o'
mov [0x0009], byte 0x0f

mov [0x000a], byte ' '
mov [0x000b], byte 0x0f

hlt

times 510-($-$$) db 0
dw 0xaa55