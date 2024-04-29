#pragma once

#ifdef __cplusplus
extern "C"
{
#endif

#include "stdint.h"

// 屏幕的长宽
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT 200

// 字符的长宽
#define FONT_WIDTH 8
#define FONT_HEIGHT 16

    extern const unsigned char *GetFont(char ch);
    extern void SetVMem(long addr, unsigned char data);

    void SetBackground(unsigned char color);
    void SetPixel(int x, int y, unsigned char color);
    void DrawRect(int x, int y, int w, int h, unsigned char color);
    void DrawChar(int x, int y, char c, unsigned char color);

    // void DrawCharactor(int x, int y, char ch, uint8_t color);

#ifdef __cplusplus
}
#endif
