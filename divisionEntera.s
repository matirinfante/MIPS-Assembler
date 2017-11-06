	.data
memoria: 
valor: .byte 93
divisor: .byte 4
cociente: .byte 0
resto: .byte 0

	.text
	.globl _start
	.globl main

_start:
main:
	lw a0, valor
	lw a1, divisor
	jal division
	lb t0, 3(v0)
	lb t1, 3(v1)
	sb t0, cociente
	sb t1, resto

division:
	addi sp, sp, -8
	sw a0, 0(sp)
	sw a1, 4(sp)

	#a0 dividendo, a1 divisor
	and v0, v0, zero
	and v1, v1, zero
	#v0 cociente, v1 resto

	_loop:
		sub a0, a0, a1 #resto
		blt a0, zero, _fin
		blt a0, a1, _terminar
		addi  v0, v0, 1
		j _loop

	_terminar: 
		addi  v0, v0, 1
		move v1, a0

	_fin:
		lw a0, 0(sp)
		lw a1, 4(sp)
		addi sp, sp, 8
		jr ra
