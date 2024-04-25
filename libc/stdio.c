extern void SetVMem(long addr, unsigned char data);

typedef struct
{
    long offset;
} CursorInfo;

CursorInfo g_cursor_info = {0};

int putchar(int c)
{
    if (c == '\n')
    {
        g_cursor_info.offset += 80 * 2;
        g_cursor_info.offset -= ((g_cursor_info.offset / 2) % 80) * 2;
    }
    else
    {
        SetVMem(g_cursor_info.offset++, (unsigned char)c);
        SetVMem(g_cursor_info.offset++, 0x0f);
    }

    return c;
}

int puts(const char *s)
{
    while (*s)
    {
        putchar(*s++);
    }

    return 0;
}