#include "include/stdio.h"
#include "include/string.h"

typedef struct
{
    long offset;
} CursorInfo;

#define STDOUT_BUF_SIZE 1024
static CursorInfo g_cursor_info = {0}; // 全局变量，保存光标信息

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

static size_t int_to_string(char *res, int i, uint8_t base)
{
    if (base > 16 || base <= 1)
    {
        return 0;
    }
    if (i == 0)
    {
        res[0] = '0';
        return 1;
    }
    int size = 0;
    if (i < 0)
    {
        res[0] = '-';
        i *= -1;
        size++;
    }

    int quo = i / base;
    int rem = i % base;
    // 利用函数递归栈逆向结果
    if (quo != 0)
    {
        size += int_to_string(res + size, quo, base);
    }

    if (rem >= 0 && rem <= 9)
    {
        res[size] = (char)rem + '0';
        size++;
    }
    else if (rem <= 15)
    {
        res[size] = (char)rem - 10 + 'a';
        size++;
    }

    return size;
}

size_t uint_to_string(char *res, unsigned i, uint8_t base)
{
    if (base > 16 || base <= 1)
    {
        return 0;
    }
    if (i == 0)
    {
        res[0] = '0';
        return 1;
    }
    int size = 0;

    int quo = i / base;
    int rem = i % base;
    // 利用函数递归栈逆向结果
    if (quo != 0)
    {
        size += int_to_string(res, quo, base);
    }

    if (rem >= 0 && rem <= 9)
    {
        res[size] = (char)rem + '0';
        size++;
    }
    else if (rem <= 15)
    {
        res[size] = (char)rem - 10 + 'a';
        size++;
    }

    return size;
}

int vsprintf(char *str, const char *fmt, va_list li)
{
    const char *p_src = fmt;
    char *p_dst = str;
    while (*p_src != '\0')
    {
        if (*p_src == '%')
        {
            p_src++;
            switch (*p_src++)
            {
            case '%':
                *p_dst++ = '%';
                break;

            case 'd':
                p_dst += int_to_string(p_dst, va_arg(li, int), 10);
                break;

            case 'u':
                p_dst += uint_to_string(p_dst, va_arg(li, unsigned), 10);
                break;

            case 'x':
                p_dst += uint_to_string(p_dst, va_arg(li, unsigned), 16);
                break;

            case 'o':
                p_dst += uint_to_string(p_dst, va_arg(li, unsigned), 8);
                break;

            case 'c':
                *p_dst++ = (char)va_arg(li, int); // 4字节对齐
                break;

            case 's':
                const char *str = va_arg(li, const char *);
                strcpy(p_dst, str);
                p_dst += strlen(str);
            }
        }
        else
        {
            *p_dst++ = *p_src++;
        }
    }
    return p_dst - str;
}

int sprintf(char *str, const char *fmt, ...)
{
    va_list li;
    va_start(li, fmt);
    int ret = vsprintf(str, fmt, li);
    va_end(li);
    return ret;
}

int vprintf(const char *fmt, va_list li)
{
    char buf[STDOUT_BUF_SIZE];
    memset(buf, 0, sizeof(buf));
    int ret = vsprintf(buf, fmt, li);
    if (ret < 0)
    {
        return ret;
    }
    for (const char *p = buf; *p != 0; p++)
    {
        putchar(*p);
    }
    return ret;
}

int printf(const char *fmt, ...)
{
    va_list li;
    va_start(li, fmt);
    int ret = vprintf(fmt, li);
    va_end(li);
    return ret;
}