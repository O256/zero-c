[bits 64]
section .text 

global SetVMem ; 告诉链接器下面这个标签是外部可用的
SetVMem:
    ; 现场记录
    push rbp
    mov rbp, rsp
    ; 过程中用到的寄存器都要先记录
    push rbx
    push rcx
    push rdx

    ; 64位模式下不允许通过es偏移，所以只能设置ds
    mov bx, ds ; 用bx记录原本的ds，用于后续恢复现场（这里是因为寄存器还够用，如果不够用的话就还是要压栈）
    ; 把es配成数据
    mov dx, 00110_00_0b
    mov ds, dx
    ; 通过参数找到addr和data（64位优先用寄存器传参）
    mov rdx, rdi ; addr
    mov rcx, rsi ; data
    ; 通过偏移地址来操作显存（0xa0000是显存基址）
    mov [rdx+0xa0000], cl  ; 由于data是1字节的，所以其实只有cl是有效数据

    ; 现场还原
    mov ds, bx
    pop rdx
    pop rcx
    pop rbx
    mov rsp, rbp
    pop rbp
    ; 回跳
    ret