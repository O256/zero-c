extern void SetVMem(long addr, unsigned char data);

void Entry()
{
    SetVMem(0, 'H');
    SetVMem(1, 0x0f);
    SetVMem(2, 'e');
    SetVMem(3, 0x0f);
}