########################################
#                                      #
#        Problem 4 - CSL Project       #
#                                      #
########################################
 	.data
first:	.space 	100
second:	.space	100
res:	.space	100
null:	.byte 	0
fsize:	.word 	0
ssize:	.word   0
op:	.space 	1

	.text 
main:	la 	$a0,first
	li	$a1,100
	li	$v0,8
	syscall
	la 	$a0,second
	syscall
	la	$a0,op
	li	$a1,3
	syscall
	la	$t0,first
	jal	size
	sw 	$t1,fsize
	la	$t0,second
	jal	size
	sw	$t1,ssize
	lbu 	$t0,op
	beq 	$t0,'+',addlng
	beq 	$t0,'-',sublng
	beq 	$t0,'*',mullng
	beq 	$t0,'/',divlng
mcont:	la	$a0,res($t3)
	li	$v0,4
	syscall
	j 	end
###########################
#        Addition         #
###########################
addlng:	lw	$t1,fsize	# index in first word
	lw	$t2,ssize	# index in second word
	li	$t3,100		# index in result
	li 	$t5,0		# carry
adlop:	sub	$t1,$t1,1	# decrement first index
	sub	$t2,$t2,1	# decrement second index
	sub	$t3,$t3,1	# decrement result index
	blt	$t1,$zero,fzero	# a digit of first number ( or zero if index < 0 )
	lb	$t6,first($t1)	
	j	fcont
fzero:	li	$t6,0x30
fcont:	blt	$t2,$zero,szero	# a digit of second number ( or zero if index < 0 )
	lb	$t7,second($t2)
	j	scont
szero:	li	$t7,0x30
scont:	sub	$t6,$t6,0x30	# ascii to decimal digit
	sub	$t7,$t7,0x30	# ascii to decimal digit
	add	$t8,$t6,$t7	# t8 = first digit + second digit
	add	$t8,$t8,$t5	# add carry
	li	$t5,0		# carry = 0
	blt	$t8,10,nocar	# if result digit < 10 : no carry needed
	sub	$t8,$t8,10	# t8 = yekan of result
	li	$t5,1		# carry = 1
nocar:	beqz	$t8,chkend
notend:	add	$t8,$t8,0x30	# convert result digit to ascii
	sb	$t8,res($t3)	# store the result digit in res[index]
	b	adlop
chkend:	bgez 	$t1,notend	# if resutl is 0 and both indexes are negative, end addition
	bgez	$t2,notend
	addi	$t3,$t3,1	# result index increment
	j	mcont
###########################
#       Subtraction       #
###########################
sublng:	lw	$t1,fsize	# index in first word
	lw	$t2,ssize	# index in second word
	li	$t3,100		# index in result
	li 	$t5,0		# borrow
sublop:	sub	$t1,$t1,1	# decrement first index
	sub	$t2,$t2,1	# decrement second index
	sub	$t3,$t3,1	# decrement result index
	blt	$t1,$zero,ends	# a digit of first number
	lb	$t6,first($t1)	
	blt	$t2,$zero,szeros# a digit of second number ( or zero if index < 0 )
	lb	$t7,second($t2)
	j	sconts
szeros:	li	$t7,0x30
sconts:	sub	$t6,$t6,0x30	# ascii to decimal digit
	sub	$t7,$t7,0x30	# ascii to decimal digit
	sub	$t8,$t6,$t7	# t8 = first digit - second digit
	sub	$t8,$t8,$t5	# subtract borrow
	li	$t5,0		# borrow = 0
	bge	$t8,0,nobor	# if result digit > 0 : no borrow needed
	add	$t8,$t8,10	# t8 = t8+10
	li	$t5,1		# borrow = 1
nobor:	add	$t8,$t8,0x30	# convert result digit to ascii
	sb	$t8,res($t3)	# store the result digit in res[index]
	b	sublop
ends:	addi	$t3,$t3,1	# result index increment
	j	mcont
###########################
#      Multiplication     #
###########################
mullng:	la	$v0,first
###########################
#        Division         #
###########################
divlng:	la	$v0,first
##########################################################################################
# a subroutine to calculate the size of string which address is in t0 and store it in t1 
size:	move	$t3,$t0
slop:	lb	$t4,($t3)
	beq	$t4,'\n',retsiz
	add	$t3,$t3,1
	j	slop
retsiz:	sub	$t1,$t3,$t0   # t1 = end of string - start of string
	jr	$ra
##########################################################################################
end:	
