.MODEL SMALL
.STACK 100H

.DATA
    msg1 db 'Enter the limiting number should range from 1 to 12: ', 0
    msg2 db 'The numbers in the series are: ', 0
    msg3 db 'The sum of the above series is: ', 0
    space db '  ', 0

    limit dw ?
    sum dw ?

.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc

    main proc
        mov ax, @data
        mov ds, ax

        mov dx, offset msg1 ; prompt user to enter number
        call printstr
        call readint ; read the input value to ax
        call printint ; display it

        ror ax, 1
        and ax, 7fffh
        ;call printint ; devided by two and displayed

        mov cx, ax ; moved to cx to control looping

        mov dx, offset msg2
        call writestring

        mov sum, 0 ; initialize sum to 0
        mov ax, 1 ; initialize ax to 1

        rudi:
        call writeint_signed
        mov dx, offset space
        call writestring

        add sum, ax
        add ax, 2
        loop rudi

        call  crlf
        mov dx, offset msg3
        call writestring

        mov ax, sum
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