.intel_syntax noprefix
.text
.globl _start

_start:
	mov eax, 0
	mov ecx, [esp+8]
	mov bl, byte ptr [ecx]
	sub bl, '0'
	movzx ebx, bl
	add eax, ebx
	cmp byte ptr [ecx+1], 0
	je conv
	mov bl, byte ptr [ecx+1]
	sub bl, '0'
	movzx ebx, bl
	imul eax, 10
	add eax, ebx
	cmp byte ptr [ecx+2], 0
	je conv
	mov bl, byte ptr [ecx+2]
	sub bl, '0'
	movzx ebx, bl
	imul eax, 10
	add eax, ebx

conv:
	mov ecx, 10
	xor ebx, ebx

divide:
	xor edx, edx
	div ecx
	push dx
	inc ebx
	test eax, eax
	jnz divide
	mov ecx, ebx

next_digit:
	pop ax
	add al, '0'
	mov [sum], al
	dec ebx
	cmp ebx, 0
	je final
	pop ax
	add al, '0'
	mov [sum+1], al
	dec ebx
	cmp ebx, 0
	je final
	pop ax
	add al, '0'
	mov [sum+2], al
	dec ebx
	cmp ebx, 0
	je final

final:
	mov edx, 0
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	mov	edx, 3
	mov	ecx, offset sum
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	mov	edx, 1
	mov	ecx, offset msg
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	mov	eax, 1
	int	0x80

.data
msg: .ascii "\n"
sum: .byte 0, 0, 0, 0
