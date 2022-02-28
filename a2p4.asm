;Program to add two unpacked BCD numbers without using DAA
.model small
.stack 100h
.data
    x dw ?  ;first unpacked BCD number
    y dw ?  ;second unpacked BCD number
    x1 dw ? ;first number in decimal form
    y1 dw ? ;second number in decimal form
    z1 dw ? ;sum of x1 and y1
    zh db ?  ;higher byte of unpacked BCD
    zl db ?  ;lower byte of unpacked BCD
    cc db 0 ;loop counter variable
    count dw 0 ;printnum - digit counter
    intg dw 0  ;printnum - I/O for inputnum and printnum
    digt dw 0  ;printnum - extracted digit
    var1 dw 0  ;printnum - reversed number
    newl db 10,13,'$'
    msg1 db 'Enter first unpacked BCD number   : (BIN) $'
    msg2 db 'Enter second unpacked BCD number  : (BIN) $'
    msg3 db 'Addition in decimal :',10,13,'$'
    msg4 db ' + $'
    msg5 db ' = $'
    msg6 db 'Addition in unpacked BCD :',10,13,'$'
.code
main proc
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in x
    call inputbcd
    mov x,bx
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    ;taking input in y
    call inputbcd
    mov y,bx
    ;converting unpacked x to decimal x1
    mov ax,x  ;ax=x
    mov bl,ah ;bl=ah
    mov dh,0  ;dh=0
    mov dl,al ;dl=al
    mov ah,0  ;ah=0
    mov al,bl ;al=bl
    mov bl,10 ;bl=10
    mul bl    ;ax=al*bl
    add ax,dx ;ax=ax+dx
    mov x1,ax ;x1=ax
    ;converting unpacked y to decimal y1
    mov ax,y  ;ax=y
    mov bl,ah ;bl=ah
    mov dh,0  ;dh=0
    mov dl,al ;dl=al
    mov ah,0  ;ah=0
    mov al,bl ;al=bl
    mov bl,10 ;bl=10
    mul bl    ;ax=al*bl
    add ax,dx ;ax=ax+dx
    mov y1,ax ;y1=ax
    ;adding z1 = x1 + y1
    mov ax,x1
    mov bx,y1
    add ax,bx
    mov z1,ax
    ;printing msg3
    mov dx,offset msg3
    mov ah,9
    int 21h
    ;printing x1 in decimal
    mov bx,x1
    mov intg,bx
    call printnum
    ;printing msg4
    mov dx,offset msg4
    mov ah,9
    int 21h
    ;printing y1 in decimal
    mov bx,y1
    mov intg,bx
    call printnum
    ;printing msg5
    mov dx,offset msg5
    mov ah,9
    int 21h
    ;printing z1 in decimal
    mov bx,z1
    mov intg,bx
    call printnum
    ;printing newl
    mov dx,offset newl
    mov ah,9
    int 21h
    ;printing msg6
    mov dx,offset msg6
    mov ah,9
    int 21h
    ;printing x1 in BCD
    mov bx,x1
    call printbcd
    ;printing msg4
    mov dx,offset msg4
    mov ah,9
    int 21h
    ;printing y1 in BCD
    mov bx,y1
    call printbcd
    ;printing msg5
    mov dx,offset msg5
    mov ah,9
    int 21h
    ;printing z1 in BCD
    mov bx,z1
    call printbcd
    ;exit program
    mov ah,4ch
    int 21h
main endp
inputbcd proc ;inputs a BCD integer and stores it in BX
    mov bx,0
    mov cl,1
    loop3:
        mov ah,1
        int 21h
        cmp al,13
        je endloop3
        sub al,48
        rol bx,cl
        or bl,al
        jmp loop3
    endloop3:
    ret
inputbcd endp
printbcd proc ;prints a BCD integer stored in BX
    ;extracting digits and unpacking
    mov ax,bx
    mov bl,10
    div bl
    mov zh,al
    mov zl,ah
    ;printing higher byte in BCD format
    mov bx,0
    mov bl,zh
    mov cc,0
    loop4:
        mov bh,0
        mov cl,1
        rol bx,cl
        mov dl,bh
        add dl,48
        mov ah,2
        int 21h
        inc cc
        cmp cc,8
    jl loop4
    ;printing lower byte in BCD format
    mov bx,0
    mov bl,zl
    mov cc,0
    loop5:
        mov bh,0
        mov cl,1
        rol bx,cl
        mov dl,bh
        add dl,48
        mov ah,2
        int 21h
        inc cc
        cmp cc,8
    jl loop5
    ret
printbcd endp
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