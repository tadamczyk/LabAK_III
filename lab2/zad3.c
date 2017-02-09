#include <stdio.h>
int main(void)
{
  int x=-1;
  int x2;
  asm volatile(
    ".intel_syntax noprefix;"
    "mov eax, %1;"
    "xor ebx, ebx;"
    "xor ecx, ecx;"
    "petla:"
    "shl eax;"
    "jnc a1;"
    "inc ebx;"
    "a1:"
    "inc ecx;"
    "cmp ecx, 32;"
    "jnz petla;"
    "mov %0, ebx;"
    ".att_syntax prefix;"
    :"=r" (x2)
    :"r" (x)
    :"eax", "ebx", "ecx"
  );
  printf("x=%d, x2=%d\n", x, x2);
  return 0;
}
