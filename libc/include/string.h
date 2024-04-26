#ifndef string_h
#define string_h

#include "stdarg.h"

char *strcpy(char *dest, const char *src);
size_t strlen(const char *str);
void *memcpy(void *dst, const void *src, size_t size);
void *memset(void *dst, int ch, size_t size);

#endif