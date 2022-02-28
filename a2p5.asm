;Program to check if a substring is present in a given string
.model small
.stack 100h
.data
    i db 0 ;outer loop control
    j db 0 ;outer loop upper limit
    k db 0 ;inner loop control
    f db 0 ;flag
    n db 0 ;i+k
    ch1 db ' ' ;character from original string
    ch2 db ' ' ;character from substring
    len1 db 0 ;length of original string
    len2 db 0 ;length of substring
    str1 db 100 dup('0') ;original string
    str2 db 100 dup('0') ;substring
    newl db 10,13,'$' ;new line
    msg1 db 'Enter the original string : $'
    msg2 db 'Enter the substring       : $'
    msg3 db 'The substring is PRESENT in the original string.',10,13,'$'
    msg4 db 'The substring is NOT PRESENT in the original string.',10,13,'$'
    msg5 db 'Starting index of substring in original string = $'
    msg6 db 'Ending index of substring in original string   = $'
    count dw 0 ;printnum - digit counter
    intg dw 0  ;printnum - I/O for inputnum and printnum
    digt dw 0  ;printnum - extracted digit
    var1 dw 0  ;printnum - reversed number
.code
main proc
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in str1
    mov si,offset str1
    loop1:
        mov ah,1
        int 21h
        cmp al,13
        je exitloop1
        mov [si],al
        inc si
        inc len1
    jmp loop1
    exitloop1:
    mov bl,'$'
    mov [si],bl
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    ;taking input in str2
    mov si,offset str2
    loop2:
        mov ah,1
        int 21h
        cmp al,13
        je exitloop2
        mov [si],al
        inc si
        inc len2
    jmp loop2
    exitloop2:
    mov bl,'$'
    mov [si],bl
    ;checking
    mov i,0 ;i=0
    mov bl,len1
    sub bl,len2 
    mov j,bl ;j=len1-len2
    for1: ;outer loop
        mov f,0 ;f=0
        mov k,0 ;k=0
        for2: ;inner loop
            ;extracting (i+k)th character of str1
            mov bl,i
            add bl,k
            mov n,bl
            mov cl,n
            add cl,1 ;cl=i+k+1
            mov si,offset str1
            extr1:
                mov bl,[si]
                inc si
            loop extr1
            mov ch1,bl
            ;extracting (k)th character of str2
            mov cl,k
            add cl,1 ;cl=k+1
            mov si,offset str2
            extr2:
                mov bl,[si]
                inc si
            loop extr2
            mov ch2,bl
            ;comparing the two characters
            mov bl,ch1
            cmp bl,ch2 ;ch1==ch2?
            je continue2
            mov f,1 ;f=1
            jmp break2
            continue2:
        inc k ;k++
        mov bl,k
        cmp bl,len2 ;k<len2?
        jl for2 ;end of inner for
        jmp break2
        for21:
        jmp for1
        break2:
        cmp f,0 ;f==0?
        je break1
    inc i ;i++
    mov bl,i
    cmp bl,j ;i<j?
    jle for21 ;end of outer for
    break1:
    cmp f,1 ;f==1?
    je negative
    positive: ;present
        mov dx,offset msg3
        mov ah,9
        int 21h
        ;printing starting index
        mov dx,offset msg5
        mov ah,9
        int 21h
        mov dh,0
        mov dl,i
        add dl,1
        mov intg,dx
        call printnum
        mov dx,offset newl
        mov ah,9
        int 21h
        ;printing ending index
        mov dx,offset msg6
        mov ah,9
        int 21h
        mov dh,0
        mov dl,i
        add dl,len2
        mov intg,dx
        call printnum
        jmp exitprog
    negative: ;not present
        mov dx,offset msg4
        mov ah,9
        int 21h
    exitprog:
        mov ah,4ch
        int 21h 
main endp
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