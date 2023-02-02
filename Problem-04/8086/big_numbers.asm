        .data
num1      dw      12345h, 6789h
num2      dw      9876h, 5432h
result    dw      0, 0
        .code
        mov     bx, 0  ; Initialize carry flag
add_loop:
        mov     ax, [num1]
        add     ax, [num2]
        adc     bx, 0  ; Add carry flag
        mov     [result], ax
        add     num1, 2
        add     num2, 2
        add     result, 2
        cmp     num1, 10h
        jne     add_loop
        mov     ax, 4c00h
        int     21h
