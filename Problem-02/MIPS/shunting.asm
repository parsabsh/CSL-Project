.data
input: .space 100
temp_input: .space 100
single: .byte 1
eof: .ascii "\0"

stack: .space 100
stack_ptr: .word 0

is_string: .space 100

postfix: .space 100
postfix_ptr: .word 0

result: .space 100
result_ptr: .word 0

length: .word 0
temp_number: .word 0
variables_count: .word 0
variables: .space 100

newline: .asciiz "\n"
space: .asciiz " "

debug: .asciiz "debug\n"
cp: .asciiz "closing paranthese"
text1: .asciiz "printing stack with length: "
text2: .asciiz "after printg stack:\n"

.text
li $v0,8
li $a1,100
la $a0,input
syscall



#counting variables in input
li $t0,0
count_variable:
	lb $t1,input($t0)	
	bgt $t1,122,end_count_loop
	blt $t1,65,end_count_loop
	bgt $t1,90,greater_90
	main_count_variable:
	move $v0,$t1
	jal find_variable
	beq $v1,1,end_count_loop
	#add var:
	move $v0,$t1
	jal add_variable
	b end_count_loop
	greater_90:
	bgt $t1,97,main_count_variable
	end_count_loop:
	addi $t0,$t0,1
	lb $t1,input($t0)
	bne $t1,'\0',count_variable

#initalize variables
li $t5,0
lw $t1,variables_count
beq $t1,0,after_initializing
init_var_loop:
	li $v0,8
	li $a1,100
	la $a0,temp_input
	syscall
	li $t0,2
	jal init_int
	move $v1,$v0
	lb $v0,temp_input
	jal set_value_for_variable
	addi $t5,$t5,1
	bne $t1,$t5,init_var_loop

#jal print_variables #ma inja natije gereftim ke in kar mikone:)
after_initializing:

li $t0,0
loop:
	lb $t1,input($t0)
	beq $t1,' ',end_of_loop
	bgt $t1,'9',non_number
	blt $t1,'0',non_number
	jal read_int
	move $a0,$v0
	li $a1,0
	jal push_postfix
	jal push_num
	b loop #end of numberic proccessing
	non_number:
	operators:
		#just push '(' to stack
		bne $t1,'(',after_opening_paranthese
		li $a0,'('
		jal push_op
		b end_of_loop
		after_opening_paranthese:
		
	#	#just pushing '^' to stack
	#	bne $t1,'^',after_power
	#	lw $t2,stack_ptr
	#	subi $t2,$t2,1	
	#	power_loop:
	#		lb $t3,stack($t2)
	#		subi $t2,$t2,1
	#		bne $t3,'^',end_power_loop
	#		jal pop_op
	#		li $a0,'^'
	#		li $a1,1
	#		jal push_postfix
	#		end_power_loop:
	#	li $a0,'^'
	#	jal push_op
	#	b end_of_loop
	#	after_power:
		
		#pushing * and /
		beq $t1,'*',is_div_or_star
		beq $t1,'/',is_div_or_star
		b after_star
		is_div_or_star:
		lw $t2,stack_ptr
		subi $t2,$t2,1
		star_loop:
			lb $t3,stack($t2)
			subi $t2,$t2,1
			beq $t3,'*',pop_for_star_div
			beq $t3,'/',pop_for_star_div
			b end_of_star_loop
			pop_for_star_div:
			jal pop_op
			
			beq $v0,'/',div_pushing	
			jal push_star	
			b after_push_result_star	
			div_pushing:
			jal push_div
			after_push_result_star: 
			
			move $a0,$v0
			li $a1,1
			jal push_postfix
			b star_loop
			end_of_star_loop:
		move $a0,$t1
		jal push_op #pop from stack to postfix until find a '(' or '+' or '-'
		b end_of_loop
		after_star:
		
		#pushing + and -
		beq $t1,'-',is_plus_or_negative
		beq $t1,'+',is_plus_or_negative
		b after_plus_negative
		is_plus_or_negative:
		lw $t2,stack_ptr
		subi $t2,$t2,1
		pn_loop:
			lb $t3,stack($t2)
			subi $t2,$t2,1
			beq $t3,'(',end_pn_loop
			jal pop_op
			
			beq $t3,'/',push_div_after_pn
			beq $t3,'*',push_star_after_pn
			beq $t3,'-',push_minus_after_pn
			
			jal push_plus
			b after_push_for_pn
			push_div_after_pn:
			jal push_div
			b after_push_for_pn
			
			push_star_after_pn:	
			jal push_star
			b after_push_for_pn
			
			push_minus_after_pn:
			jal push_minus
			b after_push_for_pn
			
			after_push_for_pn:		
			
			move $a0,$v0
			li $a1,1
			jal push_postfix
			b pn_loop
			end_pn_loop:
		move $a0,$t1
		jal push_op
		b end_of_loop
		after_plus_negative:
		
		#pushing closing paranthese
		bne $t1,')',after_closing_paranthese
		lw $t2,stack_ptr
		subi $t2,$t2,1
		parantheses_loop:
			lb $t3,stack($t2)
			jal pop_op
			move $a0,$v0
			li $a1,1
			beq $t3,'(',end_paranthese_loop
			
			beq $t3,'/',push_div_after_par
			beq $t3,'*',push_star_after_par
			beq $t3,'-',push_minus_after_par
			
			jal push_plus
			b after_push_for_par
			push_div_after_par:
			jal push_div
			b after_push_for_par
			
			push_star_after_par:	
			jal push_star
			b after_push_for_par
			
			push_minus_after_par:
			jal push_minus
			b after_push_for_par
			
			after_push_for_par:	
			
			
			jal push_postfix
			subi $t2,$t2,1
			b parantheses_loop
			end_paranthese_loop:
		b end_of_loop
		after_closing_paranthese:
	variables_proc:
		move $v0,$t1
		jal find_variable
		move $a0,$v0
		jal push_num
		li $a1,1
		move $a0,$t1
		jal push_postfix
	end_of_loop:
	addi $t0,$t0,1
	lb $t1,input($t0)
	bne $t1,'\0',loop

end:

jal print_postfix

la $a0,newline
li $v0,4
syscall

lw $a0,result
li $v0,1
syscall

li $v0,10
syscall
	
#functions:
read_int:
sw $zero,temp_number
li $t3,'0'
read_int_loop:
	lb $t2,input($t0)
	bgt $t2,'9',end_of_read_int
	blt $t2,'0',end_of_read_int
	lw $t2,temp_number
	li $t4,10
	mult $t2,$t4
	mflo $t2
	sw $t2,temp_number
	lb $t2,input($t0)
	sub $t2,$t2,$t3
	lw $t4,temp_number
	add $t4,$t4,$t2
	sw $t4,temp_number
	addi $t0,$t0,1
	b read_int_loop
end_of_read_int:
lw $v0,temp_number
jr $ra


init_int:
sw $zero,temp_number
li $t3,'0'
init_int_loop:
	lb $t2,temp_input($t0)
	bgt $t2,'9',end_of_init_int
	blt $t2,'0',end_of_init_int
	lw $t2,temp_number
	li $t4,10
	mult $t2,$t4
	mflo $t2
	sw $t2,temp_number
	lb $t2,temp_input($t0)
	sub $t2,$t2,$t3
	lw $t4,temp_number
	add $t4,$t4,$t2
	sw $t4,temp_number
	addi $t0,$t0,1
	b init_int_loop
end_of_init_int:
lw $v0,temp_number
jr $ra




push_op:
lw $t7,stack_ptr
sb $a0,stack($t7)
addi $t7,$t7,1
sw $t7, stack_ptr
jr $ra

pop_op:
lw $t7,stack_ptr
subi $t7,$t7,1
sw $t7,stack_ptr
lb $v0,stack($t7)
jr $ra

push_postfix: #a0 is value and a1 is a0 is string or number
lw $t7,postfix_ptr
sw $a0,postfix($t7)
sw $a1,is_string($t7)
addi $t7,$t7,4
sw $t7, postfix_ptr
lw $t7, length
addi $t7,$t7,1
sw $t7,length
jr $ra

pop_postfix:
lw $t7,postfix_ptr
subi $t7,$t7,4
sw $t7,postfix_ptr
lw $v0,stack($t7)
jr $ra

####### RESULT STACK ###########
push_num: #a0 is value and a1 is a0 is string or number
lw $t7,result_ptr
sw $a0,result($t7)
addi $t7,$t7,4
sw $t7, result_ptr
jr $ra

push_plus:
lw $t7,result_ptr
subi $t7,$t7,8
lw $t5,result($t7)
lw $t6,result+4($t7)
add $t5,$t5,$t6
sw $t5,result($t7)
addi $t7,$t7,4
sw $t7,result_ptr
jr $ra

push_minus:
lw $t7,result_ptr
subi $t7,$t7,8
lw $t5,result($t7)
lw $t6,result+4($t7)
sub $t5,$t5,$t6
sw $t5,result($t4)
addi $t7,$t7,4
sw $t7,result_ptr
jr $ra

push_star:
lw $t7,result_ptr
subi $t7,$t7,8
lw $t5,result($t7)
lw $t6,result+4($t7)
mult $t5,$t6
mflo $t5
sw $t5,result($t7)
addi $t7,$t7,4
sw $t7,result_ptr
jr $ra

push_div:
lw $t7,result_ptr
subi $t7,$t7,8
lw $t5,result($t7)
lw $t6,result+4($t7)
div $t5,$t6
mflo $t5
sw $t5,result($t7)
addi $t7,$t7,4
sw $t7,result_ptr
jr $ra

### END OF RESULT STACK ###

print_postfix:
li $v0,5
syscall

li $t0,0
li $t4,4
lw $t3,length
mult $t4,$t3
mflo $t3
print_loop:
	lw $t1,is_string($t0)
	beq $t1,0,is_num
	is_str:
	lw $t2,postfix($t0)
	sb $t2,single
	la $a0,single
	li $v0,4
	syscall
	b end_print_loop
	is_num:
	lw $t2,postfix($t0)
	move $a0,$t2
	li $v0,1
	syscall
	end_print_loop:
	la $a0,space
	li $v0,4
	syscall
	addi $t0,$t0,4
	bne $t0,$t3,print_loop
jr $ra



find_variable: #v0 is name of variable if v1 = 1 (means variable exist)
lw $t5,variables_count
li $t6,0 #use as counter
li $t7,0 #use as index
	find_variable_loop:
	beq $t5,$t6,end_find_variable_loop
	lw $t4,variables($t7)
	beq $t4,$v0,send_found_variable
	addi $t6,$t6,1
	addi $t7,$t7,8
	b find_variable_loop
	end_find_variable_loop:
#not found:	
li $v0,0
jr $ra
send_found_variable:
li $v1,1
lw $v0,variables+4($t7)
jr $ra


add_variable:#v0 is name of variable
lw $t6,variables_count
li $t7,8
mult $t6,$t7
mflo $t6
sw $v0,variables($t6)
lw $t6,variables_count
addi $t6,$t6,1
sw $t6,variables_count
jr $ra


set_value_for_variable:#v0 name of variable and v1 is value and v0 must exist
li $t6,0
	find_loop:
	lw $t7,variables($t6)
	addi $t6,$t6,8
	bne $t7,$v0,find_loop
	subi $t6,$t6,8
	sw $v1,variables+4($t6)
jr $ra



print_stack:
	lw $t7,stack_ptr
	la $a0,text1
	li $v0,4
	syscall
	move $a0,$t7
	li $v0,1
	syscall
	la $a0,newline
	li $v0,4
	syscall
	li $t6,0
	print_stack_loop:
		lb $t5,stack($t6)
		sb $t5,single
		la $a0,single
		li $v0,4
		syscall
		li $v0,4
		la $a0,space
		syscall
		addi $t6,$t6,1
		bne $t6,$t7,print_stack_loop
	li $v0,4
	la $a0,newline
	syscall
	jr $ra


print_variables:
li $t0,0
lw $t1,variables_count
li $t2,0
print_var_loop:
	lw $t3,variables($t2)
	sw $t3,single
	la $a0,single
	li $v0,4
	syscall
	li $v0,4
	la $a0,space
	syscall
	lw $t3,variables+4($t2)
	li $v0,1
	move $a0,$t3
	syscall
	la $a0,newline
	li $v0,4
	syscall
	addi $t0,$t0,1
	addi $t2,$t2,8
	bne $t0,$t1,print_var_loop
jr $ra