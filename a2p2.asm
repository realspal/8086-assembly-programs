;Program to print prime numbers in a range
.model small
.stack 100h
.data
    check db 'T' ;true or false
    count dw 0 ;printnum - digit counter
    intg dw 0  ;printnum - I/O for inputnum and printnum
    digt dw 0  ;printnum - extracted digit
    var1 dw 0  ;printnum - reversed number
    num dw 0 ;number to be checked
    num1 db 0 ;starting number
    num2 db 0 ;ending number
    countprime db 0 ;number of primes found
    newl db 10,13,'$'
    msg1 db 'Enter starting number of range : $'
    msg2 db 'Enter ending number of range   : $'
    msg3 db 'The prime numbers in the range are :',10,13,'$'
    msg4 db 'There is no prime number in the range.$'
.code
main proc 
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in num1 or starting number
    call inputnum
    mov num1,al
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    ;taking input in num2 or ending number
    call inputnum
    mov num2,al
    ;printing prime numbers in the range
    mov bh,0
    loop1:
        mov check,'T'
        mov bl,num1
        mov num,bx
        call isprime
        cmp check,'T'
        jne skiploop
            cmp countprime,0
            jne displaycomma
                ;printing msg3
                mov dx,offset msg3
                mov ah,9
                int 21h
                jmp displaynum
            displaycomma:
                mov dl,','
                mov ah,2
                int 21h
            displaynum:
                call printnum
                inc countprime
        skiploop:
        inc num1
        mov bl,num1
        mov cl,num2
        cmp bl,cl
        jg exitloop
    jmp loop1
    exitloop:
        cmp countprime,0
        jne printdot
        ;printing msg4
        mov dx,offset msg4
        mov ah,9
        int 21h
        jmp endprog
    printdot:
        mov dl,'.'
        mov ah,2
        int 21h
    ;exit program
    endprog:
        mov ah,4ch
        int 21h
main endp
isprime proc ;checks if a number is prime or not
    cmp num,1
    je notprime
    cmp num,2
    je endproc
    mov bh,0
    mov bl,2
    l1:
        mov ax,num
        div bl
        cmp ah,0
        je notprime
        inc bl
        cmp bx,num
        jge endproc
    jmp l1
    notprime:
        mov check,'F'
    endproc:
        ret
isprime endp
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
        mov ax,intg
        mov ah,0
        ret
inputnum endp
printnum proc ;prints an integer
    mov bx,num
    mov intg,bx
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