.intel_syntax noprefix
.text
.globl _start

_start:
	mov edx, 0
	mov ecx, [esp+8]

petla:
	inc edx
	cmp byte ptr [ecx+edx-1], 0
	jnz petla
	mov eax, 4
	mov ebx, 1
	// mov ecx, [esp+4]
	// mov edx, 5
	int 0x80
	mov eax, 4
	mov ebx, 1
	mov ecx, offset msg
	mov edx, 1
	int 0x80
	mov eax, 1
	mov ebx, 0
	int 0x80

.data
msg:
	.ascii "\n"
