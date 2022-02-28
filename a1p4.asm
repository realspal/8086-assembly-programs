;Program to find length of a string
.model small
.stack 100h
.data
    msg db 'Enter the string : $'
.code
main proc
    mov ax,@data
    mov ds,ax
    mov dx,offset msg
    mov ah,9
    int 21h
    mov dx,0
    mov bl,10
    input:
        mov ah,1
        int 21h
        cmp al,13
        je progend
        inc dx
    jmp input
    progend:
    mov ax,dx
    div bl
    mov bl,al
    mov ch,ah
    mov dl,bl
    add dl,48
    mov ah,2
    int 21h
    mov dl,ch
    add dl,48
    mov ah,2
    int 21h
    mov ah,4ch
    int 21h
main endp
end main
