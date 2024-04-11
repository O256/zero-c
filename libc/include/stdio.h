#include "stdarg.h"

int putchar(int ch);
int puts(const char *str);

int vsprintf(char *str, const char *fnt, va_list li);

__attribute__((format(printf, 2, 3)))
int sprintf(char *str, const char *fmt, ...);

int vprintf(const char *fmt, va_list li);

__attribute__((format(printf, 1, 2)))
int printf(const char *fmt, ...);