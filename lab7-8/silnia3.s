// argumenty przekazywane przez stos, 
// za uporządkowanie stosu odpowiada wywoływana funkcja
// wszystkie rejestry zachowywane przez wołanego
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
	mov ebp, esp
	mov eax, [ebp+4]
	cmp eax, 0
	jne dalej
	mov eax, 1
	ret 4
dalej:
	dec eax
	push ebp
	push eax
	call silnia
	pop ebp
	mov ecx, [ebp+4]
	mul ecx
	ret 4

	.data
msg:	.asciz "silnia=%d\n"
