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

dataseg SEGMENT
n       dw      ?
equal   db      "=$" 
plus    db      "+$"
newl    db      0Dh,0Ah,'$'
buffer  db      19 dup(0),'$'
dataseg ENDS

codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg

start:  mov     ax,dataseg
        mov     ds,ax
        mov     ah,9  
        mov     ax,12345
        call    outint
        
        
        mov     ax,4c00h
        int     21h  
         
         
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

codeseg ENDS 
        end     start