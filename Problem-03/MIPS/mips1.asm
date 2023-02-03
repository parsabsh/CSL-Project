.data
	n: .word 0
	matrix: .word 0
	space: .asciiz  " "
.macro	cinInt($arg)
		
	li $v0, 5
	syscall
		
	move $arg, $v0
		
.end_macro
	
.macro	coutInt($arg)
	
	move $a0, $arg
	li $v0, 1
	syscall
	
.end_macro

.macro	coutSpace()
	
	la $a0, space
	li $v0, 4
	syscall
	
.end_macro

.macro determinant($d)

	li $t0, 0
	lw $s0, n($t0)
	
	li $t0, 1
	beq $s0, $t0, end1 # if n > 1
	
	
	
	
	
	
	li $t0, 0
	lw $s0, n($t0)
	li $t0, 1
	bne $s0, $t0, end2
	end1:
		
	li $t0, 0
	lw $s0, matrix($t0)
	move $d, $s0
	
	end2:
	
	# end of the macro

.end_macro 

.text
	main:
	
		# reading size of matrix
		cinInt($s0)
		li $t0, 0
		sw $s0, n($t0)
		
		# allocate data for matrix
		li $t0, 0
		lw $s0, n($t0)
		mul $s0, $s0, $s0
		mul $s0, $s0, 4
		li $v0, 9
		move $a0, $s0
		syscall
		sw $v0, matrix
		
		# reading the matrix
		li $t0, 0
		lw $s0, n($t0)
		mul $s0, $s0, $s0
		li $t0, 0 # i
		
		loop1:
			
			mul $t1, $t0, 4
			
			cinInt($s1)
			sw $s1, matrix($t1)
			
			addi $t0, $t0, 1
			
			bne $t0, $s0, loop1
			
		# calculate determinant
		determinant($d)
		
		li $v0, 10
		syscall 
		
		
		
		
		