                         .model small
.stack 100h
.data
msg db 60 dup(?)
msg2 db "123456789abcdef"
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
    mov bl,0
    
    
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
    inc bl
    inc bl
    
    nochange:
    
    inc si
    cmp cl,cl
    je func2
    stopfunc2:
    inc di
    cmp cl,cl
    je func1
    
stopfunc:

    mov dl,bl
    mov ah,2
    int 21h
       
    mov dl,10
    mov ah,2
    int 21h
   
   
   
    lea di,msg
    lea si,msg2
 
print: mov dl,[di]
    cmp dl,'$'
    je stop
    cmp dl,'*'
    jne inja
    mov cl,[si]   
    mov dl,cl
    mov ah,2
    int 21h
    inja:
    inc di
    inc si 
    jmp print
 

stop: mov ah,4ch
    int 21h
end start
end