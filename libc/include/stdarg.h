#ifdef __cplusplus
extern "C" {
#endif

#include "stdint.h"
#include "stddef.h"

// 通过编译器内建功能来完成
typedef __builtin_va_list va_list;
#define va_start(v, l) __builtin_va_start(v, l)
#define va_arg(v, t) __builtin_va_arg(v, t)
#define va_end(v) __builtin_va_end(v)

#ifdef __cplusplus
}
#endif