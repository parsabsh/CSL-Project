.data
n: .word 1
m: .word 1
mmod: .word 1

pointer: .word 1

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
li $t0,2
div $v0,$t0
mfhi $t0
sw $t0,mmod

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
mult $t0,$t1
mflo $t2
li $t0,4
mult $t0,$t2
mflo $t2
lw $t3,pointer
add $t2,$t2,$t3#points to end of array
subi $t2,$t2,4
lw $t3,m
li $t0,1
loop:
lw $t1,($t2)
add $t1,$t1,$t0
sw $t1,($t2)
li $t5,1
sub $t0,$t5,$t0
subi $t3,$t3,1
subi $t2,$t2,4
bne $t3,0,loop
lw $t3,m
lw $t4,mmod
beq $t4,1,odd
li $t5,1
sub $t0,$t5,$t0
odd:
lw $t4,pointer
subi $t4,$t4,4
bne $t4,$t2,loop

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
		
