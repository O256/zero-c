#include "include/string.h"
#include "include/stdint.h"

char *strcpy(char *dst, const char *src) {
  char *p = dst;
  while (*src != '\0') {
    *p++ = *src++;
  }
  return dst;
}

size_t strlen(const char *str) {
  size_t size = 0;
  for (const char *p = str; *p != '\0'; p++) {
    size++;
  }
  return size;
}

void *memcpy(void *dst, const void *src, size_t size) {
  uint8_t *p = (char *)dst;
  const uint8_t *q = (const uint8_t *)src;
  for (int i = 0; i < size; i++) {
    p[i] = q[i];
  }
  return dst;
}

void *memset(void *dst, int ch, size_t size) {
  uint8_t *p = dst;
  for (long i = 0; i < size; i++) {
    p[i] = (uint8_t)ch;
  }
  return dst;
}
