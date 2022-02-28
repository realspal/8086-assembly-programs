;Program to display given string at given screen position
.model small
.stack 100h
.data
    i db 0 ;loop control variable
    x1 db 16 ;stored value for row number
    y1 db 36 ;stored value for column number
    len db 0 ;length of entered string
    str db 100 dup(0) ;entered string
    msg1 db 'Enter the string of 10 characters : $'
    msg2 db 'INVALID INPUT : The string does not have 10 characters.$'
.code
main proc
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in str
    mov si,offset str
    mov cx,10
    loop1:
        mov ah,1
        int 21h
        cmp al,13
        je exitloop1
        mov [si],al
        inc si
        inc len
    loop loop1
    exitloop1:
    mov bl,'$'
    mov [si],bl
    cmp len,10
    jne invalid
    ;displaying str at (x1,y1)
    mov si,offset str
    mov dh,x1            ;row number
    mov dl,y1            ;column number (initial)
    mov bh,0             ;page number
    loop2:
        mov ah,02h       ;setting cursor position at (dh,dl)
        int 10h 
        mov ah,08h       ;reading character and attribute at cursor position
        int 10h 
        mov bl,ah        ;attributes to be written (from attributes returned)
        mov al,[si]      ;character to be written
        mov cx,1         ;number of times to write character
        mov ah,09h       ;writing character and attribute at cursor position
        int 10h 
        inc dl           ;increasing column number
        inc si
        inc i
        cmp i,10
    jl loop2
    jmp endprog
    invalid:
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    endprog:
    ;end of program
    mov ah,4ch
    int 21h
main endp
end main