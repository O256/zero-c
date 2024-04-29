#include "include/math.h"

int abs(int n)
{
    return n < 0 ? -n : n;
}

int sqrt(int n)
{
    if (n < 0)
    {
        return 0;
    }
    // 由于是整数，直接暴力尝试
    for (int i = 0; i < n; i++)
    {
        if (i * i <= n && (i + 1) * (i + 1) >= n)
        {
            return i;
        }
    }
    return 0;
}