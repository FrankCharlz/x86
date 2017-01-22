title assignment Q2a

.model small
.stack 100h 
 
.data
	foo db 'Hello world!', 0
	
	old_segment dw ?
	old_offset dw ?
	
	counter dw 0
	duration dw 91 ; 5 seconds
	
	
.code
    extrn clrscr:proc, crlf:proc, dos_error:proc
    extrn writeint:proc, writestring:proc, writeint_signed:proc
    extrn readint:proc, readstring:proc, readchar:proc
	
	main proc
		mov  ax, @data
		mov  ds, ax
		call clrscr
		
		; preserve int 1ch
		mov ax, 351ch
		int 21h
		
		mov old_segment, es
		mov old_offset, bx
		
		; install new handler
		push ds ; preserve ds
		
		mov dx, seg delay
		mov ds, dx
		
		mov dx, offset delay
		
		mov ax, 251ch
		int 21h
		
		pop ds ; restore ds
		
		quit:
		mov  ax, 4c00h
		int  21h
	main endp
	
	delay proc
		push ds ; preserving current ds whatever it is
		
		mov ax, @data ; assign data segment address to ds
		mov ds, ax
		
		inc counter
		mov ax, duration
		cmp counter, ax ; compare counter to duration either 2 or 5 seconds, 36 or 91
		jne just_pass
		
		; duration seconds passed
		mov counter, 0
		call print_or_clear
	
		
		just_pass:
		nop
		
		pop ds
		iret
	delay endp
	
	restore_int proc uses ax dx
		push ds ; can also push other registers here
		mov ds, old_segment ; segment of original ISR
		mov dx, old_offset ; offset of original ISR
		mov ah, 25h ; function number
		mov al, 1ch
		int 21h
		pop ds
		ret
	restore_int endp
	
	print_or_clear proc uses dx
	
		cmp duration, 91 ; is it 5 secs duration
		je do_2_sec_duration
		
		mov duration, 91
		lea dx, foo
		call writestring
		jmp done_poc
		
		do_2_sec_duration:
		mov duration, 36
		call clrscr
		
		done_poc:
	
		ret
	print_or_clear endp
	
	

end main
