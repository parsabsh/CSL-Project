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
result  db      100 dup(0)
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
        mov     dx,offset press
        int     21h
        mov     ah,1
        int     21h    
        mov     ax,4c00h
        int     21h        

        
        
addlng: mov     bx,100     ; result index
        clc
adlop:  dec     si
        dec     di
        dec     bx
        cmp     si,0       ; a digit of first number (or zero if index < 0)
        jl      fzero
        mov     al,          
    
input   PROC          
        xor     bx,bx
lop1:   mov     ah,1
        int     21h
        cmp     al,0Dh
        je      endlpi
        sub     al,'0'
        mov     first[bx],al
        inc     bx
        jmp     lop1
        mov     si,bx
        xor     bx,bx
lop2:   mov     ah,1
        int     21h
        cmp     al,0Dh
        je      endlpi
        sub     al,'0'
        mov     second[bx],al
        inc     bx
        jmp     lop2
        mov     di,bx                
endlpi: ret
input   ENDP

codeseg ENDS

        end     start