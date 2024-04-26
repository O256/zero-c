#include "stdio.h"
#include "fontdata.h"

int width = 320;
int height = 200;

void SetBackground(unsigned char color)
{
    for (int offset = 0; offset < width * height; offset++)
    {
        SetVMem(offset, color);
    }
}

// 画一个点
void SetPixel(int x, int y, unsigned char color)
{
    int offset = y * width + x;
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
    for (int i = 0; i < 16; i++)
    {
        for (int j = 0; j < 8; j++)
        {

            if (font[i] & (1 << (7 - j)))
            {
                SetVMem(x + j + (y + i) * 320, color);
            }
        }
    }
}

void Entry()
{
    // puts("Hello, World!\n");
    // puts("The 2nd line.\n");
    // const char *data = "ABC123~~";
    // int a = 6;
    // printf("Hello, World!\n%s\n%d", data, a);

    // for (int i = 0; i < height; i++)
    // {
    //     for (int j = 0; j < width; j++)
    //     {
    //         int offset = i * 320 + j;
    //         SetVMem(offset, j & 0x0f); // 纵向条纹
    //     }
    // }

    SetBackground(0x0f);
    // 红色正方形
    DrawRect(10, 10, 100, 100, 0x04);
    // 绿色正方形
    DrawRect(50, 50, 100, 100, 0x02);

    // 蓝色的字母A
    DrawChar(100, 100, 'A', 0x01);
}