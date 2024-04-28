#ifndef stdarg_h
#define stdarg_h

#include "stdint.h"
#include "stddef.h"

typedef uint8_t *va_list;

#define va_start(varg_ptr, last_val) (varg_ptr = (uint8_t *)(&last_val + 1)) // 这里是因为format是一个指针，所以要+1
#define va_arg(varg_ptr, type) (varg_ptr += sizeof(type), *((type *)varg_ptr - 1)) // 参数是整个压入栈中的，所以要+sizeof(type)
#define va_end(varg_ptr) (varg_ptr = NULL)

#endif