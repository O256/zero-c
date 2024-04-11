#include <stdint.h>
#include <stdio.h>
extern void SetVMem(long addr, uint8_t data);

// 设置画布（背景色）
void SetBackground(uint8_t color) {
  for (int i = 0; i < 320 * 200; i++) {
    SetVMem(i, color);
  }
}

void Entry() {
  // 背景设置为白色
  SetBackground(0x0f);
  
  extern int main();
  int ret = main();
  printf("ret by: %d", ret);
}