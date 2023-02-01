	.data
clrPtr:	.word	0	# colors pointer
grPtr:	.word	0	# graph pointer
ws:	.asciiz	" "	
	
	
	.text
	.globl main

.macro getNumber($arg)
	li $v0, 5
	syscall
	move $arg, $v0
.end_macro

.macro matrixValue($arg, $i, $j)
	mul $s7, $i, $s0
	add $s7, $s7, $j
	mul $s7, $s7, 4
	lw $s6, grPtr
	add $s6, $s6, $s7
	
	lw $arg, 0($s6)
.end_macro

.macro colorsValue($arg, $i)
	mul $s7, $i, 4
	lw $s6, clrPtr
	add $s6, $s6, $s7
		
	lw $arg, 0($s6)
.end_macro

.macro printChar($num)
	lw $t2, clrPtr
	mul $t3, $num, 4
	add $t2, $t2, $t3
	
	lw $t2, 0($t2)
	
	li $v0, 11
	addiu $a0, $t2, 64
	syscall
	
	li $v0, 4
	la $a0, ws
	syscall
.end_macro

.macro colorsSave($i, $val)
	mul $s7, $i, 4
	lw $s6, clrPtr
	add $s6, $s6, $s7
		
	sw $val, 0($s6)
.end_macro

main:	getNumber($s0)	# n in $s0
	
	# allocate memory for graph
	mul $t0, $s0, $s0
	mul $t0, $t0, 4
	li $v0, 9
	move $a0, $t0
	syscall
	sw $v0, grPtr
	# allocate memory for colors
	mul $t0, $s0, 4
	li $v0, 9
	move $a0, $t0
	syscall
	sw $v0, clrPtr
	
	li $t0, 0	# i
	li $t1, 0	# j
	ginLoop1:
	li $t1, 0
		ginLoop2:
		# index in $t0
		mul $t2, $t0, $s0
		add $t2, $t2, $t1
		mul $t2, $t2, 4
		# address in $t4
		lw $t4, grPtr
		add $t4, $t4, $t2
		
		getNumber($t3)
		sw $t3, 0($t4)

		addi $t1, $t1, 1
		bne $t1, $s0, ginLoop2
	addi $t0, $t0, 1
	bne $t0, $s0, ginLoop1
	
	getNumber($s1) # k in $s1
	
	li $a0, 0
	jal coloring
	
	li $t0, 0
	fLoop:
	
	printChar($t0)
	
	addi $t0, $t0, 1
	bne $t0, $s0, fLoop
	
	
	
	li $v0, 10
	syscall

# vertes -> $a0
coloring:
	move $t2, $a0
	subi $sp, $sp, 16
	sw $t2, 12($sp)
	sw $t1, 8($sp)
	sw $ra, 4($sp)
	sw $t0, 0($sp)
	
	
	
	move $t0, $s0
	bne $t2, $t0, notBase
	
	end:
	li $v0, 1
	
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $ra, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	jr $ra
	
	notBase:
	
	li $t0, 0
	
	colLoop:
	addi $t1, $t0, 1
	
	move $a0, $t2	# t2 is vertex
	move $a1, $t1
	jal valid
	beq $v0, $zero, conCol
	
	colorsSave($t2, $t1)
	
	addi $a0, $t2, 1
	jal coloring
	
	bne $v0, $zero, end
	
	colorsSave($t2, $zero)
	
	conCol:
	
	addi $t0, $t0, 1
	bne $t0, $s1, colLoop
	
	
	lw $t2, 12($sp)
	lw $t1, 8($sp)
	lw $ra, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	jr $ra
	


# vertex -> $a0, color -> $a1 
# v0 -> valid or not
valid:
	subi $sp, $sp, 8
	sw $t0, 0($sp)
	sw $t3, 4($sp)

	li $t0, 0
	vLoop:
	matrixValue($t3, $a0, $t0)
	beq $t3, $zero, conV
	
	colorsValue($t3, $t0)
	bne $t3, $a1, conV
	
	# not valid
	li $v0, 0
	
	lw $t0, 0($sp)
	lw $t3, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
	conV:
	addi $t0, $t0, 1
	bne $t0, $s0, vLoop
	
	li $v0, 1
	lw $t0, 0($sp)
	lw $t3, 4($sp)
	addi $sp, $sp, 8
	jr $ra 
