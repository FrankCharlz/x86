title Preparati n for paper

.model small
.stack 100h ; 10 bytes --> 5 words
 
.data
	num1 dw 100h
	num2 dw 102h
	
	
  
.code
    ; extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc
	
	main proc
		mov  ax, @data
		mov  ds, ax
		
		
		mov ax, 35
		mov bl, -7
		
		idiv bl
		
		call writeint_signed
		
		
		
		quit:
		mov  ax, 4c00h
		int  21h
	main endp
	
	sum proc
	
		ret
	sum endp
	
	
	

end main
