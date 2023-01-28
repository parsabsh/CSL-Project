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
    push    dx
    push    cx
    push    bx
    push    ax    
    popf
ENDM

dataseg SEGMENT 
n       dw      ?
coef    dw      100 dup(?)   ; the coefficients
dps     dw      100 dup(0)   ; the number of decimal points in each coefficient
isneg   dw      100 dup(0)   ; the sign of each coefficient
msgn    db      "Enter the order of polynomial: $"
msgc    db      "Enter coefficients (one per line):",0Dh,0Ah,'$'
dataseg ENDS
         
         
codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg 
       
        
start:  mov     ax,dataseg
        mov     ds,ax
        mov     ah,9
        mov     dx,offset msgn
        int     21h
        call    getint
        mov     n,ax
        mov     ah,9
        mov     dx,offset msgc
        int     21h
        mov     ah,1
        int     21h    
        mov     ax,4c00h
        int     21h


getint  proc    ; gets a positive integer from input and store it in ax      
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
getint  endp    
        
codeseg ENDS

            end start