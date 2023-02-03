.data
n: .word 1
m: .word 1

pointer: .word 1
temp_pointer: .word 1

inp_n: .asciiz "input n: "
inp_m: .asciiz "input m: "
inp_matrix: .asciiz "input matrix in seperate lines:\n"
space: .asciiz " "
newline: .asciiz "\n"
wrong_input: .asciiz "Wrong input"

.text

__start:
#get n:
li $v0, 4
la $a0, inp_n
syscall
li $v0, 5
syscall
sw $v0, n


#get m:
li $v0, 4
la $a0, inp_m
syscall
li $v0, 5
syscall
sw $v0, m


lw $t0,n
lw $t1,m
mult $t0,$t1
mflo $t0
bne $t0,0,prog
la $a0,wrong_input
li $v0,4
syscall
li $v0,10
syscall

prog:
#print "input matrix":
li $v0, 4
la $a0, inp_matrix
syscall

#allocate matrix:
lw $t0, n
lw $t1, m
mult $t0, $t1 #calculate n*m
mflo $a0 
li $t0,4 
mult $a0,$t0 #calculate
mflo $a0
li $v0, 9
syscall
sw $v0, pointer


#input matrix:
lw $t0, n 
lw $t1, m 
mult $t0, $t1 
mflo $t0 #use t0 for n*m loop
lw $t1, pointer #use t1 for pointer
loop_input_matrix:
	li $v0, 5
	syscall
	sw $v0,($t1)
	addi $t1,$t1,4
	subi $t0,$t0,1
	bgt $t0,0,loop_input_matrix


lw $t0,n
lw $t1,m
li $t2,0 #i index
li $t3,0 #j index

outter_loop:
	
	inner_loop:
		mult $t2,$t1
		mflo $t4
		add $t4,$t4,$t3
		li $t5,4
		mult $t5,$t4
		mflo $t4 #4(i*n+j)
		lw $t5,pointer
		add $t5,$t5,$t4
		sw $t5,temp_pointer
		lw $t5,($t5)
		li $t6,2
		div $t5,$t6
		mfhi $t5
		add $t7,$t2,$t3
		div $t7,$t6
		mfhi $t7
		bne $t5,$t7,add_one
		b end_of_inner_loop
		add_one:
		lw $t5,temp_pointer
		lw $t6,($t5)
		addi $t6,$t6,1
		sw $t6,($t5)
		end_of_inner_loop:
		addi $t3,$t3,1
		bne $t3,$t1,inner_loop
		li $t3,0
		addi $t2,$t2,1
	bne $t2,$t0,outter_loop
		


jal print_matrix
li $v0,10
syscall

print_matrix: #changes $t0, $t1, $t2, $v0 ,$a0
	lw $t0, n
	lw $t2, pointer
	loop_n_print_matrix:
	lw $t1,m
	loop_print_matrix:
		lw $a0, ($t2)
		li $v0, 1
		syscall
		addi $t2,$t2,4
		la $a0, space
		li $v0, 4
		syscall
		subi $t1,$t1,1
		bge $t1,1,loop_print_matrix #loop on m
		la $a0, newline
		li $v0, 4
		syscall #print newline
		subi $t0,$t0,1
		bge $t0,1,loop_n_print_matrix
	jr $ra
		
