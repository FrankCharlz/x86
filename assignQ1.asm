title assignment Q1

.model small
.stack 100h 
 
.data
	message1 db "Please enter an integer : ", 0
	message2 db "Entered number is ", 0
	message3 db " and its equivalent in hexadecimal is ", 0
	message4 db "Entered number is out of range", 0
	
	buffer db 0 dup(5) ; to hold ascii values for integers
	
	
  
.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc
	
	main proc
		mov  ax, @data
		mov  ds, ax
		
		prompt_user:
		lea dx, message1
		call writestring
		
		; read the entered number into ax
		call readint
		call crlf
		
		; check if no in range
		cmp ax, 0
		jl out_of_range
		cmp ax, 0FFFFh
		ja out_of_range
		
		; number in range continue
		
		; display the number
		lea dx, message2
		call writestring
		call write_decimal ; number in ax
		
		lea dx, message3
		call writestring
		call convert2Hex ; number in ax
		
		
		jmp quit
		
		; display hexadecimal number
		
		;call convert2Hex
		
		
		
		out_of_range:
		lea dx, message4
		call writestring
		call crlf
		jmp prompt_user
		
		
		
		
		
		quit:
		mov  ax, 4c00h
		int  21h
	main endp
	
	write_decimal proc uses ax bx cx dx si
		
		mov si, offset buffer
		mov bx, 10 ; prepare divisor
		
		next_div10:
		mov dx, 0 ; clear dx for dx:ax = dividend
		div bx ; dx:ax/10 qoutient = ax, remainder = dx
		mov [si], dl ; remainder always less than 10
		inc si
		
		cmp ax, 0
		jnz next_div10
		
		; calculate number of digits
		mov cx, offset buffer
		sub cx, si
		neg cx ; -cx = original buffer - current buffer
		
		
		dec si ; adjust si
		
		loop_display:
		mov dl, [si]
		add dl, 48
		dec si
		mov ah, 02h
		int 21h
		LOOP loop_display
		
		ret
	write_decimal endp
	
	
	
	convert2Hex proc uses ax cx dx si
		
		mov si, offset buffer
		mov bx, 16 ; prepare divisor
		
		next_div16:
		mov dx, 0 ; clear dx for dx:ax = dividend
		div bx ; dx:ax/10 qoutient = ax, remainder = dx
		mov [si], dl ; remainder always less than 10
		inc si
		
		cmp ax, 0
		jnz next_div16
		
		; calculate number of digits
		mov cx, offset buffer
		sub cx, si
		neg cx ; -cx = original buffer - current buffer
		
		dec si ; adjust si
		
		loop_display_hex:
		mov dl, [si]
		add dl, 48
		
		cmp dl, 58
		jb in_range_09
		add dl, 7
		
		in_range_09:
		dec si
		mov ah, 02h
		int 21h
		LOOP loop_display_hex
		
		ret
	convert2Hex endp
	
	
	

end main
