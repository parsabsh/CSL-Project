                         .model small
.stack 100h
.data
msg db 60 dup(?)
space db ' '
 
.code
start:
    mov ax,@data
    mov ds,ax
    mov si,offset msg
take: mov ah,1
    int 21h
    mov [si],al
    cmp al,13
    je display
    inc si
    jmp take
 
display: mov [si],'$'
    mov dl,10
    mov ah,2
    int 21h
    
    lea di,msg
    mov ch,48
    mov bh,48
    
    
func1:mov dl,[di]
    cmp dl,'$'
    je stopfunc
    mov si,di
    inc si

func2:mov cl,[si]
    cmp cl,'$'
    je stopfunc2
    cmp dl,'('
    jne nochange
    cmp cl,')'
    jne nochange
    mov dl , "*"
    mov cl , "*"
    mov [si] , dl
    mov [di] , cl
    inc ch
    cmp ch,57
    jne dahgan
    mov ch,47
    inc bh
    dahgan: 
    inc ch
    
    nochange:
    
    inc si
    cmp cl,cl
    je func2
    stopfunc2:
    inc di
    cmp cl,cl
    je func1
    
stopfunc:

    mov dl,bh
    mov ah,2
    int 21h

    mov dl,ch
    mov ah,2
    int 21h
       
    mov dl,10
    mov ah,2
    int 21h
   
   
   
    lea di,msg
    mov ch,49
    mov bh,48
    lea si,space
    
 
print:
    mov dl,[di]
    cmp dl,'$'
    je stop
    cmp dl,'*'
    jne inja
    inc ch
    cmp ch,57
    jne dahgan2
    mov ch,48
    inc bh
    dahgan2:
 
    mov dl,bh
    mov ah,2
    int 21h
    mov dl,ch
    mov ah,2
    int 21h
    mov dl,[si]
    mov ah,2
    int 21h
    inja:
    inc di 
    jmp print
 

stop: mov ah,4ch
    int 21h
end start
end