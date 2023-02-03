.globl __start
  __start:
    la $a0,str1 #Load and print string asking for string
    li $v0,4
    syscall

    li $v0,8 #take in input
    la $a0, buffer #load byte space into address
    li $a1, 20 # allot the byte space for string
    move $t0,$a0 #save string to t0
    syscall
    
    la $a0,str2 #Load and print string asking for string
    li $v0,4
    syscall

    li $v0,8 #take in input
    la $a0,string  #load byte space into address
    li $a1, 100 # allot the byte space for string
    move $t0,$a0 #save string to t0
    syscall
    
    #-------------------------
    #1
    la $a0, string
    la $a2, ans_lang1
    
    for1:
      lb $t1, ($a0)
      la $a1, buffer
      lb $t2, ($a1)
      bne $t2, $t1, next1
      lb $t3,one
      sb $t3,($a2)
      b done
      next1:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next2
      lb $t3,two
      sb $t3,($a2)
      b done
      next2:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next3
      lb $t3,three
      sb $t3,($a2)
      b done
      next3:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next4
      lb $t3,four
      sb $t3,($a2)
      b done
      next4:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next5
      lb $t3,five
      sb $t3,($a2)
      b done
      next5:
      lb $t3,zero
      sb $t3,($a2)
      done:
      
      addi $a0, $a0, 1
      
      lb $t1, ($a0)
      
      beq $t1, $zero, break_for1
      
      addi $a2, $a2, 1
      
      bne $t1, $zero, for1
      
      break_for1:
      addi $a0, $a0, -1
      
    
     
  
      
      




 

    la $a0, ans
    la $a1, test
    add $t0, $zero, $zero # size of ans 
    add $t1, $zero, $zero # size of test

    la $a2, zero ###
    lb $t5, ($a2) # "0"

    la $a2, one ###
    lb $t2, ($a2) # back value

    la $a2, ans_lang1
    
    
    la $a3, string

    loop1:
      lb $t3, ($a2) # ans_lang[i]
      lb $t4, ($a3) # string[i]


      bne $t3, $t5, els1 # if ans_lang[i] == 0

        add $t1, $zero, $zero
        la $a1, test

      els1:
      beq $t3, $t5, els2 # if ans_lang[i] != 0

        ble $t2, $t3, el2 # OR if back_value > ans_lang[i]

          make_test_empty1:
              add $t1,$zero,$zero
              la $a1,test
              b els3
 el2:
        bne $t2, $t5, els3 # if back_value == 0

          b make_test_empty1

        els3: # if back_value != 0 && back_value <= ans_lang[i]
   
   sb $t4,($a1)
          addi $a1,$a1,1
          addi $t1,$t1,1
          

          ble $t1, $t0, els4 # if test.size() > ans.size()

            addi $t0, $t1, 0
            add $t1, $zero,$zero
            la $a0, ans
            la $a1, test
            make_ans_and_test_same1:
              beq $t1, $t0, break_make_ans_and_test_same1

                lb $t6, ($a1)
                sb $t6,($a0)
                addi $a0,$a0,1
                addi $a1,$a1,1
                addi $t1,$t1,1

              bne $t1, $t0, make_ans_and_test_same1
              break_make_ans_and_test_same1:

          els4: # if test.size() <= ans.size()

      els2: # if ans_lang[i] == 0
       
      lb $t2, ($a2) #####
      addi $a2, $a2, 1
      addi $a3, $a3, 1

      lb $t4, ($a3)
      bne $t4, $zero, loop1

    la $a0, ans
    add $t6, $zero, $zero

    #output_ans1:
      #beq $t6, $t0, break_output_ans1      

      li $v0, 4
      
      syscall

      #addi $t6,$t6,1
      #addi $a0,$a0,1
      #b output_ans1

      #break_output_ans1:

    #-------------------------
    #2
      
    la $a0, string
    la $a2, ans_lang2
    
    for12:
      lb $t1, ($a0)
      la $a1, buffer
      addi $a1,$a1,5
      lb $t2, ($a1)
      bne $t2, $t1, next12
      lb $t3,one
      sb $t3,($a2)
      b done2
      next12:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next22
      lb $t3,two
      sb $t3,($a2)
      b done2
      next22:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next32
      lb $t3,three
      sb $t3,($a2)
      b done2
      next32:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next42
      lb $t3,four
      sb $t3,($a2)
      b done2
      next42:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next52
      lb $t3,five
      sb $t3,($a2)
      b done2
      next52:
      lb $t3,zero
      sb $t3,($a2)
      done2:
      
      addi $a0, $a0, 1
      
      lb $t1, ($a0)
      
      beq $t1, $zero, break_for12
      
      addi $a2, $a2, 1
      
      bne $t1, $zero, for12
      
      break_for12:
      addi $a0, $a0, -1
      
    
     
  
      
      




 

    la $a0, ans2
    la $a1, test2
    add $t0, $zero, $zero # size of ans 
    add $t1, $zero, $zero # size of test

    la $a2, zero ###
    lb $t5, ($a2) # "0"

    la $a2, one ###
    lb $t2, ($a2) # back value

    la $a2, ans_lang2
    
    
    la $a3, string

    loop12:
      lb $t3, ($a2) # ans_lang[i]
      lb $t4, ($a3) # string[i]


      bne $t3, $t5, els12 # if ans_lang[i] == 0

        add $t1, $zero, $zero
        la $a1, test2

      els12:
      beq $t3, $t5, els22 # if ans_lang[i] != 0

        ble $t2, $t3, el22 # OR if back_value > ans_lang[i]

          make_test_empty12:
              add $t1,$zero,$zero
              la $a1,test2
              b els32
 el22:
        bne $t2, $t5, els32 # if back_value == 0

          b make_test_empty12

        els32: # if back_value != 0 && back_value <= ans_lang[i]
   
   sb $t4,($a1)
          addi $a1,$a1,1
          addi $t1,$t1,1
          

          ble $t1, $t0, els42 # if test.size() > ans.size()

            addi $t0, $t1, 0
            add $t1, $zero,$zero
            la $a0, ans2
            la $a1, test2
            make_ans_and_test_same12:
              beq $t1, $t0, break_make_ans_and_test_same12

                lb $t6, ($a1)
                sb $t6,($a0)
                addi $a0,$a0,1
                addi $a1,$a1,1
                addi $t1,$t1,1

              bne $t1, $t0, make_ans_and_test_same12
              break_make_ans_and_test_same12:

          els42: # if test.size() <= ans.size()

      els22: # if ans_lang[i] == 0
       
      lb $t2, ($a2) #####
      addi $a2, $a2, 1
      addi $a3, $a3, 1

      lb $t4, ($a3)
      bne $t4, $zero, loop12
      
      la $a0,nextline
	li $v0, 4
	syscall

    la $a0, ans2
    add $t6, $zero, $zero

    #output_ans1:
      #beq $t6, $t0, break_output_ans1      

      li $v0, 4
      
      syscall

      #addi $t6,$t6,1
      #addi $a0,$a0,1
      #b output_ans1

      #break_output_ans1:

    #-------------------------
    #3
      
    la $a0, string
    la $a2, ans_lang3
    
    for13:
      lb $t1, ($a0)
      la $a1, buffer
      addi $a1,$a1,10
      lb $t2, ($a1)
      bne $t2, $t1, next13
      lb $t3,one
      sb $t3,($a2)
      b done3
      next13:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next23
      lb $t3,two
      sb $t3,($a2)
      b done3
      next23:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next33
      lb $t3,three
      sb $t3,($a2)
      b done3
      next33:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next43
      lb $t3,four
      sb $t3,($a2)
      b done3
      next43:
      addi $a1, $a1, 1
      lb $t2, ($a1)
      bne $t2, $t1, next53
      lb $t3,five
      sb $t3,($a2)
      b done3
      next53:
      lb $t3,zero
      sb $t3,($a2)
      done3:
      
      addi $a0, $a0, 1
      
      lb $t1, ($a0)
      
      beq $t1, $zero, break_for13
      
      addi $a2, $a2, 1
      
      bne $t1, $zero, for13
      
      break_for13:
      addi $a0, $a0, -1
      
    
     
  
      
      




 

    la $a0, ans3
    la $a1, test3
    add $t0, $zero, $zero # size of ans 
    add $t1, $zero, $zero # size of test

    la $a2, zero ###
    lb $t5, ($a2) # "0"

    la $a2, one ###
    lb $t2, ($a2) # back value

    la $a2, ans_lang3
    
    
    la $a3, string

    loop13:
      lb $t3, ($a2) # ans_lang[i]
      lb $t4, ($a3) # string[i]


      bne $t3, $t5, els13 # if ans_lang[i] == 0

        add $t1, $zero, $zero
        la $a1, test3

      els13:
      beq $t3, $t5, els23 # if ans_lang[i] != 0

        ble $t2, $t3, el23 # OR if back_value > ans_lang[i]

          make_test_empty13:
              add $t1,$zero,$zero
              la $a1,test3
              b els33
 el23:
        bne $t2, $t5, els33 # if back_value == 0

          b make_test_empty13

        els33: # if back_value != 0 && back_value <= ans_lang[i]
   
   sb $t4,($a1)
          addi $a1,$a1,1
          addi $t1,$t1,1
          

          ble $t1, $t0, els43 # if test.size() > ans.size()

            addi $t0, $t1, 0
            add $t1, $zero,$zero
            la $a0, ans3
            la $a1, test3
            make_ans_and_test_same13:
              beq $t1, $t0, break_make_ans_and_test_same13

                lb $t6, ($a1)
                sb $t6,($a0)
                addi $a0,$a0,1
                addi $a1,$a1,1
                addi $t1,$t1,1

              bne $t1, $t0, make_ans_and_test_same13
              break_make_ans_and_test_same13:

          els43: # if test.size() <= ans.size()

      els23: # if ans_lang[i] == 0
       
      lb $t2, ($a2) #####
      addi $a2, $a2, 1
      addi $a3, $a3, 1

      lb $t4, ($a3)
      bne $t4, $zero, loop13

	la $a0,nextline
	li $v0, 4
	syscall

    la $a0, ans3
    add $t6, $zero, $zero

    #output_ans1:
      #beq $t6, $t0, break_output_ans1      

      
      
      syscall

      #addi $t6,$t6,1
      #addi $a0,$a0,1
      #b output_ans1

      #break_output_ans1:

    #-------------------------


    li $v0,10 #end program
    syscall

    .data
        buffer: .space 20
        string: .space 100
        str1:  .asciiz "Enter lang with them: \n"
        str2:  .asciiz "\nstring:\n" 
        ans_lang1: .space 100 
        ans_lang2: .space 100 
        ans_lang3: .space 100 
        ans: .space 100 
        test: .space 100
        ans2: .space 100 
        test2: .space 100
        ans3: .space 100 
        test3: .space 100
        nextline:  .asciiz "\n" 
        zero: .asciiz "0"
        one: .asciiz "1"
        two: .asciiz "2"
        three: .asciiz "3"
        four: .asciiz "4"
        five: .asciiz "5"