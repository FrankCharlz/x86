.MODEL SMALL
.STACK 100h

.data
  
   a dw 2
   d dw 7
   n dw 6
   
   message db 'The nth term is : ', 0
   
   
.code
    extrn clrscr:proc, crlf:proc, str_ucase:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc, DumpRegs:proc

    main proc
        mov ax, @data
        mov ds, ax 
		
		push a
		push n
		push d
		call print_series
		
		call crlf
		
		mov dx, offset message
		call writeint
		
		
		push a
		push n
		push d
		call nth_term
		call writeint_signed
		
		
        quit:
        mov ah, 4ch
        int 21h

    main endp
	
	nth_term proc
		push bp
		
		mov bp, sp
		
		push bx
		push cx
		
		mov ax, [bp + 4] ; d
		mov bx, [bp + 6] ; n
		mov cx, [bp + 8] ; a
		
		sub bx, 1
		mul bx ; result in dx:ax
		
		add ax, cx ; -- end result
		
		pop cx
		pop bx
		
		pop bp
		
		ret 6
	
	nth_term endp
	
	print_series proc
		push bp
		
		mov bp, sp
		
		push ax
		push bx
		push cx
		
		mov bx, [bp + 4] ; d -- difference
		mov cx, [bp + 6] ; n -- number of terms
		mov ax, [bp + 8] ; a -- first term
		
		loopx:
		call writeint_signed
		call print_space
		add ax, bx
		dec cx
		cmp cx, 0
		jnz loopx
		
		pop cx
		pop bx
		pop ax
		
		pop bp
		ret 6
		
	print_series endp
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	product proc
		push bp ; save old bp
		mov bp, sp ; store stack pointer or safe return
		
		; preserve registers
		push ax
		push bx
		
		; retrieve variables
		mov ax, [bp + 4]
		mov bx, [bp + 6]
		
		mov cx, ax
		add cx, ax
		
		pop bx
		pop ax
		
		pop bp
		ret 4 ; plus 4 to clear the 2 entered parameters
	product endp


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
	
	print_space proc
		push ax
		push dx
		
        mov dl, 20h 
		mov ah, 02h
		int 21h
		
		pop dx
		pop ax
		ret
    print_space endp



END MAIN