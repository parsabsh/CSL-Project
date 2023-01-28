########################################
#                                      #
#        Problem 4 - CSL Project       #
#                                      #
########################################
 	.data 
first:	.space 	100
second:	.space	100
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
	lbu 	$t1,op
	beq 	$t1,'+',add
	j 	end
###########################
#        Addition         #
###########################
add:	la	$v0,first
end:	