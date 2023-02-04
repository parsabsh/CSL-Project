;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                 ;
;     Problem 1 - CSL Project     ;
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

prspace    MACRO    
    push    ax
    push    dx
    mov     ah,9
    mov     dx,offset space
    int     21h
    pop     dx
    pop     ax
ENDM

resultS SEGMENT
result  dw      100 dup(?)
resultS ENDS

postfixS SEGMENT
postfix dw      100 dup(?)
postfixS ENDS

opS     SEGMENT
op      dw      100 dup(?)
opS     ENDS

dataseg SEGMENT 
result_ptr      dup     200 ;doubel size of stack's length
postfix_ptr     dup     200 ;
op_ptr          dup     200 ;
msge   db       "Enter input: $",0Dh,0Ah,'$'
msgdebug        db      "DEBUG$"
space   db      " $"
newl    db      0Dh,0Ah,'$'
buffer  db      100 dup(0),'$'
dataseg ENDS
         
         
codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg 
        mov     ax,dataseg
        mov     ds,ax
        
        lea ax, op+200
        mov op_ptr,ax
        
        lea ax, postfix+200
        mov post_ptr,ax
        
        lea ax, result+200
        mov result_ptr,ax
        

        
start:  mov     ax,dataseg
        mov     ds,ax

        ;get n
        mov     ah,9
        mov     dx,offset msgn
        int     21h
        call    getint   
        newline
        mov n,ax ;get n
        


; gets a positive integer from input and store it in ax    
getint  PROC          
        push    cx
        push    bx
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
        pop     bx
        pop     cx
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

pushPlusResult  PROC
        pushfgpr
        
        mov ax,resultS
        mov ss,ax
        mov ax,result_ptr
        mov sp,ax

        pop ax
        pop bx
        add ax,bx
        push ax
        popfgpr
        ret
pushPlusResult  ENDP

codeseg ENDS

            end start