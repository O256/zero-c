#include "graphic.hpp"

using namespace graphic;
extern "C"
{
    int main()
    {
        Rect(10, 10, 50, 30).Draw(0x26);
        Circle(Point(100, 100), 50).Draw(0x26);
        return 0;
    }
}
