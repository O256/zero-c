[bits 32]

global SetVMem
SetVMem:
    push ebp
    mov ebp, esp

    push ebx
    push ecx
    push edx

    mov bx, es
    mov dx, 00010_00_0b
    mov es, dx

    mov edx, [ebp + 8]
    mov ecx, [ebp + 12]
    mov [es:edx], cl

    mov es, bx
    pop edx
    pop ecx
    pop ebx

    mov esp, ebp
    pop ebp
    ret
