title assignment Q2a

.model medium
.stack 100h 
 
.data
	menu0 db "Please select a service to perform: ",  0
	menu1 db "Display contents of a file",  0
	menu2 db "Rename file", 0
	menu3 db ". Terminate the program", 0
	
.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc
	
	main proc
		mov  ax, @data
		mov  ds, ax
		
		show_menu:  ; show the menu
		lea dx, menu0
		call writestring
		
		
		xor ax, ax ; ax = 0
		
		inc ax
		call writeint_signed
		lea dx, menu1
		call writestring
		
		inc ax
		call writeint_signed
		lea dx, menu2
		call writestring
		
		inc ax
		call writeint_signed
		lea dx, menu3
		call writestring
		
		
		quit:
		mov  ax, 4c00h
		int  21h
	main endp
	
	
	

end main
