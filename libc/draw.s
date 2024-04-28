	.file	"draw.c"
	.intel_syntax noprefix
	.text
	.globl	SetBackground
	.type	SetBackground, @function
SetBackground:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	eax, edi
	mov	BYTE PTR [rbp-20], al
	mov	DWORD PTR [rbp-4], 0
	jmp	.L2
.L3:
	movzx	edx, BYTE PTR [rbp-20]
	mov	eax, DWORD PTR [rbp-4]
	cdqe
	mov	esi, edx
	mov	rdi, rax
	call	SetVMem
	add	DWORD PTR [rbp-4], 1
.L2:
	cmp	DWORD PTR [rbp-4], 63999
	jle	.L3
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	SetBackground, .-SetBackground
	.globl	SetPixel
	.type	SetPixel, @function
SetPixel:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	DWORD PTR [rbp-20], edi
	mov	DWORD PTR [rbp-24], esi
	mov	eax, edx
	mov	BYTE PTR [rbp-28], al
	mov	edx, DWORD PTR [rbp-24]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	sal	eax, 6
	mov	edx, eax
	mov	eax, DWORD PTR [rbp-20]
	add	eax, edx
	cdqe
	mov	QWORD PTR [rbp-8], rax
	movzx	edx, BYTE PTR [rbp-28]
	mov	rax, QWORD PTR [rbp-8]
	mov	esi, edx
	mov	rdi, rax
	call	SetVMem
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	SetPixel, .-SetPixel
	.globl	DrawRect
	.type	DrawRect, @function
DrawRect:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	DWORD PTR [rbp-20], edi
	mov	DWORD PTR [rbp-24], esi
	mov	DWORD PTR [rbp-28], edx
	mov	DWORD PTR [rbp-32], ecx
	mov	eax, r8d
	mov	BYTE PTR [rbp-36], al
	mov	eax, DWORD PTR [rbp-24]
	mov	DWORD PTR [rbp-4], eax
	jmp	.L6
.L9:
	mov	eax, DWORD PTR [rbp-20]
	mov	DWORD PTR [rbp-8], eax
	jmp	.L7
.L8:
	movzx	edx, BYTE PTR [rbp-36]
	mov	ecx, DWORD PTR [rbp-4]
	mov	eax, DWORD PTR [rbp-8]
	mov	esi, ecx
	mov	edi, eax
	call	SetPixel
	add	DWORD PTR [rbp-8], 1
.L7:
	mov	edx, DWORD PTR [rbp-20]
	mov	eax, DWORD PTR [rbp-28]
	add	eax, edx
	cmp	DWORD PTR [rbp-8], eax
	jl	.L8
	add	DWORD PTR [rbp-4], 1
.L6:
	mov	edx, DWORD PTR [rbp-24]
	mov	eax, DWORD PTR [rbp-32]
	add	eax, edx
	cmp	DWORD PTR [rbp-4], eax
	jl	.L9
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	DrawRect, .-DrawRect
	.globl	DrawChar
	.type	DrawChar, @function
DrawChar:
.LFB3:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	DWORD PTR [rbp-20], edi
	mov	DWORD PTR [rbp-24], esi
	mov	eax, ecx
	mov	BYTE PTR [rbp-28], dl
	mov	BYTE PTR [rbp-32], al
	movsx	eax, BYTE PTR [rbp-28]
	mov	edi, eax
	call	GetFont
	mov	QWORD PTR [rbp-16], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L11
.L15:
	mov	DWORD PTR [rbp-8], 0
	jmp	.L12
.L14:
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movzx	edx, al
	mov	eax, 7
	sub	eax, DWORD PTR [rbp-8]
	mov	ecx, eax
	sar	edx, cl
	mov	eax, edx
	and	eax, 1
	test	eax, eax
	je	.L13
	movzx	eax, BYTE PTR [rbp-32]
	mov	ecx, DWORD PTR [rbp-24]
	mov	edx, DWORD PTR [rbp-4]
	lea	esi, [rcx+rdx]
	mov	ecx, DWORD PTR [rbp-20]
	mov	edx, DWORD PTR [rbp-8]
	add	ecx, edx
	mov	edx, eax
	mov	edi, ecx
	call	SetPixel
.L13:
	add	DWORD PTR [rbp-8], 1
.L12:
	cmp	DWORD PTR [rbp-8], 7
	jle	.L14
	add	DWORD PTR [rbp-4], 1
.L11:
	cmp	DWORD PTR [rbp-4], 15
	jle	.L15
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	DrawChar, .-DrawChar
	.ident	"GCC: (GNU) 13.2.0"
