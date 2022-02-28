;Program to add two numbers
.model small
.stack 100h
.data
.code
main proc
    mov dx,24
    add dx,42
    mov ah,4ch
    int 21h
main endp
end main