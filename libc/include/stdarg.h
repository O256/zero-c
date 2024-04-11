#include "stdint.h"
#include "stddef.h"

typedef uint8_t *va_list;

#define va_start(varg_ptr, last_val) (varg_ptr = (uint8_t *)(&last_val + 1))
#define va_arg(varg_ptr, type) (varg_ptr += sizeof(type), *((type *)varg_ptr - 1))
#define va_end(varg_ptr) (varg_ptr = NULL)