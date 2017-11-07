	.data
memoria:
number: .byte 20
times: .byte 2
	
	.text
	.globl main

main:
	la a0, number
	la a1, times
	jal multiplicacion

salida:
	move a0, v0
	li v0, 4001
	syscall

multiplicacion:
	addi sp, sp, -8 #allocate 12
	sw a0, 0(sp)
	sw a1, 4(sp)
	and v0, v0, zero

_loop:
	beq a1, 0, _fin
	add v0, v0, a0
	addi a1, a1, -1
	j _loop 
_fin:
	lw a0, 0(sp) #deallocate
	lw a1, 4(sp)
	addi sp, sp, 8