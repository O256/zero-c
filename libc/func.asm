; [bits 32]
[bits 64]

global SetVMem
SetVMem:
    ; push ebp
    ; mov ebp, esp

    ; push ebx
    ; push ecx
    ; push edx

    ; mov bx, es
    ; mov dx, 00010_00_0b
    ; mov es, dx

    ; mov edx, [ebp + 8]
    ; mov ecx, [ebp + 12]
    ; mov [es:edx], cl

    ; mov es, bx
    ; pop edx
    ; pop ecx
    ; pop ebx

    ; mov esp, ebp
    ; pop ebp
    ; ret
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx

    mov bx, ds
    mov dx, 00110_00_0b
    mov ds, dx

    mov rdx, rdi
    mov rcx, rsi
    mov [rdx+0xa0000], cl

    ; 还原现场
    mov ds, bx
    pop rdx
    pop rcx
    pop rbx
    mov rsp, rbp
    pop rbp
    ret
