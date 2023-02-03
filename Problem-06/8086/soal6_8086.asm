.model small
.stack 100h

.data
lang1 db '      '  
lang2 db '      '
lang3 db '      '
string db '                                       '  
space db '       '
string_test db '                                   '  
spac db '       '
string_handel db '                                   '    
 
space2 db '       '
string_test2 db '                                   '  
spac3 db '       '
string_handel2 db '                                   '          

space3 db '       '
string_test3 db '                                   '  
spa db '       '
string_handel3 db '                                    '                                   



 
.code
start:
    mov ax,@data
    mov ds,ax
    lea si,lang1
take_lang1: 
    mov ah,1
    int 21h
    mov [si],al
    cmp al,13
    je display_lang1
    inc si
    jmp take_lang1
 
display_lang1: 
    
    mov dl,10
    mov ah,2
    int 21h
    ;------------------------------ 
    lea si,lang2
take_lang2: 
    mov ah,1
    int 21h
    mov [si],al
    cmp al,13
    je display_lang2
    inc si
    jmp take_lang2
 
display_lang2: 
    
    mov dl,10
    mov ah,2
    int 21h
    ;------------------------------    
    lea si,lang3
take_lang3: 
    mov ah,1
    int 21h
    mov [si],al
    cmp al,13
    je display_lang3
    inc si
    jmp take_lang3
 
display_lang3: 
    mov dl,10
    mov ah,2
    int 21h
    ;------------------------------    
    lea si, string
take_string: 
    mov ah,1
    int 21h
    mov [si],al
    cmp al,13
    je display_string
    inc si
    jmp take_string
 
display_string: 
    mov [si],'$'
    mov dl,10
    mov ah,2
    int 21h
    ;------------------------------  
    
    ;----copy string
     lea di,string
     lea si,string_test
func_copy:
    mov dl,[di]
    mov [si],dl
     
    inc di
    inc si
    cmp dl,'$'
    jne func_copy
    
    
    lea di,string_test
     
func_lang1:
    lea si,lang1
    mov dl,[di]
    cmp dl,'$'
    je stopfunc
    mov cl,[si]
    cmp dl,cl
    jne stopfunc1
    mov [di],'1'
    inc di
    jmp func_lang1
stopfunc1:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc2
    mov [di],'2'
    inc di
    jmp func_lang1
stopfunc2:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc3
    mov [di],'3'
    inc di
    jmp func_lang1
stopfunc3:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc4
    mov [di],'4'
    inc di
    jmp func_lang1
stopfunc4:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc5
    mov [di],'5'
    inc di
    jmp func_lang1
stopfunc5:
    mov [di],'0' 
    inc di
    jmp func_lang1        
    
stopfunc:

     lea di,string_test
     lea si,string_handel
func_copy2:
    mov dl,[di]
    mov [si],dl
     
    inc di
    inc si
    cmp dl,'$'
    jne func_copy2
    
    lea di,string_test
    lea si,string_handel
handel:    
    mov dl,[di]
    inc di
    inc si
    mov cl,[di]
    cmp cl,'$'
    je done
    cmp cl,'0'
    je handel0
    cmp cl,dl
    jl handel0 
    mov [si],'1'
    jmp handel
    handel0:
    mov [si],'0'
    jmp handel
    
done: 
      lea di,string_handel
      mov ch,0
      mov bh,0 
      mov si,0
loop1:
    cmp cx,bx
    jle edame
    inc bx
    mov si,di
    edame:
    mov dl,[di]
    cmp dl,'$'
    
    je done3
    inc di
    cmp dl,'0'
    je zeroo
    inc cx  
    jmp loop1
    zeroo:
    mov cx,0
    jmp loop1
done3:
        
    lea di,string_handel
    
    sub si,bx
    sub si,di
              
    
    
    
    mov dl,10
    mov ah,2
    int 21h          
    
    
    
    lea di,string
    add di,si
print2:

    mov dl,[di]
    cmp bx,0
    je stop1
    mov ah,2
    int 21h
    inc di
    dec bx 
    jmp print2

stop1:

;-----------------------------------------
;-----------------------------------------
   ;2
    
    ;----copy string
     lea di,string
     lea si,string_test2
func_cop2:
    mov dl,[di]
    mov [si],dl
     
    inc di
    inc si
    cmp dl,'$'
    jne func_cop2
    
    
    lea di,string_test2
     
func_lang12:
    lea si,lang2
    mov dl,[di]
    cmp dl,'$'
    je stopfun2
    mov cl,[si]
    cmp dl,cl
    jne stopfunc12
    mov [di],'1'
    inc di
    jmp func_lang12
stopfunc12:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc22
    mov [di],'2'
    inc di
    jmp func_lang12
stopfunc22:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc32
    mov [di],'3'
    inc di
    jmp func_lang12
stopfunc32:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc42
    mov [di],'4'
    inc di
    jmp func_lang12
stopfunc42:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc52
    mov [di],'5'
    inc di
    jmp func_lang12
stopfunc52:
    mov [di],'0' 
    inc di
    jmp func_lang12        
    
stopfun2:

     lea di,string_test2
     lea si,string_handel2
func_copy22:
    mov dl,[di]
    mov [si],dl
     
    inc di
    inc si
    cmp dl,'$'
    jne func_copy22
    
    lea di,string_test2
    lea si,string_handel2
handel2:    
    mov dl,[di]
    inc di
    inc si
    mov cl,[di]
    cmp cl,'$'
    je done22
    cmp cl,'0'
    je handel02
    cmp cl,dl
    jl handel02 
    mov [si],'1'
    jmp handel2
    handel02:
    mov [si],'0'
    jmp handel2
    
done22: 
      lea di,string_handel2
      mov ch,0
      mov bh,0 
      mov si,0
loop12:
    cmp cx,bx
    jle edame2
    inc bx
    mov si,di
    edame2:
    mov dl,[di]
    cmp dl,'$'
    
    je done32
    inc di
    cmp dl,'0'
    je zeroo2
    inc cx  
    jmp loop12
    zeroo2:
    mov cx,0
    jmp loop12
done32:
        
    lea di,string_handel2
    
    sub si,bx
    sub si,di
              
    
    
    
    mov dl,10
    mov ah,2
    int 21h          
    
    
    
    lea di,string
    add di,si
print22:

    mov dl,[di]
    cmp bx,0
    je stop12
    mov ah,2
    int 21h
    inc di
    dec bx 
    jmp print22

stop12: 


;-----------------------------------------
;-----------------------------------------
  ;3
    
    ;----copy string
     lea di,string
     lea si,string_test3
func_cop23:
    mov dl,[di]
    mov [si],dl
     
    inc di
    inc si
    cmp dl,'$'
    jne func_cop23
    
    
    lea di,string_test3
     
func_lang123:
    lea si,lang3
    mov dl,[di]
    cmp dl,'$'
    je stopfun23
    mov cl,[si]
    cmp dl,cl
    jne stopfunc123
    mov [di],'1'
    inc di
    jmp func_lang123
stopfunc123:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc223
    mov [di],'2'
    inc di
    jmp func_lang123
stopfunc223:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc323
    mov [di],'3'
    inc di
    jmp func_lang123
stopfunc323:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc423
    mov [di],'4'
    inc di
    jmp func_lang123
stopfunc423:    
    inc si
    mov cl,[si]
    cmp cl,dl
    jne stopfunc523
    mov [di],'5'
    inc di
    jmp func_lang123
stopfunc523:
    mov [di],'0' 
    inc di
    jmp func_lang123        
    
stopfun23:

     lea di,string_test3
     lea si,string_handel3
func_copy223:
    mov dl,[di]
    mov [si],dl
     
    inc di
    inc si
    cmp dl,'$'
    jne func_copy223
    
    lea di,string_test3
    lea si,string_handel3
handel23:    
    mov dl,[di]
    inc di
    inc si
    mov cl,[di]
    cmp cl,'$'
    je done223
    cmp cl,'0'
    je handel023
    cmp cl,dl
    jl handel023 
    mov [si],'1'
    jmp handel23
    handel023:
    mov [si],'0'
    jmp handel23
    
done223: 
      lea di,string_handel3
      mov ch,0
      mov bh,0 
      mov si,0
loop123:
    cmp cx,bx
    jle edame23
    inc bx
    mov si,di
    edame23:
    mov dl,[di]
    cmp dl,'$'
    
    je done323
    inc di
    cmp dl,'0'
    je zeroo23
    inc cx  
    jmp loop123
    zeroo23:
    mov cx,0
    jmp loop123
done323:
        
    lea di,string_handel3
    
    sub si,bx
    sub si,di
              
    
    
    
    mov dl,10
    mov ah,2
    int 21h          
    
    
    
    lea di,string
    add di,si
print223:

    mov dl,[di]
    cmp bx,0
    je stop123
    mov ah,2
    int 21h
    inc di
    dec bx 
    jmp print223

stop123:     
 
    
 

stop: mov ah,4ch
    int 21h
end start


end