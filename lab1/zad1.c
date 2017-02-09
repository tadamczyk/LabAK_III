#include <stdio.h>
int main(void)
{
  int x=5;
  int x2=123;
  //x2=x+x;
  asm volatile(
    ".intel_syntax noprefix;"
    "mov eax, %1;"
    "add eax, eax;"
    "mov %0, eax;"
    "add eax, eax;"
    "mov %0, eax;"
    "add eax, eax;"
    "mov ebx, %0;"
    "mov %0, eax;"
    "add eax, eax;"
    "mov %0, eax;"
    "add ebx, eax;"
    "mov %0, ebx;"
    ".att_syntax prefix;"
    :"=r" (x2)
    :"r" (x)
    :"eax"
  );
  printf("x=%d, x2=%d\n", x, x2);
  return 0;
}
