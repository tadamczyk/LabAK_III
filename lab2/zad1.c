#include <stdio.h>
int main(void)
{
  int x=-1;
  int x2=0;
  asm volatile(
    ".intel_syntax noprefix;"
    "mov eax, %1;"
    "shl eax;"
    "jc zapalony;"
    "mov eax, 17;"
    "jmp koniec;"
    "zapalony:"
    "mov eax, 12;"
    "koniec:"
    "mov %0, eax;"
    ".att_syntax prefix;"
    :"=r" (x2)
    :"r" (x)
    :"eax"
  );
  printf("x=%d, x2=%d\n", x, x2);
  return 0;
}
