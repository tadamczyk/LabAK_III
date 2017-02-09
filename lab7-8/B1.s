.intel_syntax noprefix
	.text
	.globl main
main:
	mov eax, 100
	push eax
	mov eax, offset mesg
	push eax
	call printf
	add esp, 8
	ret
	mov eax, 0
	ret
	.data
mesg:
	.ascii "Hello, world: %d\n"
	.byte 0
