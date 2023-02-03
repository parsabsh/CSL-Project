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

dataseg SEGMENT 
n       dw      ?
coef    dw      100 dup(?)   ; the coefficients
result  dw      100 dup(?)
msgn    db      "Enter the order of polynomial: $"
msgc    db      "Enter coefficients (one per line):",0Dh,0Ah,'$'
press   db      "Press any key to continue... $"
c       db      "c$"
space   db      " $"
newl    db      0Dh,0Ah,'$'
buffer  db      19 dup(0),'$'
dataseg ENDS
         
         
codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg 
       
        
start:  mov     ax,dataseg
        mov     ds,ax
        mov     ah,9
        mov     dx,offset msgn
        int     21h
        call    getint
        newline
        mov     n,ax
        mov     ah,9
        mov     dx,offset msgc
        int     21h
        mov     cx,n
        inc     cx
        mov     bx,0
inplop: call    getint
        newline
        mov     coef[bx],ax
        add     bx,2
        loop    inplop
        call    getint
        newline
        cmp     ax,1
        je      integ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;       Differentiation       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        xor     bx,bx
        mov     cx,n
diflop: mov     ax,coef[bx]
        mul     cx
        call    outint
        prspace
        add     bx,2
        loop    diflop
        jmp     endpr
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         Integration         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
integ:  xor     bx,bx
        mov     cx,n
        inc     cx
intlop: mov     ax,coef[bx]
        xor     dx,dx
        div     cx
        call    outint
        prspace
        add     bx,2
        loop    intlop
        mov     dx,OFFSET c
        mov     ah,9
        int     21h
        newline
        
endpr:  mov     ah,9
        mov     dx,offset press
        int     21h
        mov     ah,1
        int     21h    
        mov     ax,4c00h
        int     21h

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

codeseg ENDS

            end start