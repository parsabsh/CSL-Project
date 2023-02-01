  
 .globl __start
    __start:
         la $a0,str1 #Load and print string asking for string
         li $v0,4
         syscall

         li $v0,8 #take in input
         la $a0, buffer #load byte space into address
         li $a1, 30 # allot the byte space for string
         move $t0,$a0 #save string to t0
         syscall
         
        la $a1, buffer
	li $t1, -2
	loop:
		lb $t0, ($a1)
		addi $a1, $a1, 1
		addi $t1, $t1, 1
		bne $t0, $zero, loop
	
	#for ha
	
	add $t3, $zero, $zero #t3 is 0
	add $t4, $zero, $zero #t4 is 0	
	add $t5, $zero, $zero #t5 is 0	
	
	lb $t6, baz
	lb $t7, base
	lb $t8, star
	
	
	first_loop:
		addi $t4, $t3, 1
		la $a1, buffer
		add $a1,$a1,$t3

		second_loop:
			#
			#code
			la $a2, buffer
			add $a2,$a2,$t4
			lb $t0, ($a1)
			lb $t9, ($a2)
			bne $t0 , $t6, noresault
			bne $t9 , $t7, noresault
			sb $t8 , ($a1)
			sb $t8 , ($a2)
			addi $t5, $t5,2				
			
		noresault:
			addi $t4, $t4, 1
			blt $t4, $t1, second_loop
			
		addi $t3, $t3, 1
		blt $t3, $t1, first_loop
		
		
	
	li $v0,4
	la $a0,buffer
	syscall
	
	li $v0,4
	la $a0,nextline
	syscall
	
	li $v0,1
	la $a0,($t5)
	syscall
	
	li $v0,4
	la $a0,nextline
	syscall
	
	add $t3, $zero, $zero #t3 is 0
	add $t4, $zero, $zero #t3 is 0
	la $a1, buffer
	find_index:
		addi $t4,$t3,1
		lb $t0, ($a1)
		bne $t0, $t8, no_count
		li $v0,1
		move $a0,$t4
		syscall
		li $v0,4
		la $a0,space
		syscall
	no_count:
		addi $t3, $t3, 1
		addi $a1,$a1,1
		blt $t3, $t1, find_index
			
	
	
	
	
	
        li $v0,10 #end program
        syscall

 .data
         buffer: .space 30
         str1:  .asciiz "Enter string(max 30 chars): \n"
         str2:  .asciiz "\nYou wrote:\n" 
         nextline:  .asciiz "\n" 
         baz: .asciiz "("
         base: .asciiz ")"
         star: .asciiz "*"
         space: .asciiz " "
