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
dn      dw      ?
size    dw      ?
result dw       ?
msgn    db      "Enter the n: $"
nodes   dw      100 dup(0)
curr    dw      ?
one     dw      1
msge   db       "Enter values in seperate lines: $",0Dh,0Ah,'$'
msgi    db      "Input was wrong!!!!!$"
space   db      " $"
newl    db      0Dh,0Ah,'$'
buffer  db      100 dup(0),'$'
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
        mov n,ax ;get n
        mov ax,2
        mul n
        mov dn,ax
        cmp ax,0
        je terminate
       
        mov ah,9
        mov dx,offset msge
        int 21h

        ;;input n values in n lines:
        mov cx,n
        mov bx,0
        input_loop:
            call getint
            newline
            mov nodes[bx],ax
            add bx,2
            loop input_loop 
        
        ;;handle operation:
        mov bx,0
        outter_loop:
        mov cx,nodes[bx]
        mov curr,cx
        mov cx,0
        
        add cx,2
            handle_loop:
            cmp cx,dn
            je end_handle_loop
            push bx
            mov bx,cx
            mov dx,nodes[bx]
            pop bx
            sub dx,curr
            cmp dx,one
            je add_one
            add cx,2
            cmp cx,dn
            je end_handle_loop
            jmp handle_loop
            add_one:
            add result,dx
            add cx,2
            cmp cx,dn
            je end_handle_loop
            jmp handle_loop
            end_handle_loop:
            add bx,2
            cmp bx,dn
            je end_prg
            jmp outter_loop
        
        end_prg:
        mov ax,result
        call outint
        mov ax,4c00h
        int 21h


        terminate:
        mov     ah,9
        mov     dx,offset msgi
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