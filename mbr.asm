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

;配置GDT
mov ax, 0x07e0 
mov es, ax 

;空白段
mov [es:0x00], dword 0 ; 基址
mov [es:0x04], dword 0 ; 大小

;1号段
;基址0x8000,大小8KB
mov [es:0x08], word 0x1fff ; Limit=0x1fff
mov [es:0x0a], word 0x8000 ; Base=0x008000，这是低16位
mov [es:0x0c], byte 0 ; 这是Base的高8位
mov [es:0x0d], byte 1_00_1_100_0b ; P=1, DPL=0, S=1, Type=100b, A=0
mov [es:0x0e], byte 0_1_00_0000b  ; G=0, D/B=1, AVL=00, Limit的高4位是0000
mov [es:0x0f], byte 0 ; Base的高8位

;2号段
;基址0xb8000,上限0xb8f9f,覆盖所有显存
mov [es:0x10], word 0xf9f ; Limit=0xf9f
mov [es:0x12], word 0xb8000 ; Base=0x00b8000，这是低16位
mov [es:0x14], byte 0xb ; 这是Base的高8位
mov [es:0x15], byte 1_00_1_001_0b ; P=1, DPL=0, S=1, Type=100b, A=0
mov [es:0x16], byte 0_1_00_0000b  ; G=0, D/B=1, AVL=00, Limit的高4位是0000
mov [es:0x07], byte 0 ; Base的高8位

;3号段
;基址0x20000,大小4MB
mov [es:0x18], word 0x3ff ; Limit=0x3ff, 这是低8位
mov [es:0x1a], word 0x0000 ; Base=0x20000，这是低16位
mov [es:0x1c], byte 0x02 ; 这是Base的高8位
mov [es:0x1d], byte 1_00_1_001_0b ; P=1, DPL=0, S=1, Type=001b, A=0
mov [es:0x1e], byte 1_1_00_0000b  ; G=1, D/B=1, AVL=00, Limit的高4位是0000
mov [es:0x1f], byte 0x00 ; Base的高8位

; 下面是gdt信息的配置
mov ax, 0x07f0
mov es, ax
mov [es:0x00], word 31 ; GDT的大小
mov [es:0x02], dword 0x7e00 ; GDT的基址
lgdt [es:0x00]

mov eax, cr0
or eax, 0x01
mov cr0, eax

jmp 00001_00_0b:0

times 510-($-$$) db 0
dw 0xaa55


