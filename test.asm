.MODEL SMALL
.STACK 100H

.data
    tru db 'true', 0
    fal db 'false', 0

    array db 12, 22, 12, 20, 16, 
             0, 4, 4, 16
    sum db ?

    pos equ 5

    msg db 0ah, 0dh, 'Hello bitch!', 0 ; oa od for new line 

.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc

    main proc
        mov ax, @data
        mov ds, ax 

        mov sum, 0
        mov bx, offset array

        mov cx, lengthof array
        lp:
        mov ah, 0
        mov al, [bx]
        add sum, al
        call printint
        inc bx
        loop lp


        mov al, sum
        mov ah, 00
        call printint
       
        quit:
        mov ah, 4ch
        int 21h

    main endp


    printint proc
        call writeint_signed
        call crlf
        ret
    printint endp

    printstr proc
        call writestring
        call crlf
        ret
    printstr endp



END MAIN