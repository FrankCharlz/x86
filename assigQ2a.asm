title assignment Q2a

.model small
.stack 100h 
 
.data
	menu1 db "Display contents of a file", 0
	menu2 db 9, "Rename file", 0 ; 9 for tab
	menu3 db 9, "Terminate the program", 0
	menu0 db 9, "Please select a service to perform: ", 0
	
	numbers db "ABCDEF"
	buffer db 0 dup(5) ; to hold ascii values for integers
	
	
  
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
		
		lea dx, menu1
		call writestring
		
		lea dx, menu2
		call writestring
		
		lea dx, menu3
		call writestring
		
	
		
		
		
		quit:
		mov  ax, 4c00h
		int  21h
	main endp
	
	
	

end main
