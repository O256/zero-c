#include <stdint.h>
#include "graphic_ui.hpp"

namespace __cxxabiv1 {
  struct __si_class_type_info {
    virtual void f() {} // 必须有一个虚函数，才能构建虚函数表
  } ins1; // 必须至少有一个对象实例，才能促使类型构建虚函数表

  struct __class_type_info {
    virtual void f() {}
  } ins2;
}

extern "C"
int main() {
  ui::Circle{{100, 100}, 80}.Draw(0x23);

  return 0;
}