;Program to subtract one number from another number
.model small
.stack 100h
.data
.code
main proc
    mov cl,3
    mov bl,5
    sub cl,bl
    js label2 ;if sf==1
    mov dl,'+'
    mov ah,2
    int 21h
    jmp label1
    label2:
    mov dl,'-'
    mov ah,2
    int 21h
    neg cl
    label1:
    mov dl,cl
    add dl,48
    mov ah,2
    int 21h
    mov ah,4ch
    int 21h
main endp
end main