// Argumenty przekazywane przez stos,
// za uporządkowanie stosu odpowiada wywoływana funkcja.
// Wszystkie rejestry zachowywane przez wołjącego.
  .intel_syntax noprefix
  .globl main
  .text

main:
  mov eax, 10
  push eax
  call silnia
  push eax
  push offset msg
  call printf
  add esp, 8
  mov eax, 0
  ret

silnia:
  push ebp
  mov ebp, esp
  push ecx
  push edx
  mov eax, [ebp+8]
  cmp eax, 0
  jne dalej
  mov eax, 1
  pop edx
  pop ecx
  pop ebp
  ret 4

dalej:
  push eax
  dec eax
  push eax
  call silnia
  pop ecx
  mul ecx
  pop edx
  pop ecx
  pop ebp
  ret 4

  .data
msg:  .asciz "silnia=%d\n"
