;Program to multiply two unsigned word integers
.model small
.stack 100h
.data
    x dw ? ;first word integer
    y dw ? ;second word integer
    p dw 2 dup(?) ;product in 32-bit/4-byte array form
    str db ? ;product in string form for printing
    fl db 0 ;flag to detect leading zeros
    msg1 db 'Enter first number   : (HEX) $'
    msg2 db 'Enter second number  : (HEX) $'
    msg3 db 'The product is       : (HEX) $'
.code
main proc  
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in x
    call inputhex
    mov x,bx
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    ;taking input in y
    call inputhex
    mov y,bx
    ;calculating product of x and y
    mov dx,0
    mov ax,x
    mov bx,y
    mul bx
    ;storing product in p (array of size 32-bit/4-byte)
    mov si,offset p
    mov [si],dx             ;higher word of product
    add si,2
    mov [si],ax             ;lower word of product
    ;storing product in string str for printing
    mov di,offset p
    mov bx,[di]             ;set bx to higher word of product
    add di,2
    mov si,[di]             ;set si of lower word of product
    mov di,offset str
    mov dh,2                ;two 2-byte-word parts, hence iterate loop1 twice
    loop1:
        mov ch,4            ;ch = count of digits to be displayed  
        mov cl,4            ;cl = count of bits to be rotate    
        loop2:
            rol bx,cl       ;rotate bl towards left, i.e., MSB comes to LSB   
            mov dl,bl       ;dl = data to be displayed  
            and dl,0fh      ;extract and keep only LSB
            cmp dl,9       ;check if character is digit (0-9) or letter (A-F)  
            jbe skip1  
                add dl,7   ;if letter then add 37h = 55 (07h + 37h)
            skip1:
            add dl,30h      ;else add only 30h = 48
            cmp fl,0
            jne skip2
                cmp dl,'0'
                je skip3
                mov fl,1
            skip2:
                mov [di],dl
                inc di
            skip3:
            dec ch          ;decrement count of digits to be displayed by 1  
        jnz loop2  
        dec dh              ;loop1 control variable
        cmp dh,0  
        mov bx,si           ;set bx to lower word of product
    jnz loop1
    mov bl,'$'
    mov [di],bl
    ;printing msg3
    mov dx,offset msg3
    mov ah,9
    int 21h
    ;printing product from str
    mov dx,offset str
    mov ah,9
    int 21h
    ;exit program
    mov ah,4ch 
    int 21h
main endp
inputhex proc ;inputs a hexadecimal integer and stores it in BX
    mov bx,0
    mov cl,4
    loop3:
        mov ah,1
        int 21h
        cmp al,13
        je endloop3
        cmp al,57
        jle skip4
            sub al,7
        skip4:
        sub al,48
        rol bx,cl
        or bl,al
        jmp loop3
    endloop3:
    ret
inputhex endp
end main