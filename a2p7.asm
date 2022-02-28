;Program to check for password
.model small
.stack 100h
.data
    pw db 'afternoon$' ;original password
    str db 100 dup(0) ;entered password
    plen db 9 ;length of original password
    len db 0 ;length of entered password
    f db 0 ;flag
    try db 0 ;tries
    msg1 db 'Enter password : $'
    msg2 db 'Wrong password! Try again. $'
    msg3 db ' attempt(s) left.',10,13,'$'
    msg4 db 'You are authorized person.$'
    msg5 db 'Maximum tries exceeded.$'
.code
main proc 
    mov ax,@data
    mov ds,ax
    loop1:
        inc try
        mov f,0
        ;printing msg1
        mov dx,offset msg1
        mov ah,9
        int 21h
        ;taking input in str
        mov len,0
        mov si,offset str
        loop2:
            mov ah,1
            int 21h
            cmp al,13
            je exitloop2
            mov [si],al
            inc si
            inc len
        jmp loop2
        exitloop2:
        mov bl,'$'
        mov [si],bl
        ;comparing plen=9 and len
        cmp len,9
        je skiptocompare
            mov f,1
            jmp break3
        skiptocompare:
        ;comparing pw and str
        mov si,offset pw
        mov di,offset str
        mov cl,plen
        loop3:
            mov bl,[si]
            mov dl,[di]
            cmp bl,dl
            je continue3
                mov f,1
                jmp break3
            continue3:
            inc si
            inc di
        loop loop3
        break3:
        cmp f,0
        je positive
        cmp try,3
        je negative
        ;printing msg2
        mov dx,offset msg2
        mov ah,9
        int 21h
        ;printing number of tries left (3-try)
        mov dh,0
        mov dl,51 ;3+48
        sub dl,try
        mov ah,2
        int 21h
        ;printing msg3
        mov dx,offset msg3
        mov ah,9
        int 21h
    jmp loop1
    positive:
        ;printing msg4
        mov dx,offset msg4
        mov ah,9
        int 21h
        jmp exitprog
    negative:
        ;printing msg5
        mov dx,offset msg5
        mov ah,9
        int 21h
    exitprog:
    mov ah,4ch
    int 21h
main endp
end main