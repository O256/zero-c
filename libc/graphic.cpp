#include "include/graphic.hpp"
#include "include/math.h"

namespace __cxxabiv1
{
    struct __si_class_type_info
    {
        virtual void f() {} // 必须有一个虚函数，才能构建虚函数表
    } ins1;                 // 必须至少有一个对象实例，才能促使类型构建虚函数表

    struct __class_type_info
    {
        virtual void f() {}
    } ins2;
}

namespace graphic
{
    void Point::Draw(uint8_t color) const
    {
        SetVMem(_y * SCREEN_WIDTH + _x, color);
    }

    void Rect::Draw(uint8_t color) const
    {
        for (int i = 0; i < _width; i++)
        {
            for (int j = 0; j < _height; j++)
            {
                Point(_x + i, _y + j).Draw(color);
            }
        }
    }

    // void Circle::Draw(uint8_t color) const
    // {
    //     int x = _center.GetX();
    //     int y = _center.GetY();
    //     for (int i = -_radium; i < _radium; i++)
    //     {
    //         for (int j = -_radium; j < _radium; j++)
    //         {
    //             if (i * i + j * j < _radium * _radium)
    //             {
    //                 Point(x + i, y + j).Draw(color);
    //             }
    //         }
    //     }
    // }

    void Circle::Draw(uint8_t color) const
    {
        int centerX = _center.GetX();
        int centerY = _center.GetY();
        // 采用点阵扫描的方法，沿着x轴，从(c.x - r, c.y)开始，一直绘制到(c.x + r, c.y)
        // 中间横坐标每增加1，就计算当前横坐标上，符合(x-c.x)²+(y-c.y)²≤r²的纵坐标值，并绘制颜色
        for (int x = centerX - _radium; x <= centerX + _radium; x++)
        {
            // y = c.y±√(r²-(x-c.x)²)
            int y1 = centerY - ::sqrt(_radium * _radium - (x - centerX) * (x - centerX));
            int y2 = centerY + ::sqrt(_radium * _radium - (x - centerX) * (x - centerX));
            for (int y = y1; y < y2; y++)
            {
                Point{x, y}.Draw(color);
            }
        }
    }
}
