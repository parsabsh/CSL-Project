
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
n2       dw      ?    
nn       dw      ?
i       dw      ?    
j       dw      ? 
tedad       dw      ?
dn      dw      ?
msg    db      "Enter the n: $"   
msgsc    db      "Enter the tedad: $"
msge    db       "Enter values in seperate lines: $",0Dh,0Ah,'$'

nodes   dw      200 dup(0)
color   dw      '  '
colors  dw      200 dup(0)

newl    db      0Dh,0Ah,'$'

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
        mov cx, 65
        mov colors[bx], cx
        mov bx,n
        mov ax,1
        mov i,ax
        mov ax,0
        mov j,ax
        
        
        for1:
            
            mov ax, i
            mov bx, n
            
            cmp ax, bx
            jbe end_for1
            
            mov color,65
            for2:
                
                mov ax, color
                mov bx, 71
                cmp ax, bx
                jge end_for2
            
                mov dx,1 ;;;flag
                mov ax, 0
                mov j, ax
                for3:
                
                    mov ax, j
                    mov bx, i
                    cmp ax, bx
                    jge end_for3
                
                    mov ax, n
                    mov bx, i
                    mul bx
                    mov bx, j
                    add ax, bx
                    mov bx, 2
                    mul bx
                    mov bx,ax
                    mov ax, nodes[bx]
                    mov bx, 49
                    cmp ax, bx
                    jne else3
                    
                    mov bx, j
                    mov ax,2
                    mul bx
                    mov ax, colors[bx]
                    mov cx, color
                    cmp ax, cx
                    je if3
                    
                    cmp bx, cx
                    jne else3
                    
                    if3:
                    
                    mov dx, 0
                    jmp end_for3
                    
                    else3:
                    
                    mov ax, j
                    inc ax
                    mov j, ax
                    
                    mov ax, j
                    mov bx, i
                    cmp ax, bx
                    jge for3
                    end_for3:
                
                
                mov ax, 1
                cmp dx, ax
                je if4
                
                cmp dx, ax
                jne else4
                
                if4:
                    mov bx, i
                    mov ax, color
                    mov colors[bx], ax
                    jmp end_for2
                
                else4:
            
                mov bx,color
                inc bx
                mov color,bx
                
                
                mov bx,color
                cmp bx,71
                jne for2
                end_for2:
                
                
        
        
           mov ax,i
           inc ax
           mov i,ax
           
           mov ax,n
           mov bx,i
           cmp ax,bx
           jne for1
           end_for1:
        
          
        mov bx, 2
        mov ax,n
        mul bx
        mov n2,ax
        mov bx,0
        
        for_output:
          
           
           mov dx,colors[bx]
           mov ah,09h
           int 21h
           
              
           
           mov ax, n2
           
           inc bx
           inc bx
           cmp ax, bx
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