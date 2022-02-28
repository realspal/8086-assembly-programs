;Program to calculate GCD of two unsigned 16 bit numbers
.model small
.stack 100h
.data
    num1 dw ? ;first number
    num2 dw ? ;second number
    count dw 0 ;printnum - digit counter
    intg dw 0  ;printnum - I/O for inputnum and printnum
    digt dw 0  ;printnum - extracted digit
    var1 dw 0  ;printnum - reversed number
    msg1 db 'Enter first number  : $'
    msg2 db 'Enter second number : $'
    msg3 db 'Greatest common divisor (GCD) = $'
.code
main proc
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in num1
    call inputnum
    mov bx,intg
    mov num1,bx
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    ;taking input in num2
    call inputnum
    mov bx,intg
    mov num2,bx
    ;calculating GCD
    call getgcd
    ;printing msg3
    mov dx,offset msg3
    mov ah,9
    int 21h
    ;printing GCD
    call printnum
    ;exit program
    mov ah,4ch
    int 21h
main endp
getgcd proc ;calculates GCD of two integers
    mov bx,num1
    mov var1,bx
    cmp bx,num2
    je endsolve
    jl solve ;else swap num1 and num2
    push num1
    push num2
    pop num1
    pop num2
    solve: ;here num1 < num2, always
        mov ax,num2
        mov dx,0
        div var1
        cmp dx,0
        jne skip
            mov ax,num1
            mov dx,0
            div var1
            cmp dx,0
            je endsolve
        skip:
            dec var1
    jmp solve       
    endsolve:
        mov bx,var1
        mov intg,bx
        ret
getgcd endp
inputnum proc ;inputs an integer
    mov intg,0
    iter1:
        mov ah,1
        int 21h
        cmp al,13
        je enditer1
        sub al,48
        mov ah,0
        mov digt,ax
        mov ax,intg
        mov bx,10
        mul bx
        add ax,digt
        mov intg,ax
    jmp iter1
    enditer1:
        ret
inputnum endp
printnum proc ;prints an integer
    mov var1,0
    mov count,0
    iter2:
        mov ax,intg
        mov bl,10
        div bl
        mov dl,ah
        mov ah,0
        mov intg,ax
        mov al,dl
        mov digt,ax
        mov ax,var1
        mov bx,10
        mul bx
        add ax,digt
        mov var1,ax
        inc count
        cmp intg,0
        jle enditer2
    jmp iter2
    enditer2:
        mov bx,var1
        mov intg,bx
        mov cx,count
        iter3:
            mov ax,intg
            mov bl,10
            div bl
            mov dl,ah
            mov ah,0
            mov intg,ax
            add dl,48
            mov ah,2
            int 21h
        loop iter3
        ret
printnum endp
end main