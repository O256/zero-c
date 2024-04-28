#include "include/stdio.h"
#include "include/string.h"
#include "include/draw.h"

typedef struct
{
    long x;
    long y;
} CursorInfo;

#define STDOUT_BUF_SIZE 1024
static CursorInfo g_cursor_info = {0, 0}; // 全局变量，保存光标信息

// 光标移动到下一行
void NextLine()
{
    g_cursor_info.x = 0;
    g_cursor_info.y += FONT_HEIGHT;
}

// 光标后移
void NextChar()
{
    g_cursor_info.x += FONT_WIDTH;
    if (g_cursor_info.x >= SCREEN_WIDTH)
    {
        NextLine();
    }
}

// 光标前移
void PrevChar()
{
    g_cursor_info.x--;
    if (g_cursor_info.x < 0)
    {
        g_cursor_info.x = SCREEN_WIDTH - 1;
        g_cursor_info.y--;
    }
}

int putchar(int c)
{
    if (c == '\n')
    {
        NextLine();
    }
    else
    {
        DrawChar(g_cursor_info.x, g_cursor_info.y, c, 0x01);
        NextChar();
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
    va_start(li, fmt); // 栈中元素个数是通过fmt来计算的
    int ret = vprintf(fmt, li);
    va_end(li);
    return ret;
}