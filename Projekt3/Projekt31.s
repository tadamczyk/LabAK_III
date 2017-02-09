//******************************//
//       TOMASZ ADAMCZYK        //
//       Nr albumu: 243217      //
//       Informatyka II ROK     //
//       Projekt3.s             //
//******************************//

// Tresc zadania:
// f(n) = { 0, gdy n = 0;
//        { 1, gdy n = 1;
//        { 0, gdy n = 2;
//        { 2*f(n-1) + f(n-2) - 2*f(n-3), gdy n>2
// A. Argument przekazywany przez rejestr EDX, pozostale rejestry przez stos;
// B. Wynik zwracany przez rejestr EBX;
// C. Za uporzadkowanie stosu odpowiada wywolywana funkcja;
// D. Wywolywana funkcja musi zachowac wszystkie rejestry
//    (oprocz rejestru, w ktorym zwracany jest wynik).

.intel_syntax noprefix
.text
.globl main

main:
  lea ecx, [esp+4]
  and esp, -16
  push [ecx-4]
  push ebp
  mov ebp, esp
  push ebx
  push ecx
  sub esp, 16
  mov ebx, ecx
  mov eax, [ebx+4]
  add eax, 4
  mov eax, [eax]
  sub esp, 12
  push eax
  call atoi
  add esp, 16
  mov [ebp-16], eax
  mov eax, [ebx+4]
  add eax, 8
  mov eax, [eax]
  sub esp, 12
  push eax
  call atoi
  add esp, 16
  mov [ebp-12], eax
  sub esp, 8
  push [ebp-12]
  push [ebp-16]
  call function
  add esp, 16
  sub esp, 8
  mov ebx, eax
  push ebx
  push offset msg
  call printf
  add esp, 16
  mov ebx, 0
  leave
  ret

function:
  push ebp
  mov ebp, esp
  mov edx, [ebp+8]
  push ebx
  sub esp, 4
  cmp edx, 0
  jne f1
  mov eax, [ebp+12]
  jmp final

f1:
  cmp edx, 1
  jne f2
  mov eax, 1
  jmp final

f2:
  cmp edx, 2
  jne next
  mov eax, 0
  jmp final

next:
  mov eax, [ebp+8]
  dec eax
  sub esp, 8
  push [ebp+12]
  push eax
  call function
  add esp, 16
  lea ebx, [eax+eax]
  mov eax, [ebp+8]
  sub eax, 2
  sub esp, 8
  push [ebp+12]
  push eax
  call function
  add esp, 16
  add ebx, eax
  mov eax, [ebp+8]
  sub eax, 3
  sub esp, 8
  push [ebp+12]
  push eax
  call function
  add esp, 16
  add eax, eax
  sub ebx, eax
  mov eax, ebx

final:
  mov ebx, [ebp-4]
  leave
  ret

msg:
  .asciz "Wynik = %d\n"
