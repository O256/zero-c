#include "stdio.h"
#include "draw.h"

void Entry()
{
    SetBackground(0x0f);

    // puts("Hello, World!\n");
    // puts("The 2nd line.\n");
    const char *data = "ABC123~~";
    int a = 6;
    printf("Hello, World!\n%s\n%d", data, a);

    // for (int i = 0; i < height; i++)
    // {
    //     for (int j = 0; j < width; j++)
    //     {
    //         int offset = i * 320 + j;
    //         SetVMem(offset, j & 0x0f); // 纵向条纹
    //     }
    // }

    // 红色正方形
    // DrawRect(10, 10, 100, 100, 0x04);
    // 绿色正方形
    // DrawRect(50, 50, 100, 100, 0x02);

    // 蓝色的字母A
    // DrawChar(100, 100, 'A', 0x01);
}