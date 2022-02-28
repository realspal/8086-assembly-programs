;Program to accept a two-digit number and print it
.model small
.stack 100h
.data
    msg db 'Enter the two digit number : $'
.code
main proc
    mov ax,@data
    mov ds,ax
    mov dx,offset msg
    mov ah,9
    int 21h
    mov ah,1
    int 21h
    mov bl,al
    mov ah,1
    int 21h
    mov cl,al
    mov dl,10
    mov ah,2
    int 21h
    mov dl,13
    mov ah,2
    int 21h
    mov dl,bl
    mov ah,2
    int 21h
    mov dl,cl
    mov ah,2
    int 21h
    mov ah,4ch
    int 21h
main endp
end main