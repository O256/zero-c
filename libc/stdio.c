#include "include/stdio.h"
#include "include/string.h"

extern void SetVMem(long addr, unsigned char data);

#define STDOUT_BUF_SIZE 1024

// 定义光标信息
typedef struct {
  long x_offset, y_offset;
} CursorInfo;

static CursorInfo g_cursor_info = {0, 0}; // 全局变量，保存光标信息

// 光标后移
static void CursorInc() {
  g_cursor_info.x_offset += 8;
  if (g_cursor_info.x_offset >= 320) { // 超出屏幕了，换行
    g_cursor_info.x_offset = 0;
    g_cursor_info.y_offset += 16;
  }
}
// 光标前移
static void CursorRed() {
  g_cursor_info.x_offset -= 8;
  if (g_cursor_info.x_offset < 0) { // 超出屏幕了，换行
    g_cursor_info.x_offset = 320 - 8;
    g_cursor_info.y_offset -= 16;
  }
  if (g_cursor_info.y_offset < 0) {
    g_cursor_info.y_offset = 0; // 已经在首行的不再继续换
  }
}
// 光标换行
static void CursorNewLine() {
  g_cursor_info.x_offset = 0;
  g_cursor_info.y_offset += 16;
}

// 字体数据
extern uint8_t fonts[256][16];

// 绘制字符
void DrawCharacter(int x, int y, char ch, uint8_t color) {
  // 找到ch对应的字体数据
  const uint8_t *font = fonts[ch];
  // 开始绘制
  for (int i = 0; i < 16; i++) {
    for (int j = 0; j < 8; j++) {
      // 如果当前位置是否需要渲染，则设置颜色
      if (font[i] & (1 << (7 - j))) {
        SetVMem(x + j + (y + i) * 320, color);
      }
    }
  }
}

int putchar(int ch) {
  if (ch == '\n') { // 处理换行
    CursorNewLine();
  } else {
    DrawCharacter(g_cursor_info.x_offset, g_cursor_info.y_offset, (char)ch, 0x12);
    CursorInc();
  }
  return ch;
}

int puts(const char *str) {
  // 处理C字符串，需要向后找到0结尾，逐一调用putchar
  for (const char *p = str; *p != '0'; p++) {
    putchar(*p);
  }
  return 0;
}

static size_t int_to_string(char *res, int i, uint8_t base) {
  if (base > 16 || base <= 1) {
    return 0;
  }
  if (i == 0) {
    res[0] = '0';
    return 1;
  }
  int size = 0;
  if (i < 0) {
    res[0] = '-';
    i *= -1;
    size++;
  }

  int quo = i / base;
  int rem = i % base;
  // 利用函数递归栈逆向结果
  if (quo != 0) {
    size += int_to_string(res + size, quo, base);
  }
  
  if (rem >= 0 && rem <= 9) {
    res[size] = (char)rem + '0';
    size++;
  } else if (rem <= 15) {
    res[size] = (char)rem - 10 + 'a';
    size++;
  }

  return size;
}

static size_t uint_to_string(char *res, unsigned i, uint8_t base) {
  if (base > 16 || base <= 1) {
    return 0;
  }
  if (i == 0) {
    res[0] = '0';
    return 1;
  }
  int size = 0;

  int quo = i / base;
  int rem = i % base;
  // 利用函数递归栈逆向结果
  if (quo != 0) {
    size += int_to_string(res, quo, base);
  }
  
  if (rem >= 0 && rem <= 9) {
    res[size] = (char)rem + '0';
    size++;
  } else if (rem <= 15) {
    res[size] = (char)rem - 10 + 'a';
    size++;
  }

  return size;
}

int vsprintf(char *str, const char *fmt, va_list li) {
  const char *p_src = fmt;
  char *p_dst = str;
  while (*p_src != '\0') {
    if (*p_src == '%') {
      p_src++;
      switch (*p_src++) {
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
    } else {
      *p_dst++ = *p_src++;
    }
  }
  return p_dst - str;
}

int sprintf(char *str, const char *fmt, ...) {
  va_list li;
  va_start(li, fmt);
  int ret = vsprintf(str, fmt, li);
  va_end(li);
  return ret;
}

int vprintf(const char *fmt, va_list li) {
  char buf[STDOUT_BUF_SIZE];
  memset(buf, 0, sizeof(buf));
  int ret = vsprintf(buf, fmt, li);
  if (ret < 0) {
    return ret;
  }
  for (const char *p = buf; *p != 0; p++) {
    putchar(*p);
  }
  return ret;
}

int printf(const char *fmt, ...) {
  va_list li;
  va_start(li, fmt);
  int ret = vprintf(fmt, li);
  va_end(li);
  return ret;
}
