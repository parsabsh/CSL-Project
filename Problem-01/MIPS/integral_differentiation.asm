########################################
#                                      #
#        Problem 1 - CSL Project       #
#                                      #
########################################
	.data
n:	.word 	0
coef:	.space 	100
space:	.asciiz " "
c:	.asciiz "c"

	.text 
main:	li 	$v0,5
	syscall 
	sw 	$v0,n
	add 	$v0,$v0,1
	add	$t1,$v0,$v0
	add	$t1,$t1,$t1   # t1 = 4 * (n + 1)
	li 	$t0,0
	li 	$v0,6
	
inp_lp:	syscall 
	s.s 	$f0,coef($t0)
	addi 	$t0,$t0,4
	blt 	$t0,$t1,inp_lp
	li	$v0,5
	syscall 
	beq 	$v0,1,integ
#################################
#        Differentiation        #
#################################
	jal	init
	l.s	$f2,n
	cvt.s.w $f0,$f2       # f0 = n
	sub	$t1,$t1,4     # t1 = 4 * n
d_loop:	l.s 	$f1,coef($t0)
	mul.s 	$f12,$f0,$f1
	li	$v0,2
	syscall 
	li	$v0,4
	syscall 
	sub.s  	$f0,$f0,$f3   # f0 = f0 - 1
	addi 	$t0,$t0,4
	blt 	$t0,$t1,d_loop
	b	end
#################################
#          Integration          #
#################################
integ:	jal	init
	l.s	$f2,n
	cvt.s.w $f0,$f2
	add.s 	$f0,$f0,$f3   # f0 = n + 1
i_loop:	l.s 	$f1,coef($t0)
	div.s 	$f12,$f1,$f0
	li	$v0,2
	syscall 
	li	$v0,4
	syscall 
	sub.s  	$f0,$f0,$f3   # f0 = f0 - 1
	addi 	$t0,$t0,4
	blt 	$t0,$t1,i_loop
	la	$a0,c
	syscall 
	b	end
#################################
#     Some Initializations      #
#################################
init:	la	$a0,space
	li	$t5,1
	mtc1	$t5,$f2
	cvt.s.w $f3,$f2       # f3 = 1
	li 	$t0,0
	jr	$ra

end:	
