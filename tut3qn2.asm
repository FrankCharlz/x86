;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;                           ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;    bubble sort and swap   ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;                           ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.model small
.stack 100h

.data
    numbers_array dw -5, 200, -431, 32766, 500, -56, -4000, 45, -2356, 3156, 543, -58
	test_string db 'Benevolent dictator for life', 0

.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc

    main proc
	
		mov ax, @data
		mov ds, ax
		
		; displaying the array
		mov si, offset numbers_array
		mov ax, lengthof numbers_array
		call display_word_array
	
		
		mov si, offset numbers_array
		mov cx, sizeof numbers_array
		mov ax, 1 ; 0 = asc, 1 = desc
		
		call sort
		
	
		; displaying the array
		mov si, offset numbers_array
		mov ax, lengthof numbers_array
		call display_word_array
		
		
		FEXIT:
		mov ax, 4c00h
		int 21h
	
    main endp
	
	swap proc
		; takes two memory address and exchanges their contents
		push ax
		mov  ax, word ptr [si] ; ax <-- si
		xchg ax, word ptr [di] ; si --> di, ax = di
		xchg ax, word ptr [si] ; di --> si
		pop ax
		ret
	swap endp
	
	sort proc
		; sorts array using bubble sort
		push dx
		push bx
		; sorting the array
		; si = offset of the array
		; ax = sort order asc/desc
		; cx = sizeof array
		mov bx, si ; bx carries the offset should not be modified
		add cx, si ; cx points to the last element of array
		OUTER:
			mov di, bx
			INNER:
				cmp ax, 0
				je DESC
				jmp ASC
				
			DESC:
				mov dx, [si]
				cmp dx, [di]
				jg NEXT
				call swap
				jmp NEXT
				
			ASC:
				mov dx, [si]
				cmp dx, [di]
				jl NEXT
				call swap
				
			NEXT:
				add di, 2
				cmp di, cx
				jne INNER
				
			; di points to end of array, done with inner loop
			add si, 2
			cmp si, cx
			jne OUTER
		;done with outer loop
		
		pop bx
		pop dx
		ret
	sort endp
	
	
	write_space proc
		push dx
		push ax
		mov dl, 20h
		mov ah, 02h
		int 21h
		pop ax
		pop dx
		ret
	write_space endp
	
	display_word_array proc
		push cx
		mov cx, ax
		LPRPRP:
		mov ax, [si]
		call writeint_signed
		call write_space
		add si, 2
		LOOP LPRPRP
		call crlf
		pop cx
		ret
	display_word_array endp
	

end main
