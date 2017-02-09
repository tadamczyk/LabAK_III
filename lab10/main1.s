.intel_syntax noprefix
.text
.globl main

main:
	push ebp
	mov ebp, esp
	mov ebx, [esp+12]
	mov ebx, [ebx]
	push ebx
	push offset msg
	call printf
	add esp, 8
	pop ebp
	mov eax, 0
	ret

.data
msg:
	.asciz "Nazwa programu: %s\n"
