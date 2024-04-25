#include "include/string.h"
#include "include/stdint.h"
#include "include/stddef.h"

char *strcpy(char *dest, const char *src)
{
    char *d = dest;
    const char *s = src;
    while ((*d++ = *s++) != '\0')
        ;
    return dest;
}

size_t strlen(const char *str)
{
    size_t len = 0;
    while (str[len])
        len++;
    return len;
}

void *memcpy(void *dst, const void *src, size_t size)
{
    uint8_t *p = (char *)dst;
    const uint8_t *q = (const uint8_t *)src;
    for (int i = 0; i < size; i++)
    {
        p[i] = q[i];
    }
    return dst;
}

void *memset(void *dst, int ch, size_t size)
{
    uint8_t *p = dst;
    for (long i = 0; i < size; i++)
    {
        p[i] = (uint8_t)ch;
    }
    return dst;
}
