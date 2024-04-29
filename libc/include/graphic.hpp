#pragma once

#ifdef __cplusplus
extern "C"
{
#endif

#include "stdint.h"
#include "draw.h"

    namespace graphic
    {
        class Shape
        {
        public:
            virtual void Draw(uint8_t color) const = 0;
        };

        class Point : public Shape
        {
        private:
            int _x, _y;

        public:
            Point(int x, int y) : _x(x), _y(y){};
            ~Point() = default;
            void Draw(uint8_t color) const;

            int GetX() const { return _x; }
            int GetY() const { return _y; }
        };

        class Rect : public Shape
        {
        private:
            int _x, _y, _width, _height;

        public:
            Rect(int x, int y, int width, int height) : _x(x), _y(y), _width(width), _height(height){};
            ~Rect() = default;

            void Draw(uint8_t color) const;
        };

        class Circle : public Shape
        {
        private:
            Point _center;
            int _radium;

        public:
            Circle(const Point &center, int radium) : _center(center), _radium(radium){};
            ~Circle() = default;

            void Draw(uint8_t color) const;
        };
    }

#ifdef __cplusplus
}
#endif
