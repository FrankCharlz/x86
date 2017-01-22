.model small
.stack 10h

.data
   array1 dw 3 dup('CP'), 2000h
   array2 dw 'CP', 'CP', 'CP', 2000h
   
   param1 dw 12
   param2 dw 13
   
.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc

    main proc
        mov ax, @data
        mov ds, ax 
		
		pop ax
		
		push param1
		push param1
		push param1
		push param1
		push param1
		
		
        quit:
        mov ah, 4ch
        int 21h
		
    main endp
	
end main