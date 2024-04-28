	.file	"stdio.c"
	.intel_syntax noprefix
	.text
	.local	g_cursor_info
	.comm	g_cursor_info,16,16
	.globl	NextLine
	.type	NextLine, @function
NextLine:
.LFB0:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	QWORD PTR g_cursor_info[rip], 0
	mov	rax, QWORD PTR g_cursor_info[rip+8]
	add	rax, 16
	mov	QWORD PTR g_cursor_info[rip+8], rax
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	NextLine, .-NextLine
	.globl	NextChar
	.type	NextChar, @function
NextChar:
.LFB1:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, QWORD PTR g_cursor_info[rip]
	add	rax, 8
	mov	QWORD PTR g_cursor_info[rip], rax
	mov	rax, QWORD PTR g_cursor_info[rip]
	cmp	rax, 319
	jle	.L4
	mov	eax, 0
	call	NextLine
.L4:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	NextChar, .-NextChar
	.globl	PrevChar
	.type	PrevChar, @function
PrevChar:
.LFB2:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	rax, QWORD PTR g_cursor_info[rip]
	sub	rax, 1
	mov	QWORD PTR g_cursor_info[rip], rax
	mov	rax, QWORD PTR g_cursor_info[rip]
	test	rax, rax
	jns	.L7
	mov	QWORD PTR g_cursor_info[rip], 319
	mov	rax, QWORD PTR g_cursor_info[rip+8]
	sub	rax, 1
	mov	QWORD PTR g_cursor_info[rip+8], rax
.L7:
	nop
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	PrevChar, .-PrevChar
	.globl	putchar
	.type	putchar, @function
putchar:
.LFB3:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR [rbp-4], edi
	cmp	DWORD PTR [rbp-4], 10
	jne	.L9
	mov	eax, 0
	call	NextLine
	jmp	.L10
.L9:
	mov	eax, DWORD PTR [rbp-4]
	movsx	eax, al
	mov	rdx, QWORD PTR g_cursor_info[rip+8]
	mov	esi, edx
	mov	rdx, QWORD PTR g_cursor_info[rip]
	mov	edi, edx
	mov	ecx, 1
	mov	edx, eax
	call	DrawChar
	mov	eax, 0
	call	NextChar
.L10:
	mov	eax, DWORD PTR [rbp-4]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	putchar, .-putchar
	.globl	puts
	.type	puts, @function
puts:
.LFB4:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR [rbp-8], rdi
	jmp	.L13
.L14:
	mov	rax, QWORD PTR [rbp-8]
	lea	rdx, [rax+1]
	mov	QWORD PTR [rbp-8], rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar
.L13:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L14
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	puts, .-puts
	.type	int_to_string, @function
int_to_string:
.LFB5:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	eax, edx
	mov	BYTE PTR [rbp-32], al
	cmp	BYTE PTR [rbp-32], 16
	ja	.L17
	cmp	BYTE PTR [rbp-32], 1
	ja	.L18
.L17:
	mov	eax, 0
	jmp	.L19
.L18:
	cmp	DWORD PTR [rbp-28], 0
	jne	.L20
	mov	rax, QWORD PTR [rbp-24]
	mov	BYTE PTR [rax], 48
	mov	eax, 1
	jmp	.L19
.L20:
	mov	DWORD PTR [rbp-4], 0
	cmp	DWORD PTR [rbp-28], 0
	jns	.L21
	mov	rax, QWORD PTR [rbp-24]
	mov	BYTE PTR [rax], 45
	neg	DWORD PTR [rbp-28]
	add	DWORD PTR [rbp-4], 1
.L21:
	movzx	esi, BYTE PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-28]
	cdq
	idiv	esi
	mov	DWORD PTR [rbp-8], eax
	movzx	ecx, BYTE PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-28]
	cdq
	idiv	ecx
	mov	DWORD PTR [rbp-12], edx
	cmp	DWORD PTR [rbp-8], 0
	je	.L22
	movzx	edx, BYTE PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rcx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rcx, rax
	mov	eax, DWORD PTR [rbp-8]
	mov	esi, eax
	mov	rdi, rcx
	call	int_to_string
	mov	edx, DWORD PTR [rbp-4]
	add	eax, edx
	mov	DWORD PTR [rbp-4], eax
.L22:
	cmp	DWORD PTR [rbp-12], 0
	js	.L23
	cmp	DWORD PTR [rbp-12], 9
	jg	.L23
	mov	eax, DWORD PTR [rbp-12]
	lea	ecx, [rax+48]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	add	DWORD PTR [rbp-4], 1
	jmp	.L24
.L23:
	cmp	DWORD PTR [rbp-12], 15
	jg	.L24
	mov	eax, DWORD PTR [rbp-12]
	lea	ecx, [rax+87]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	add	DWORD PTR [rbp-4], 1
.L24:
	mov	eax, DWORD PTR [rbp-4]
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	int_to_string, .-int_to_string
	.globl	uint_to_string
	.type	uint_to_string, @function
uint_to_string:
.LFB6:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
	mov	DWORD PTR [rbp-28], esi
	mov	eax, edx
	mov	BYTE PTR [rbp-32], al
	cmp	BYTE PTR [rbp-32], 16
	ja	.L26
	cmp	BYTE PTR [rbp-32], 1
	ja	.L27
.L26:
	mov	eax, 0
	jmp	.L28
.L27:
	cmp	DWORD PTR [rbp-28], 0
	jne	.L29
	mov	rax, QWORD PTR [rbp-24]
	mov	BYTE PTR [rax], 48
	mov	eax, 1
	jmp	.L28
.L29:
	mov	DWORD PTR [rbp-4], 0
	movzx	esi, BYTE PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-28]
	mov	edx, 0
	div	esi
	mov	DWORD PTR [rbp-8], eax
	movzx	edi, BYTE PTR [rbp-32]
	mov	eax, DWORD PTR [rbp-28]
	mov	edx, 0
	div	edi
	mov	ecx, edx
	mov	eax, ecx
	mov	DWORD PTR [rbp-12], eax
	cmp	DWORD PTR [rbp-8], 0
	je	.L30
	movzx	edx, BYTE PTR [rbp-32]
	mov	ecx, DWORD PTR [rbp-8]
	mov	rax, QWORD PTR [rbp-24]
	mov	esi, ecx
	mov	rdi, rax
	call	int_to_string
	mov	edx, DWORD PTR [rbp-4]
	add	eax, edx
	mov	DWORD PTR [rbp-4], eax
.L30:
	cmp	DWORD PTR [rbp-12], 0
	js	.L31
	cmp	DWORD PTR [rbp-12], 9
	jg	.L31
	mov	eax, DWORD PTR [rbp-12]
	lea	ecx, [rax+48]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	add	DWORD PTR [rbp-4], 1
	jmp	.L32
.L31:
	cmp	DWORD PTR [rbp-12], 15
	jg	.L32
	mov	eax, DWORD PTR [rbp-12]
	lea	ecx, [rax+87]
	mov	eax, DWORD PTR [rbp-4]
	movsx	rdx, eax
	mov	rax, QWORD PTR [rbp-24]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	add	DWORD PTR [rbp-4], 1
.L32:
	mov	eax, DWORD PTR [rbp-4]
.L28:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	uint_to_string, .-uint_to_string
	.globl	vsprintf
	.type	vsprintf, @function
vsprintf:
.LFB7:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	QWORD PTR [rbp-40], rdi
	mov	QWORD PTR [rbp-48], rsi
	mov	QWORD PTR [rbp-56], rdx
	mov	rax, QWORD PTR [rbp-48]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-40]
	mov	QWORD PTR [rbp-16], rax
	jmp	.L34
.L45:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	cmp	al, 37
	jne	.L35
	add	QWORD PTR [rbp-8], 1
	mov	rax, QWORD PTR [rbp-8]
	lea	rdx, [rax+1]
	mov	QWORD PTR [rbp-8], rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	cmp	eax, 37
	je	.L36
	cmp	eax, 37
	jl	.L34
	cmp	eax, 120
	jg	.L34
	cmp	eax, 99
	jl	.L34
	sub	eax, 99
	cmp	eax, 21
	ja	.L34
	mov	eax, eax
	mov	rax, QWORD PTR .L39[0+rax*8]
	jmp	rax
	.section	.rodata
	.align 8
	.align 4
.L39:
	.quad	.L44
	.quad	.L43
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L42
	.quad	.L34
	.quad	.L34
	.quad	.L34
	.quad	.L41
	.quad	.L34
	.quad	.L40
	.quad	.L34
	.quad	.L34
	.quad	.L38
	.text
.L36:
	mov	rax, QWORD PTR [rbp-16]
	lea	rdx, [rax+1]
	mov	QWORD PTR [rbp-16], rdx
	mov	BYTE PTR [rax], 37
	jmp	.L34
.L43:
	add	QWORD PTR [rbp-56], 4
	mov	rax, QWORD PTR [rbp-56]
	sub	rax, 4
	mov	ecx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	mov	edx, 10
	mov	esi, ecx
	mov	rdi, rax
	call	int_to_string
	mov	eax, eax
	add	QWORD PTR [rbp-16], rax
	jmp	.L34
.L40:
	add	QWORD PTR [rbp-56], 4
	mov	rax, QWORD PTR [rbp-56]
	sub	rax, 4
	mov	ecx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	mov	edx, 10
	mov	esi, ecx
	mov	rdi, rax
	call	uint_to_string
	mov	eax, eax
	add	QWORD PTR [rbp-16], rax
	jmp	.L34
.L38:
	add	QWORD PTR [rbp-56], 4
	mov	rax, QWORD PTR [rbp-56]
	sub	rax, 4
	mov	ecx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	mov	edx, 16
	mov	esi, ecx
	mov	rdi, rax
	call	uint_to_string
	mov	eax, eax
	add	QWORD PTR [rbp-16], rax
	jmp	.L34
.L42:
	add	QWORD PTR [rbp-56], 4
	mov	rax, QWORD PTR [rbp-56]
	sub	rax, 4
	mov	ecx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	mov	edx, 8
	mov	esi, ecx
	mov	rdi, rax
	call	uint_to_string
	mov	eax, eax
	add	QWORD PTR [rbp-16], rax
	jmp	.L34
.L44:
	add	QWORD PTR [rbp-56], 4
	mov	rax, QWORD PTR [rbp-56]
	sub	rax, 4
	mov	ecx, DWORD PTR [rax]
	mov	rax, QWORD PTR [rbp-16]
	lea	rdx, [rax+1]
	mov	QWORD PTR [rbp-16], rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	jmp	.L34
.L41:
	add	QWORD PTR [rbp-56], 8
	mov	rax, QWORD PTR [rbp-56]
	mov	rax, QWORD PTR [rax-8]
	mov	QWORD PTR [rbp-24], rax
	mov	rdx, QWORD PTR [rbp-24]
	mov	rax, QWORD PTR [rbp-16]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcpy
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	strlen
	mov	eax, eax
	add	QWORD PTR [rbp-16], rax
	jmp	.L34
.L35:
	mov	rdx, QWORD PTR [rbp-8]
	lea	rax, [rdx+1]
	mov	QWORD PTR [rbp-8], rax
	mov	rax, QWORD PTR [rbp-16]
	lea	rcx, [rax+1]
	mov	QWORD PTR [rbp-16], rcx
	movzx	edx, BYTE PTR [rdx]
	mov	BYTE PTR [rax], dl
.L34:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L45
	mov	rax, QWORD PTR [rbp-16]
	sub	rax, QWORD PTR [rbp-40]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	vsprintf, .-vsprintf
	.globl	sprintf
	.type	sprintf, @function
sprintf:
.LFB8:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 208
	mov	QWORD PTR [rbp-200], rdi
	mov	QWORD PTR [rbp-208], rsi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L50
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L50:
	lea	rax, [rbp-208]
	add	rax, 8
	mov	QWORD PTR [rbp-184], rax
	mov	rcx, QWORD PTR [rbp-208]
	mov	rdx, QWORD PTR [rbp-184]
	mov	rax, QWORD PTR [rbp-200]
	mov	rsi, rcx
	mov	rdi, rax
	call	vsprintf
	mov	DWORD PTR [rbp-188], eax
	mov	QWORD PTR [rbp-184], 0
	mov	eax, DWORD PTR [rbp-188]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	sprintf, .-sprintf
	.globl	vprintf
	.type	vprintf, @function
vprintf:
.LFB9:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 1056
	mov	QWORD PTR [rbp-1048], rdi
	mov	QWORD PTR [rbp-1056], rsi
	lea	rax, [rbp-1040]
	mov	edx, 1024
	mov	esi, 0
	mov	rdi, rax
	call	memset
	mov	rdx, QWORD PTR [rbp-1056]
	mov	rcx, QWORD PTR [rbp-1048]
	lea	rax, [rbp-1040]
	mov	rsi, rcx
	mov	rdi, rax
	call	vsprintf
	mov	DWORD PTR [rbp-12], eax
	cmp	DWORD PTR [rbp-12], 0
	jns	.L52
	mov	eax, DWORD PTR [rbp-12]
	jmp	.L56
.L52:
	lea	rax, [rbp-1040]
	mov	QWORD PTR [rbp-8], rax
	jmp	.L54
.L55:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar
	add	QWORD PTR [rbp-8], 1
.L54:
	mov	rax, QWORD PTR [rbp-8]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L55
	mov	eax, DWORD PTR [rbp-12]
.L56:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	vprintf, .-vprintf
	.globl	printf
	.type	printf, @function
printf:
.LFB10:
	.cfi_startproc
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 208
	mov	QWORD PTR [rbp-200], rdi
	mov	QWORD PTR [rbp-168], rsi
	mov	QWORD PTR [rbp-160], rdx
	mov	QWORD PTR [rbp-152], rcx
	mov	QWORD PTR [rbp-144], r8
	mov	QWORD PTR [rbp-136], r9
	test	al, al
	je	.L60
	movaps	XMMWORD PTR [rbp-128], xmm0
	movaps	XMMWORD PTR [rbp-112], xmm1
	movaps	XMMWORD PTR [rbp-96], xmm2
	movaps	XMMWORD PTR [rbp-80], xmm3
	movaps	XMMWORD PTR [rbp-64], xmm4
	movaps	XMMWORD PTR [rbp-48], xmm5
	movaps	XMMWORD PTR [rbp-32], xmm6
	movaps	XMMWORD PTR [rbp-16], xmm7
.L60:
	lea	rax, [rbp-200]
	add	rax, 8
	mov	QWORD PTR [rbp-184], rax
	mov	rax, QWORD PTR [rbp-200]
	mov	rdx, QWORD PTR [rbp-184]
	mov	rsi, rdx
	mov	rdi, rax
	call	vprintf
	mov	DWORD PTR [rbp-188], eax
	mov	QWORD PTR [rbp-184], 0
	mov	eax, DWORD PTR [rbp-188]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	printf, .-printf
	.ident	"GCC: (GNU) 13.2.0"
