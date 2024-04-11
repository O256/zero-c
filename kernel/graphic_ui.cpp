#include "graphic_ui.hpp"
#include <stdio.h>
#include <math.h>

namespace ui {

Point::Point(int x, int y): x_(x), y_(y) {}

void Point::Draw(uint8_t color) const {
  SetVMem(y_ * screen_width + x_, color);
}

Rect::Rect(int x, int y, int width, int length): x_(x), y_(y), width_(width), length_(length) {}

void Rect::Draw(uint8_t color) const {
  for (int i = 0; i < width_; i++) {
    for (int j = 0; j < length_; j++) {
      Point{x_ + i, y_ + j}.Draw(color);
    }
  }
}

Circle::Circle(const Point &center, int radium): center_(center), radium_(radium) {}

void Circle::Draw(uint8_t color) const {
  // 采用点阵扫描的方法，沿着x轴，从(c.x - r, c.y)开始，一直绘制到(c.x + r, c.y)
  // 中间横坐标每增加1，就计算当前横坐标上，符合(x-c.x)²+(y-c.y)²≤r²的纵坐标值，并绘制颜色
  for (int x = center_.x() - radium_; x <= center_.x() + radium_; x++) {
    // y = c.y±√(r²-(x-c.x)²)
    int y1 = center_.y() - ::sqrt(radium_ * radium_ - (x - center_.x()) * (x - center_.x()));
    int y2 = center_.y() + ::sqrt(radium_ * radium_ - (x - center_.x()) * (x - center_.x()));
    for (int y = y1; y < y2; y++) {
        Point{x, y}.Draw(color);
    }
  }
}

}