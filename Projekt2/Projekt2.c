/********************************
*       TOMASZ ADAMCZYK         *
*       Nr albumu: 243217       *
*       Informatyka II ROK      *
*       Projekt2.c              *
********************************/

#include <stdio.h>
int main(void){
  const char *s = "aqr  b qabxx xryc pqr";
  //const char *s = "";
  //const char *s = "pqr";
  int x, y;
  asm volatile(
    ".intel_syntax noprefix;"
    "mov ecx, %2;"
    //własny kod - POCZĄTEK
    "xor eax, eax;"
    "xor ebx, eax;"
    "check_p:"
      "mov ebx, 0;"
      "cmp byte ptr [ecx], 'p';"
      "jnz check_q;"
      "inc eax;"
      "inc ebx;"
      "inc ecx;"
      "jmp check_not_r;"
    "check_q:"
      "cmp byte ptr [ecx], 'q';"
      "jnz check0;"
      "inc eax;"
      "inc ebx;"
      "inc ecx;"
    "check_not_r:"
      "cmp byte ptr [ecx], 'r';"
      "jnz check1;"
      "inc ebx;"
      "inc ecx;"
      "jmp check_p;"
    "check_r:"
      "cmp byte ptr [ecx], 'r';"
      "jnz check1;"
      "inc ebx;"
      "jmp wyjscie;"
    "check0:"
      "cmp byte ptr [ecx], 0;"
      "jz wyjscie;"
      "inc eax;"
      "inc ecx;"
      "jmp check_p;"
    "check1:"
      "cmp byte ptr [ecx], 0;"
      "jz wyjscie;"
      "inc ebx;"
      "inc ecx;"
      "jmp check_r;"
    //własny kod - KONIEC
    "wyjscie:"
      "mov %0, eax;"
      "mov %1, ebx;"
    ".att_syntax prefix;"
    : "=r" (x), "=r" (y)
    : "r" (s)
    : "eax", "ebx", "ecx"
  );
  printf("%hd, %hd\n", x, y);
  return 0;
}
