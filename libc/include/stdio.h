#ifndef stdio_h
#define stdio_h

extern void SetVMem(long addr, unsigned char data);

int putchar(int c);
int puts(const char *s);

int printf(const char *fmt, ...);

#endif