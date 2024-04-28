	.file	"string.c"
	.intel_syntax noprefix
	.text
	.globl	strcpy
	.type	strcpy, @function
strcpy:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi ; dest
	mov	QWORD PTR [rbp-32], rsi ; src
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L2
.L3:
	mov	rdx, QWORD PTR [rbp-32]
	lea	rax, [rdx+1]
	mov	QWORD PTR [rbp-32], rax
	mov	rax, QWORD PTR [rbp-8]
	lea	rcx, [rax+1]
	mov	QWORD PTR [rbp-8], rcx
	movzx	edx, BYTE PTR [rdx]
	mov	BYTE PTR [rax], dl
.L2:
	mov	rax, QWORD PTR [rbp-32]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L3
	mov	rax, QWORD PTR [rbp-24]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	strcpy, .-strcpy
	.globl	strlen
	.type	strlen, @function
strlen:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-4], 0
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L6
.L7:
	add	DWORD PTR [rbp-4], 1
	add	QWORD PTR [rbp-16], 1
.L6:
	mov	rax, QWORD PTR [rbp-16]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L7
	mov	eax, DWORD PTR [rbp-4]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	strlen, .-strlen
	.globl	memcpy
	.type	memcpy, @function
memcpy:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	DWORD PTR [rbp-52], edx
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rbp-16], rax
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rbp-24], rax
	mov	DWORD PTR [rbp-4], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-4]
	movsx	rcx, edx
	mov	rdx, QWORD PTR [rbp-16]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	DWORD PTR [rbp-4], 1
.L10:
	mov	eax, DWORD PTR [rbp-4]
	cmp	eax, DWORD PTR [rbp-52]
	jb	.L11
	mov	rax, QWORD PTR [rbp-40]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	memcpy, .-memcpy
	.globl	memset
	.type	memset, @function
memset:
.LFB3:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	DWORD PTR [rbp-32], edx
	mov	rax, QWORD PTR [rbp-24]
	mov	QWORD PTR [rbp-16], rax
	mov	QWORD PTR [rbp-8], 0
	jmp	.L14
.L15:
	mov	rdx, QWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-16]
	add	rax, rdx
	mov	edx, DWORD PTR [rbp-28]
	mov	BYTE PTR [rax], dl
	add	QWORD PTR [rbp-8], 1
.L14:
	mov	eax, DWORD PTR [rbp-32]
	cmp	QWORD PTR [rbp-8], rax
	jl	.L15
	mov	rax, QWORD PTR [rbp-24]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	memset, .-memset
	.ident	"GCC: (GNU) 13.2.0"
