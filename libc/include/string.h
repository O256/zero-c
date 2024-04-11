#include "stddef.h"

// 字符串操作
char *strcpy(char *dst, const char *src);

// 字符串检验
size_t strlen(const char *str);

// 字符数组操作
void *memcpy(void *dst, const void *src, size_t size);
void *memset(void *dst, int ch, size_t size);