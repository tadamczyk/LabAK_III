// argumenty przekazywane przez stos, 
// za uporządkowanie stosu odpowiada wywołujący funkcję
// wszystkie rejestry zachowywane przez wołanego
	.intel_syntax noprefix
	.globl main
	.text

main:
	mov eax, 10

	push eax
	call silnia
	add esp, 4

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
	ret
dalej:
	push eax
	dec eax
	push eax
	call silnia
	add esp, 4
	pop ecx
	mul ecx
	pop edx
	pop ecx
	pop ebp
	ret

	.data
msg:	.asciz "silnia=%d\n"
