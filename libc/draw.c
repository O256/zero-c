#include "include/draw.h"



void SetBackground(unsigned char color)
{
    for (int offset = 0; offset < SCREEN_WIDTH * SCREEN_HEIGHT; offset++)
    {
        SetVMem(offset, color);
    }
}

// 画一个点
void SetPixel(int x, int y, unsigned char color)
{
    long offset = y * SCREEN_WIDTH + x;
    SetVMem(offset, color);
}

// 画一个矩形
void DrawRect(int x, int y, int w, int h, unsigned char color)
{
    for (int i = y; i < y + h; i++)
    {
        for (int j = x; j < x + w; j++)
        {
            SetPixel(j, i, color);
        }
    }
}

void DrawChar(int x, int y, char c, unsigned char color)
{
    const unsigned char *font = GetFont(c);
    for (int i = 0; i < 16; i++)
    {
        for (int j = 0; j < 8; j++)
        {

            if ((font[i] >> (7 - j)) & 0x1)
            {
                SetPixel(x + j, y + i, color);
            }
        }
    }
}
