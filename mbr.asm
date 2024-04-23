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
mov al, 0x01 ; 读取第二个扇区
out dx, al

mov dx, 0x01f4 
mov al, 0x00 
out dx, al

mov dx, 0x01f5 
mov al, 0x00 
out dx, al

; 设置读取硬盘的LBA模式
mov dx, 0x01f6
mov al, 111_0_0000b ; 低4位为0，高4位为1，表示LBA模式，第4位为1表示主盘
out dx, al 

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


