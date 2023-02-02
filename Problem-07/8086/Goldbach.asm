;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                 ;
;     Problem 7 - CSL Project     ;
;                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   

pushfgpr   MACRO     ; push flags and general purpose registers
    pushf
    push    ax
    push    bx
    push    cx
    push    dx
ENDM

popfgpr    MACRO     ; pop flags and general purpose registers
    pop     dx
    pop     cx
    pop     bx
    pop     ax    
    popf
ENDM

cmpm       MACRO    first,second    ; compare two words in memory
    push    ax
    mov     ax,first
    cmp     ax,second
    pop     ax
ENDM

dataseg SEGMENT
n       dw      ?       ; input
divisor dw      ?       ; used in chekcing for being prime
number  dw      4       ; the even numbers to be tested (4 <= number <= n)
isprime dw      0       ; a temp variable (0: not prime, 1: prime)
a       dw      ?       ; to be find for every even "number" which a and number-a are prime
equal   db      "=$" 
plus    db      "+$"
newl    db      0Dh,0Ah,'$'
buffer  db      19 dup(0),'$'
failed  db      "Goldbach conjecture failed!!!$"

dataseg ENDS

codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg

start:  mov     ax,dataseg
        mov     ds,ax
        call    getint
        mov     n,ax
mainlp: mov     a,2         ; start from 2
lop:    mov     ax,a        ; ax = a
        call    isprm       ; check if a is prime
        cmp     isprime,0
        je      next
        mov     ax,number   ; ax = number - a
        sub     ax,a  
        call    isprm       ; check if number - a is prime
        cmp     isprime,0
        je      next
        jmp     print
next:   add     a,1
        cmpm    a,number
        jl      lop
        mov     dx,OFFSET failed ; print "Goldbach conjecture failed!!!"
        mov     ah,9
        int     21h                       
nextn:  add     number,2
        cmpm    number,n
        jle     mainlp        
        mov     ax,4c00h
        int     21h  
         

; check if the number in ax is prime and store the result in "isprime" variable
isprm   PROC
        cmp     ax,2        ; if ax == 2, it's prime
        je      prm
        mov     divisor,2
prloop: push    ax
        mov     dx,0
        div     divisor
        cmp     dx,0        ; if remainder is zero, then it's not prime
        je      notprm
        inc     divisor
        cmp     divisor,ax
        pop     ax
        jl      prloop
prm:    mov     isprime,1   ; is prime
        ret
notprm: mov     isprime,0   ; is not prime
        pop     ax
        ret    
isprm   ENDP

         
; gets a positive integer from input and store it in ax    
getint  PROC          
        mov     ax,0
        mov     cx,10
lopi:   push    ax
        mov     ah,1
        int     21h
        cmp     al,0Dh
        je      endlpi
        sub     al,'0'
        mov     bl,al
        xor     bh,bh
        pop     ax
        mul     cx
        add     ax,bx
        jmp     lopi        
endlpi: pop     ax
        ret
getint  ENDP 


; print a positive integer stored in ax into output
outint  PROC
        pushfgpr
        mov     bx,10 
        mov     cx,0                    ; number of digits
        mov     di,OFFSET buffer + 18   ; using di as string index
lopoi:  mov     dx,0
        div     bx
        add     dl,'0'
        mov     [di],dl                 ; store digit in buffer
        dec     di
        inc     cx
        cmp     ax,0
        jne     lopoi
        mov     ah,09h                  ; print buffer string
        mov     dx,OFFSET buffer + 19
        sub     dx,cx
        int     21h
        popfgpr
        ret
outint  ENDP


; print "{number}={a}+{number-a}\n"
print:  mov     ax,number           ; number
        call    outint
        mov     dx,OFFSET equal     ; =
        mov     ah,9
        int     21h
        mov     ax,a                ; a
        call    outint
        mov     dx,OFFSET plus
        mov     ah,9
        int     21h
        mov     ax,number           ; number - a
        sub     ax,a
        call    outint
        mov     dx,OFFSET newl      ; newline
        mov     ah,9
        int     21h
        jmp     nextn
        
codeseg ENDS 
        end     start