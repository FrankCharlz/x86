title assignment Q2a

.model small
.stack 100h 
 
.data
	menu0 db 'Please select a service to perform: ',  13, 10, 0
	menu1 db 9, '1. Display contents of a file',  13, 10, 0
	menu2 db 9, '2. Rename file', 13, 10, 0
	menu3 db 9, '3. Delete file', 13, 10, 0
	menu4 db 9, '4. Terminate the program', 13, 10, 0
	
	message1 db 'Enter your choice: ', 0
	message2 db 'Chosen service is NOT availabe, try again,', 13, 10, 13, 10, 0
	
	msg_new_file_name db 'Write new file name (should include drive letter ): ', 0
	
	filename db 'g:/assignq2.txt', 0 
	filename_buffer db 93 dup (0) ; buffer for new file name
	filehandle dw ?
	filebuffer db 0256h dup (0) ; buffer large enough to hold contents of the file
	
.code
    extrn clrscr:proc, crlf:proc, dos_error:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc
	
	main proc
		mov  ax, @data
		mov  ds, ax
		call clrscr
		
		; prepare a file for reading
		mov dx, offset filename
		mov ah, 3dh          ; function for opening a file
		mov al, 0            ; input mode is for input only    
		int 21h
		jc open_error       ; Error occured in opening a file
		mov filehandle, ax   ; File opened successfully
			
		show_menu:  ; show the menu
		lea dx, menu0
		call writestring
		
		lea dx, menu1
		call writestring
		
		lea dx, menu2
		call writestring
		
		lea dx, menu3
		call writestring
		
		lea dx, menu4
		call writestring
		
		call crlf
		lea dx, message1
		call writestring
		
		call readint ; read choice to ax
		
		cmp ax, 1
		je lbl_disp_contents
		cmp ax, 2
		je lbl_rename_file
		cmp ax, 3
		je lbl_delete_file
		cmp ax, 4
		je quit
		
		; entered wrong choice
		lea dx, message2 ; wrong choice prompt
		call writestring
		call crlf
		jmp show_menu
		
		lbl_disp_contents:
		call display_contents
		jmp quit
		
		lbl_rename_file:
		call rename_file
		jmp quit
		
		lbl_delete_file:
		call delete_file
		jmp quit
		
		open_error:
		call dos_error
		
		quit:
		mov  ax, 4c00h
		int  21h
	main endp
	
	display_contents proc
	
		mov bx, filehandle
		mov cx, lengthof filebuffer
		mov dx, offset filebuffer
		
		mov ah, 3fh
		int 21h ; read contents to buffer
		jnc read_success
		call dos_error ; show error reading
		
		read_success:
		
		mov ah, 3eh
		int 21h ; close file
		jnc close_success
		call dos_error ; show error closing
		
		close_success:
		
		jnc disp_cont_loop
		call dos_error
		ret
		

		disp_cont_loop:
			mov ah, 02h
			mov dl, [si]
			int 21h
			inc si
		LOOP disp_cont_loop
		
		ret
		
	
	display_contents endp
	
	
	
	rename_file proc
		
		lea dx, msg_new_file_name
		call writestring
		
		mov dx, offset filename_buffer ; buffer ot hold read string
		mov cx, 93 ; maximum chars to read
		call readstring
		
		mov dx, offset filename
		mov di, offset filename_buffer
		
		mov ah, 56h
		int 21h ; rename file
		
		jnc rename_success
		call dos_error
		
		rename_success:
		
		ret
	rename_file endp
	
	delete_file proc
		
		mov dx, offset filename
		mov ah, 41h
		int 21h ; delete file
		
		jnc delete_success
		call dos_error
		
		delete_success:
		
		ret
	delete_file endp
	
	
	
	

end main
