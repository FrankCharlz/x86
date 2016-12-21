.MODEL SMALL
.STACK 100H

.DATA
    msg1 db 'Enter the first number: ', 0
    msg2 db 'Enter the second number: ', 0

    number1 dw ?
    number2 dw ?
    sum dw ?

    msg3 db 'The sum of ', 0
    msg4 db ' and ', 0
    msg5 db ' is ', 0

.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc

    main proc
        mov ax, @data
        mov ds, ax


        ;getting the numbers
        ;-------------------------------------------------
        mov dx, offset msg1
        call writestring
        call crlf

        call readint
        call writeint_signed
        call crlf
        mov number1, ax

        mov dx, offset msg2
        call writestring
        call crlf

        call readint
        call writeint_signed
        call crlf
        mov number2, ax

        ;adding
        ;----------------------------------------------
        add ax, number1
        mov sum, ax


        ; writing the result
        ;----------------------------------------------------
        mov dx, offset msg3
        call writestring

        mov ax, number1
        call writeint_signed

        mov dx, offset msg4
        call writestring

        mov ax, number2
        call writeint_signed


        mov dx, offset msg5
        call writestring

        mov ax, sum
        call writeint_signed
        call crlf



        MOV AH, 4CH                  ; return control to DOS
        INT 21H

MAIN ENDP
END MAIN