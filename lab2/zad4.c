#include <stdio.h>
int main(void)
{
  int x=-1;
  int x2;
  asm volatile(
    ".intel_syntax noprefix;"
    "mov eax, %1;"
    "xor ebx, ebx;"
    "mov ecx, 32;"
    "xor edx, edx;"
    "petla:"
    "shl eax;"
    "jnc a2;"
    "inc ebx;"
    "cmp ebx, 2;"
    "jae a1;"
    "jmp a3;"
    "a1:"
    "inc edx;"
    "jmp a3;"
    "a2:"
    "mov ebx, 0;"
    "a3:"
    "loop petla;"
    "mov %0, edx;"
    ".att_syntax prefix;"
    :"=r" (x2)
    :"r" (x)
    :"eax", "ebx", "ecx", "edx"
  );
  printf("x=%d, x2=%d\n", x, x2);
  return 0;
}
