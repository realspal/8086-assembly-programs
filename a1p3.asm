;Program to accept a string and print it
.model small
.stack 100h
.data
    msg db 'Enter your name : $'
    arr db 50 dup('$')
.code
main proc
    mov ax,@data
    mov ds,ax
    mov dx,offset msg
    mov ah,9
    int 21h
    mov si,offset arr
    input:
        mov ah,1
        int 21h
        cmp al,13
        je progend
        mov [si],al
        inc si
    jmp input
    progend:
    mov dx,offset arr
    mov ah,9
    int 21h
    mov ah,4ch
    int 21h
main endp
end main
