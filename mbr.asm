; C0H0S1
; 调用0x10号bios终端，清屏
mov al, 0x03 ; 功能号
mov ah, 0x00 ; 子功能号
int 0x10

; LBA28模式，逻辑扇区号28位，从0x0000000 ~ 0x0fffffff
; 设置读取的扇区数量

mov dx, 0x1f2 ; 读取扇区数量
mov al, 0x02 ; 读取2个扇区
out dx, al 

; 设置读取的起始扇区号
mov dx, 0x01f3 ; 读取起始扇区号
mov al, 0x02 ; 读取第二个扇区
out dx, al

mov dx, 0x01f4 
mov al, 0x00 
out dx, al

mov dx, 0x01f5 
mov al, 0x00 
out dx, al

; 设置读取硬盘的LBA模式
mov dx, 0x01f6
mov al, 0x00 ; 低4位为0，高4位为1，表示LBA模式，第4位为0表示主盘
out dx, al

; mov dx, 0x01f6
; mov al, 111_0_0000b ; 低4位为0，高4位为1，表示LBA模式，第4位为1表示主盘
; out dx, al 

; 读取硬盘数据
mov dx, 0x01f7
mov al, 0x20 ; 读取硬盘数据
out dx, al


; 等待硬盘准备好
wait_finish:
    mov dx, 0x01f7
    in al, dx
    and al, 1000_1000b ; 检查BSY和DRQ位
    cmp al, 0000_1000b ; 检查BSY和DRQ位

    jnz wait_finish

; 读取硬盘数据
mov cx, 512 ; 读取512个字节
mov dx, 0x01f0
mov ax, 0x0800
mov ds, ax
xor bx, bx; 偏移地址

read:
    in ax, dx
    mov [bx], ax
    add bx, 2
    loop read

jmp 0x0800:0x0000 ; 跳转到读取的数据
times 510-($-$$) db 0
dw 0xaa55

; C0H0S2
begin:
    mov ax, 0xb800
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

