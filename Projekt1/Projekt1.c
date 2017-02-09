/********************************
*       TOMASZ ADAMCZYK         *
*       Nr albumu: 243217       *
*       Informatyka II ROK      *
*       Projekt1.c              *
********************************/

#include <stdio.h>
int main()
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
      "jnc zeruj;"
      "inc ebx;"
      "cmp ebx, edx;"
      "jae zmien;"
      "jmp wyskocz;"
    "zmien:"
      "mov edx, ebx;"
      "jmp wyskocz;"
    "zeruj:"
      "mov ebx, 0;"
    "wyskocz:"
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
