// argumenty przekazywane przez rejestr, 
// wszystkie rejestry zachowywane przez wołającego
	.intel_syntax noprefix
	.globl main
	.text

main:

	mov ecx, 10
	call silnia

	push eax
	push offset msg
	call printf
	add esp, 8

	mov eax, 0
	ret

silnia:
	push ecx
	push edx
	cmp ecx, 0
	jne dalej
	mov eax, 1
	pop edx
	pop ecx
	ret
dalej:
	mov edx, ecx
	dec ecx
	call silnia
	mul edx
	pop edx
	pop ecx
	ret

	.data
msg:	.asciz "silnia=%d\n"
