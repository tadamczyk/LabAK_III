//******************************//
//       TOMASZ ADAMCZYK        //
//       Nr albumu: 243217      //
//       Informatyka II ROK     //
//       Projekt3.s             //
//******************************//

// Tresc zadania:
// f(n) = { m, gdy n = 0;
//        { 1, gdy n = 1;
//        { 0, gdy n = 2;
//        { 2*f(n-1, m) + f(n-2, m) - 2*f(n-3, m), gdy n>2
// A. Argument przekazywany przez rejestr EDX, pozostale rejestry przez stos;
// B. Wynik zwracany przez rejestr EBX;
// C. Za uporzadkowanie stosu odpowiada wywolywana funkcja;
// D. Wywolywana funkcja musi zachowac wszystkie rejestry
//    (oprocz rejestru, w ktorym zwracany jest wynik).

.intel_syntax noprefix
.text
.globl main

main:
  mov edx, 3
  mov eax, 10
  xor ebx, ebx
  xor ecx, ecx
  push eax
  call function
  add esp, 4
  push ebx
  push offset msg
  call printf
  add esp, 8
  mov eax, 0
  ret

function:
  mov ebx, 0
  push ebp
  mov ebp, esp
  push eax
  push edx
  push ecx
  mov eax, [ebp+8]
  cmp edx, 0
  jne f1
  mov ebx, eax
  jmp final

f1:
  cmp edx, 1
  jne f2
  mov ebx, 1
  jmp final

f2:
  cmp edx, 2
  jne fnext
  mov ebx, 0
  jmp final

fnext:
  push edx
  sub edx, 1
  push ebx
  push eax
  call function
  add esp, 4
  pop ecx
  add ebx, ebx
  add ebx, ecx
  pop edx
  push edx
  sub edx, 2
  push ebx
  push eax
  call function
  add esp, 4
  pop ecx
  add ebx, ecx
  pop edx
  push edx
  sub edx, 3
  push ebx
  push eax
  call function
  add esp, 4
  pop ecx
  sub ecx, ebx
  sub ecx, ebx
  mov ebx, ecx
  pop edx

final:
  pop ecx
  pop edx
  pop eax
  pop ebp
  ret

.data
msg:
  .asciz "Wynik = %d\n"
  .byte 0
