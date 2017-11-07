	.data
memoria:
mensaje: .asciiz "El resultado de las sumas de los % numeros es %, y es multiplo de %"
valores: .byte 0x02, 0x03, 0x04
res: .space 100
	
	.text
	.globl main

main:
	la a0, mensaje	#loads mensaje, valores y res
	la a1, valores
	la a2, res
	jal escribir_resultado

salida:
	move a0, v0
	li v0, 4001
	syscall
	
escribir_resultado:
	addi sp, sp, -12 #allocate 12
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)

	li t0, 3 #3 char to be changed

_loop:
	lb t1, 0(a0) #load char
	beq t1, 0, _fin #if null, finish
	bne t1, 0x25, _seguir #if not %, just copy
	lb t1, 0(a1) #if %, load the number 
	addi t1, t1, 0x30 #converts it to a valid ascii
	addi a1, a1, 1 #increments valores mem dir

_seguir:
	sb t1, 0(a2) #copy
	addi a0, a0, 1 #increments mensaje
	addi a2, a2, 1 #increments res
	j _loop 
_fin:
	lw a0, 0(sp) #deallocate
	lw a1, 4(sp)
	lw a2, 8(sp)
	addi sp, sp, 12