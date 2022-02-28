;Program to sort a set of unsigned 16 bit numbers in
;ascending order using insertion sort algorithm
.model small
.stack 100h
.data
    count dw 0 ;digit counter
    intg dw 0  ;I/O for inputnum and printnum
    digt dw 0  ;extracted digit
    var1 dw 0  ;reversed number
    n dw 8     ;number of entries
    cc dw 0    ;loop counter
    i dw 0 ;inner loop control of insertion sort
    j dw 0 ;outer loop control of insertion sort
    key dw 0 ;key of insertion sort
    m dw 0 ;index counter
    array dw 20 dup(0) ;array
    ind dw 0 ;array index
    val dw 0 ;array value
    temp dw 0;temporary variable
    htab db '  $' ;horizontal tab
    newl db 10,13,'$' ;new line
    msg1 db 'Enter the number of entries : $'
    msg2 db 'Enter $'
    msg3 db ' unsigned numbers :',10,13,'$'
    msg4 db 'Original array :   $'
    msg5 db 'Sorted array   :   $'
.code
main proc
    mov ax,@data
    mov ds,ax
    ;printing msg1
    mov dx,offset msg1
    mov ah,9
    int 21h
    ;taking input in n
    call inputnum
    mov bx,intg
    mov n,bx
    ;printing msg2
    mov dx,offset msg2
    mov ah,9
    int 21h
    ;printing n
    mov bx,n
    mov intg,bx
    call printnum
    ;printing msg3
    mov dx,offset msg3
    mov ah,9
    int 21h
    ;taking inputs in array
    mov cc,0
    mov si,offset array
    loop1:
        call inputnum
        mov dx,intg
        mov [si],dx
        add si,2
        inc cc
        mov bx,cc
        cmp bx,n
    jl loop1
    ;printing msg4
    mov dx,offset msg4
    mov ah,9
    int 21h
    ;printing original array
    mov cc,0
    mov si,offset array
    loop2:
        mov dx,[si]
        mov intg,dx
        push si
        call printnum
        mov dx,offset htab
        mov ah,9
        int 21h
        pop si
        add si,2
        inc cc
        mov bx,cc
        cmp bx,n
    jl loop2
    ;printing newl
    mov dx,offset newl
    mov ah,9
    int 21h
    ;performing insertion sort
    mov j,1
    loop3:
        mov bx,j
        mov i,bx
        dec i
        mov ind,bx
        call getvalue
        mov bx,val
        mov key,bx
        loop4:
            cmp i,0
            jl exitloop4
            mov bx,i
            mov ind,bx
            call getvalue
            mov bx,val
            cmp bx,key
            jle exitloop4
            mov bx,i
            inc bx
            mov ind,bx
            call setvalue
            dec i
        jmp loop4
        exitloop4:
        mov bx,key
        mov val,bx
        mov bx,i
        inc bx
        mov ind,bx
        call setvalue
        inc j
        mov bx,j
        cmp bx,n
    jl loop3
    ;printing msg5
    mov dx,offset msg5
    mov ah,9
    int 21h
    ;printing sorted array
    mov cc,0
    mov si,offset array
    loop9:
        mov dx,[si]
        mov intg,dx
        push si
        call printnum
        mov dx,offset htab
        mov ah,9
        int 21h
        pop si
        add si,2
        inc cc
        mov bx,cc
        cmp bx,n
    jl loop9
    ;exit program
    mov ah,4ch
    int 21h
main endp
getvalue proc ;val=array[ind]
    mov m,0
    mov cx,n
    mov si,offset array
    loopget:
        mov bx,ind
        cmp bx,m ;checking if ind==m
        jne skipget
            mov bx,[si]
            mov val,bx
            mov cx,0
            jmp exitget
        skipget:
        add si,2
        inc m
    loop loopget
    exitget:
    ret
getvalue endp
setvalue proc ;array[ind]=val
    mov m,0
    mov cx,n
    mov si,offset array
    loopset:
        mov bx,ind
        cmp bx,m ;checking if ind==m
        jne skipset
            mov bx,val
            mov [si],bx
            mov cx,0
            jmp exitset
        skipset:
        add si,2
        inc m
    loop loopset
    exitset:
    ret
setvalue endp
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
        ret
inputnum endp
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