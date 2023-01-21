.data
n: .word 1
nm4: .word 1
arr: .word 1
end_arr: .word 1

.text

__start:

#reding n:
li $v0,5
syscall
sw $v0,n
beq $v0,$zero,exit

#calculating n*4:
li $t0,4
lw $t1,n
mult $t0,$t1
mflo $t0
sw $t0,nm4

#allocating arr size of 4*n and store address on arr
lw $t0, nm4
move $a0, $t0
li $v0, 9
syscall
sw $v0, arr

#store a pointer to end of array in end_arr
lw $t0, arr
lw $t1, nm4
add $t0,$t0,$t1
sw $t0,end_arr

#get n number and save in arr
lw $t0, arr
lw $t1, end_arr
input_loop:
	li $v0, 5
	syscall
	sw $v0, ($t0)
	addi $t0,$t0,4
	bne $t0, $t1,input_loop

#check neighborhood :D
lw $t0,arr
lw $t2,end_arr
li $t6,0
outter_loop:
	lw $t3,($t0)
	lw $t1,arr
	li $t4,0
	inner_loop:
		lw $t5,($t1)
		sub $t5,$t5,$t3
		beq $t5,1,add_one
		there:
		addi $t1,$t1,4
		bne $t1,$t2,inner_loop
	add $t6,$t6,$t4
	addi $t0,$t0,4
	bne $t0,$t2,outter_loop

#print result
move $a0,$t6
li $v0, 1
syscall

#exit
exit:
li $v0, 10
syscall
	
add_one:
addi $t4,$t4,1
b there







