#pragma once
#include <stdint.h>

namespace ui {

constexpr int screen_width = 320;
constexpr int screen_length = 200;

class Shape {
 public:
  virtual void Draw(uint8_t color) const = 0;
};

class Point : public Shape {
 public:
  Point(int x, int y);
  ~Point() = default;
  void Draw(uint8_t color) const override;
  int x() const {return x_;}
  int y() const {return y_;}

 private:
  int x_, y_;
};

class Rect : public Shape {
 public:
  Rect(int x, int y, int width, int length);
  ~Rect() = default;
  void Draw(uint8_t color) const override;

 private:
  int x_, y_, width_, length_;
};

class Circle : public Shape {
 public:
  Circle(const Point &center, int radium);
  ~Circle() = default;
  void Draw(uint8_t color) const override;

 private:
  Point center_;
  int radium_;
};

}