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
m       dw      ?
size    dw      ?
curr_remainder  dw      ?
num_remainder   dw      ?
msgn    db      "Enter the n: $"
msgm    db      "Enter the m: $"
elements   dw    100 dup(0)
curr    dw      ?
address dw      ?
num     dw      ?
one     dw      1
msge   db       "Enter values in seperate lines: $",0Dh,0Ah,'$'
msgi    db      "Input was wrong!!!!!$"
msgdebug        db      "DEBUG$"
space   db      " $"
newl    db      0Dh,0Ah,'$'
buffer  db      100 dup(0),'$'
dataseg ENDS
         
         
codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg 
       
        
start:  mov     ax,dataseg
        mov     ds,ax

        ;get n
        mov     ah,9
        mov     dx,offset msgn
        int     21h
        call    getint   
        newline
        mov n,ax ;get n
        
        ;get m
        mov     ah,9
        mov     dx,offset msgm
        int     21h
        call    getint
        newline
        mov m,ax

        mov bx,n
        mul bx
        mov size,ax

        mov bx,0
        cmp ax,bx
        je terminate

        ;;;;;;;;;;;;
        ;   input  ;
        ;;;;;;;;;;;;
        mov cx,size
        mov bx,0
        input_loop: 
        call    getint
        newline
        mov     elements[bx],ax
        add     bx,2
        loop    input_loop


        ;;use dx for i and bx for j
        mov bx,0
        mov dx,0
        inner_loop:
        push dx
        push bx
        add bx,dx
        mov dx,0
        mov ax,bx
        mov bx,2
        div bx
        mov curr_remainder,dx
        pop bx
        pop dx ;find (i+j)%2


        push bx
        push dx
        mov ax,m
        mul dx
        mov dx,ax
        add bx,dx
        mov ax,2
        mul bx
        mov bx,ax;now we have 4*(i*m + j) in bx
        mov ax,elements[bx]
        mov curr,ax
        mov address,bx
        mov bx,2
        mov dx,0
        div bx
        mov num_remainder,dx
        mov bx,num_remainder
        mov dx,curr_remainder

        cmp bx,dx
        je end_of_loop
        ;;;;;;;;;;;;;;;
        ;;;;ADD ONE;;;;
        ;;;;;;;;;;;;;;;
        mov bx,curr
        add bx,1
        mov curr,bx
        end_of_loop:
        mov bx,address
        mov ax,curr
        mov elements[bx],ax
        pop dx
        pop bx
        add bx,1
        mov ax,m
        cmp ax,bx
        je handle_next_loop
        jmp inner_loop
        handle_next_loop:
        mov bx,0
        add dx,1
        mov ax,n
        cmp ax,dx
        jne inner_loop

 ;       mov cx,size
  ;      mov bx,0
   ;     looper:
    ;    mov ax,elements[bx]
     ;   add bx,2
      ;  call outint
       ; loop looper
        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;PRINTING;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;use dx as i and bx as j ;
        mov dx,0
        mov bx,0
        ploop:
        push dx
        push bx
        mov ax,m
        mul dx
        mov dx,ax
        add bx,dx
        mov ax,2
        mul bx
        mov bx,ax
        mov ax,elements[bx]
        call outint
        prspace
        pop bx
        pop dx
        add bx,1
        mov ax,m
        cmp ax,bx
        jne ploop 
        newline
        mov bx,0
        add dx,1
        mov ax,n
        cmp ax,dx
        jne ploop

        
        mov ax,4c00h
        int 21h

        terminate:
        mov     ah,9
        mov     dx,offset msgn
        int     21h

        mov ax,4c00h
        int 21h



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