;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                 ;
;     Problem 4 - CSL Project     ;
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

newline    MACRO    
    push    ax
    push    dx
    mov     ah,9
    mov     dx,offset newl
    int     21h
    pop     dx
    pop     ax
ENDM

dataseg SEGMENT 
first   db      100 dup(0)
second  db      100 dup(0)
result  db      100 dup(0),'$'
press   db      "Press any key to continue... $"
newl    db      0Dh,0Ah,'$'
buffer  db      19 dup(0),'$'
dataseg ENDS


codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg
        
        
start:  mov     ax,dataseg
        mov     ds,ax
        call    input
        mov     ah,1
        int     21h
        newline
        cmp     al,'+'
        je      addlng
        cmp     al,'-'
        je      sublng
cont:   mov     ah,9
        mov     dx,offset result
        add     dx,bx           ; index of start of result
        int     21h
        newline
        mov     dx,offset press
        int     21h
        mov     ah,1
        int     21h    
        mov     ax,4c00h
        int     21h        

;;;;;;;;;;;;;;;;;;;;;;
;      Addittion     ;
;;;;;;;;;;;;;;;;;;;;;;           
addlng: mov     bx,100     ; result index
        clc
        pushf
adlop:  dec     si
        dec     di
        dec     bx
        cmp     si,0       ; a digit of first number (or zero if index < 0)
        jl      fzero
        mov     al,first[si]
        jmp     fcont
fzero:  mov     al,0
fcont:  cmp     di,0       ; a digit of second number (or zero if index < 0)
        jl      szero
        mov     dl,second[di]
        jmp     scont
szero:  mov     dl,0
scont:  popf 
        adc     al,dl
        cmp     al,10
        jl      nocar
        sub     al,10      ; yekan of ax
        stc                ; carry = 1
        pushf
        jmp     notend
nocar:  clc
        pushf
        cmp     al,0
        je      chkend
notend: add     al,30h          ; decimal to ascii
        mov     result[bx],al   ; store the result
        jmp     adlop
chkend: cmp     si,0
        jnl     notend
        cmp     di,0
        jnl     notend
        inc     bx
        popf
        jmp     cont                                         
;;;;;;;;;;;;;;;;;;;;;;
;     Subtraction    ;
;;;;;;;;;;;;;;;;;;;;;;
sublng: mov     bx,100     ; result index
        clc                ; borrow = 0
        pushf
sublop: dec     si
        dec     di
        dec     bx
        cmp     si,0       ; a digit of first number
        jl      endsub
        mov     al,first[si]
        cmp     di,0       ; a digit of second number (or zero if index < 0)
        jl      szeros
        mov     dl,second[di]
        jmp     sconts
szeros: mov     dl,0
sconts: popf 
        sbb     al,dl
        cmp     al,0
        jge     nobor
        add     al,10      
        stc                ; borrow = 1
        pushf
        jmp     nends
nobor:  clc
        pushf
nends:  add     al,30h          ; decimal to ascii
        mov     result[bx],al   ; store the result
        jmp     sublop
endsub: inc     bx
        popf
        jmp     cont
        
        
;;;;;;;;;;;;;;;;;;;
;    Get Input    ;
;;;;;;;;;;;;;;;;;;;    
input   PROC          
        xor     bx,bx
lop1:   mov     ah,1
        int     21h
        cmp     al,0Dh
        je      endlp1
        sub     al,'0'
        mov     first[bx],al
        inc     bx
        jmp     lop1
endlp1: mov     si,bx
        xor     bx,bx
        newline
lop2:   mov     ah,1
        int     21h
        cmp     al,0Dh
        je      endlp2
        sub     al,'0'
        mov     second[bx],al
        inc     bx
        jmp     lop2
endlp2: mov     di,bx                
        newline
        ret
input   ENDP

codeseg ENDS

        end     start