[bits 32] ; 这里声明按照32位指令汇编
section .text

; C0H0S2
begin:
    mov ax, 00100_00_0b ; 选择4号段，数据段
    mov es, ax

    ; ; mov ecx, 1024
    ; ; mov ebx, 0x20000

    ; ; 把0x20000~0x20fff范围的1024个页目录项进行配置
    ; mov eax, 00100001_000_0_0_0_0_0_0_0_1_1b ; 设置页目录表地址
    ; mov [es:0x20000], eax

    ; ; 把0x21000~0x213ff范围的256个页表项进行配置，对应低1MB物理内存
    ; mov ecx, 256 ; 256个页表项
    ; mov ebx, 0x21000
    ; mov edx, 0x00000_003

    ; .loop:
    ;     mov [es:ebx], edx
    ;     add ebx, 4
    ;     add edx, 0x0001_000
    ;     loop .loop
    
    ; mov eax, 00100000_00000000_0_0_00b ; 设置页目录表地址
    ; mov cr3, eax ; 设置页目录表地址    

    ; cli ; 关闭中断

    ; mov eax, cr0
    ; or eax, 0x80000000 ; 设置CR0的PG位
    ; mov cr0, eax ; 设置CR0的PG位, 开启分页机制


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

    mov eax, cr0
    or eax, 0x80000000 ; 设置CR0的PG位
    mov cr0, eax ; 设置CR0的PG位, 开启分页机制
    
    ; 开启IA-32e模式

    mov ax, 00011_00_0b ; 选择3号段，数据段
    mov ss, ax ; 设置栈段寄存器
    mov ds, ax ; 设置数据段寄存器
    mov es, ax ; 设置附加段寄存器

    mov eax, 0x1000
    mov esp, eax ; 设置栈指针
    mov ebp, eax ; 记录初始栈顶

    extern Entry
    call Entry

    hlt

