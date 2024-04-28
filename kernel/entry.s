	.file	"entry.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"ABC123~~"
.LC1:
	.string	"Hello, World!\n%s\n%d"
	.text
	.globl	Entry
	.type	Entry, @function
Entry:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	edi, 15
	call	SetBackground
	mov	QWORD PTR [rbp-8], OFFSET FLAT:.LC0
	mov	DWORD PTR [rbp-12], 6
	mov	edx, DWORD PTR [rbp-12]
	mov	rax, QWORD PTR [rbp-8]
	mov	rsi, rax
	mov	edi, OFFSET FLAT:.LC1
	mov	eax, 0
	call	printf
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	Entry, .-Entry
	.ident	"GCC: (GNU) 13.2.0"
