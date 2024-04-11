[bits 32]
section .text 

begin:
; es设置为4号段
mov ax, 00100_00_0b
mov es, ax

; IA-32e模式下使用4级分页，PML4-PDPT-PDT-PT
; 这种模式下的页目录项、页表项都是8字节，高52位是物理地址
; 如果在PDPT上就设PS=1的话，实际上只分2层，每页1GB
; 如果在PDT上就设PS=1的话，实际上只分3层，每页2MB
; 到了PT上PS必须设为1（因为此模式最多支持4层），每页4KB
; 这里就将0x00000~0x1FFFFF这2MB的空间放到首个页结构项中

; PML4
mov [es:0x20000], dword 0x21003 ; P=1, RW=1, PS=0(表示有下级页表), Base=0x21_000
mov [es:0x20004], dword 0

; PDPT
mov [es:0x21000], dword 0x22003 ; P=1, RW=1, PS=0(表示有下级页表), Base=0x22_000
mov [es:0x21004], dword 0

; PDT
mov [es:0x22000], dword 0x83 ; P=1, RW=1, PS=1(不再有下级页表，所以直接按2MB分页), Base=0x0，大小2MB
mov [es:0x22004], dword 0
  
; 将页目录首地址写入CR3寄存器中
mov eax, 00100000_00000000_0_0_00b ; PCD=0, PWT=0, BASE=0x00020_000
mov cr3, eax

; 开启CR4的第5位，开启64位地址扩展的分页模式
mov eax, cr4
or eax, 0x20
mov cr4, eax

; 读取EFER(Extended FeatureEnable Register)
mov ecx, 0xc0000080 ; 地址放在ecx中
rdmsr ; 读取结果会放在eax中
or eax, 0x100 ; 设置第8位，LME(Long Mode Enable)
wrmsr ; 将eax的值写入ecx对应地址的寄存器


; 开启CR0的第31位（最高位）以开启分页机制
mov eax, cr0
or eax, 0x80000000
mov cr0, eax 

; 进入IA-32e模式
; 刷新cs以进入64位指令模式
jmp 00101_00_0b:ent64

[bits 64]
ent64:
  mov r8, 0x12345678911

mov ax, 00110_00_0b ; 选择6号段，数据段
mov ss, ax
; ds要跟ss一致
mov ds, ax
; es也初始化为数据段（防止后续出问题，先初始化）
mov es, ax

; 初始化栈
mov rax, 0x1000
mov rsp, rax    ; 设置初始栈顶
mov rbp, rax    ; ebp也记录初始栈顶

extern Entry
call Entry

hlt

