//******************************//
//       TOMASZ ADAMCZYK        //
//       Nr albumu: 243217      //
//       Informatyka II ROK     //
//       Projekt4.s             //
//******************************//

//       Zadanie nr 7           //

.intel_syntax noprefix
.text
.globl _start

_start:

first_arg:
  mov eax, 0
  mov ecx, [esp+8]
  mov bl, byte ptr [ecx]
  sub bl, '0'
  movzx ebx, bl
  add eax, ebx
  mov edx, eax
  cmp byte ptr [ecx+1], 0
  je second_arg
  mov bl, byte ptr [ecx+1]
  sub bl, '0'
  movzx ebx, bl
  imul eax, 10
  add eax, ebx
  mov edx, eax
  cmp byte ptr [ecx+2], 0
  je second_arg
  mov bl, byte ptr [ecx+2]
  sub bl, '0'
  movzx ebx, bl
  imul eax, 10
  add eax, ebx
  mov edx, eax

second_arg:
  mov eax, 0
  mov ecx, [esp+12]
  mov bl, byte ptr [ecx]
  sub bl, '0'
  movzx ebx, bl
  add eax, ebx
  mov ebx, eax
  cmp byte ptr [ecx+1], 0
  je third_arg
  mov bl, byte ptr [ecx+1]
  sub bl, '0'
  movzx ebx, bl
  imul eax, 10
  add eax, ebx
  mov ebx, eax
  cmp byte ptr [ecx+2], 0
  je third_arg
  mov bl, byte ptr [ecx+2]
  sub bl, '0'
  movzx ebx, bl
  imul eax, 10
  add eax, ebx
  mov ebx, eax

third_arg:
  mov eax, edx
  mov ecx, [esp+16]
  cmp byte ptr [ecx], '-'
  jz only_min
  cmp byte ptr [ecx], 'x'
  jz only_star
  jmp prefinal_wrong

only_min:
  cmp byte ptr [ecx+1], 0
  jz subtraction
  jmp prefinal_wrong

only_star:
  cmp byte ptr [ecx+1], 0
  jz multiply
  jmp prefinal_wrong

subtraction:
  sub eax, ebx
  jmp before_conv

multiply:
  imul eax, ebx
  jmp before_conv

before_conv:
  cmp eax, 0
  jl add_min
  jmp add_plus

add_min:
  imul eax, -1
  mov ebx, '-'
  mov [sum], ebx
  jmp conv

add_plus:
  mov ebx, ' '
  mov [sum], ebx

conv:
  mov ecx, 10
  xor ebx, ebx

divide:
  xor edx, edx
  div ecx
  push edx
  inc ebx
  test eax, eax
  jnz divide

next_digit:
  pop eax
  add eax, '0'
  mov [sum+1], eax
  dec ebx
  cmp ebx, 0
  je prefinal_good
  pop eax
  add eax, '0'
  mov [sum+2], eax
  dec ebx
  cmp ebx, 0
  je prefinal_good
  pop eax
  add eax, '0'
  mov [sum+3], eax
  dec ebx
  cmp ebx, 0
  je prefinal_good
  pop eax
  add eax, '0'
  mov [sum+4], eax
  dec ebx
  cmp ebx, 0
  je prefinal_good
  pop eax
  add eax, '0'
  mov [sum+5], eax
  dec ebx
  cmp ebx, 0
  je prefinal_good
  pop eax
  add eax, '0'
  mov [sum+6], eax
  dec ebx
  cmp ebx, 0
  je prefinal_good

prefinal_good:
  mov  edx, 7
  mov  ecx, offset sum
  mov  ebx, 1
  mov  eax, 4
  int  0x80
  jmp final

prefinal_wrong:
  mov edx, 20
  mov ecx, offset wrong_msg
  mov  ebx, 1
  mov  eax, 4
  int 0x80
  jmp final

final:
  mov  edx, 1
  mov  ecx, offset newline
  mov  ebx, 1
  mov  eax, 4
  int  0x80
  mov  eax, 1
  int  0x80

.data
wrong_msg:
  .asciz "Wrong last argument!"

newline:
  .ascii "\n"

sum:
  .byte 0, 0, 0, 0
