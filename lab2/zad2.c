#include <stdio.h>
int main(void)
{
  int x=-1;
  int x2;
  //"mov ebx, 0;" == "xor ebx,ebx;"
  //"inc ebx;" == "add ebx, 1
  asm volatile(
    ".intel_syntax noprefix;"
    "mov eax, %1;"
    "mov ebx, 0;"
    "shl eax;"
    "jnc a1;"
    "add ebx, ;"
    "a1:"
    "shl eax;"
    "jnc a2;"
    "inc ebx;"
    "a2:"
    "mov %0, ebx;"
    ".att_syntax prefix;"
    :"=r" (x2)
    :"r" (x)
    :"eax", "ebx"
  );
  printf("x=%d, x2=%d\n", x, x2);
  return 0;
}
