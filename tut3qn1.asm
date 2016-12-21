;string length procedure
.model small
.stack 100h

.data
    msg1 db 'The original string is : ', 0
    msg2 db 'The length of the string is : ', 0

	test_string db 'Benevolent dictator for life', 0

.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc

    main proc
	
		mov ax, @data
		mov ds, ax
		
		;displaying the original string
		mov dx, offset msg1
		call writestring
		
		mov dx, offset test_string
		call writestring
		
		call crlf ;some space man!
		
		;displaying the string length
		mov dx, offset msg2
		call writestring
		
		
		mov si, offset test_string
		call string_length ; affects ax, used for output
		call writeint_signed  ;displays contents of ax
		
		mov ax, 4c00h
		int 21h
	
    main endp
	
	
	
	string_length proc
		pushf
		push bx
		xor ax, ax ; set ax = 0
	NEXT:	
		mov bx, [si]
		cmp bx, 0
		jz DONE
		inc ax
		inc si
		jmp NEXT
	DONE:
		pop bx
		popf
		ret
	
	string_length endp

end main
