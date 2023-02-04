
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

msg1    MACRO    
    push    ax
    push    dx
    mov     ah,9
    mov     dx,offset msg
    int     21h
    pop     dx
    pop     ax
ENDM
msg2    MACRO    
    push    ax
    push    dx
    mov     ah,9
    mov     dx,offset msgsc
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
nn       dw      ?
i       dw      ?    
j       dw      ? 
tedad       dw      ?
dn      dw      ?
size    dw      ?
result  dw       ?
msg    db      "Enter the n: $"   
msgsc    db      "Enter the tedad: $"
nodes   dw      200 dup(0)
color   dw      '  '
colors  dw      20 dup(0)
msge    db       "Enter values in seperate lines: $",0Dh,0Ah,'$'
space   db      " $"
newl    db      0Dh,0Ah,'$'
buffer  db      100 dup(0),'$'
dataseg ENDS
         
         
codeseg SEGMENT
        assume  cs:codeseg,ds:dataseg 
       
        
start:  mov     ax,dataseg
        mov     ds,ax
        msg1
        call    getint   
        newline

        mov n,ax ;get n
        mov ax,2
        mul n
       
     
        mov dn,ax
        cmp ax,0
        je end_prg
       
        mov ah,9
        mov dx,offset msge
        int 21h
        
        

        ;;input n*n values in n*n lines:
        
        mov ax,n
        mov bx,n
        mul bx
        mov cx,ax
        mov nn,cx
        mov bx,0
        input_loop:
            call getint
            newline
            mov nodes[bx],ax
            add bx,2
            loop input_loop
        
          
        msg2        
        call    getint   
        newline
        mov tedad,ax ;get tedad
        mov bx,0
        mov cx, 'A '
        mov colors[bx], cx
        mov bx,n
        mov i,ax
        mov j,ax
        
        
        for1:
            mov color,'A'
            for2:
            
                mov dx,1 ;;;flag
                mov ax, 0
                mov j, ax
                for3:
                
                    mov ax, n
                    mov bx, i
                    mul bx
                    mov bx, j
                    add ax, bx
                    mov bx, 2
                    mul bx
                    mov cx, nodes[ax]
                    mov bx, 1
                    cmp cx, bx
                    jne else3
                    
                    mov ax, j
                    mov bx, colors[ax]
                    mov cx, color
                    cmp bx, cx
                    je if3
                    
                    cmp bx, cx
                    jne else3
                    
                    if3:
                    
                    mov dx, 0
                    mov ax, i
                    dec ax
                    mov j, ax
                    
                    else3:
                    
                    mov ax, j
                    inc ax
                    mov j, ax
                    
                    mov ax, j
                    mov bx, i
                    cmp ax, bx
                    jne for3
                
                
                mov ax, 1
                cmp dx, ax
                je if4
                
                cmp dx, ax
                jne else4
                
                if4:
                    mov ax, i
                    mov bx, color
                    mov colors[ax], bx
                    mov bx, 'Z'
                    mov color, bx
                
                else4:
            
                mov bx,color
                inc bx
                mov color,bx
                
                
                mov bx,color
                cmp bx,'['
                jne for2
                
                
        
        
           mov ax,i
           inc ax
           mov i,ax
           
           mov ax,n
           mov i,bx
           cmp ax,bx
           jne for1
        
          
        mov cx, 0
        for_output:
           mov bx, colors[cx]
           
           mov dl,[bx]
           mov ah,2
           int 21h
           
           inc cx
           
           mov bx, n
           cmp cx, bx
           jne for_output 
        
        
        
        end_prg:
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



codeseg ENDS

            end start