########################################
#                                      #
#        Problem 7 - CSL Project       #
#                                      #
########################################
	.data 
equal:	.asciiz "="
plus:	.asciiz "+"
newl:	.asciiz "\n"
failed:	.ascii 	"Goldbach conjecture failed!!!\n"

	.text 
main:	li 	$v0,5
	syscall 
	move	$t0,$v0		# t0 = n
	li	$t1,4		# first even number to be checked
mainlp:	li	$t2,2		# start from 2
loop:	move	$t9,$t2		# check t2 to be prime
	jal 	isprim
	beqz 	$t8,next
	sub	$t9,$t1,$t2	# check n - t2	to be prime
	jal	isprim
	beqz	$t8,next
	j	print
next:	add	$t2,$t2,1
	blt 	$t2,$t1,loop
	li	$v0,4		# print "Goldbach conjecture failed!!!"
	la	$a0,failed
	syscall 
nextn:	add	$t1,$t1,2	# go to next even number to be checked
	ble 	$t1,$t0,mainlp	# continue up to n
	j	end
	
# a subroutine to chekc if the number in t9 is prime and store result in t8 (0=not prime, 1=prime)
isprim:	beq	$t9,2,prm
	li	$t3,2		# divisor
prloop:	div	$t9,$t3		# Hi = remainder of the "number" divided by the "divisor"
	mfhi	$t4
	beqz	$t4,notprm	# if mod is zero, it's not prime
	add	$t3,$t3,1	# increment the divisor
	blt 	$t3,$t9,prloop
prm:	li	$t8,1		# is prime
	jr	$ra
notprm:	li	$t8,0		# is not prime
	jr	$ra

# a subroutine to print "$t1=$t2+$t9"
print:	li	$v0,1
	move	$a0,$t1
	syscall 
	li	$v0,4
	la	$a0,equal
	syscall 
	li	$v0,1
	move	$a0,$t2
	syscall 
	li	$v0,4
	la	$a0,plus
	syscall 
	li	$v0,1
	move	$a0,$t9
	syscall 
	li	$v0,4
	la	$a0,newl
	syscall
	j	nextn
	
end: