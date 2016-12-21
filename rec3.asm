.model small
.stack 100h
.data
data1 db "Enter max number:",0
data2 db ", ",0
data3 db "The origin array is:",0
data4 db "The highest number is ",0
data5 db "The smallest number is ",0
data6 db "Enter number:"
numaray dw 12 dup(?)

.code
extrn writestring:proc, writeint:proc, crlf:proc
extrn clrscr:proc, readint:proc, writeint_signed:proc
main proc
	mov ax,@data
	mov ds,ax
	mov dx , offset data1
lab1:call clrscr 
	call writestring
	call readint
	cmp ax,1
	jl lab1
	cmp ax,12
	jg lab1
	call crlf
	
	
	mov cx, ax
	mov di, cx				; save conter
	mov si, offset numaray
lab2:mov dx, offset data6
	call writestring
	call readint
	call crlf
	mov [si], ax
	add si,2
	loop lab2
	
	mov cx, di				;get counter
	mov dx, offset data3
	call writestring
	mov si, offset numaray
lab3:mov ax, [si]
	call writeint_signed
	mov dx, offset data2
	call writestring
	add si,2
	loop lab3
	
	; large number 
	mov si,offset numaray
	sub di,1
	mov cx, di
	mov ax , [si]
	lab5:add si , 2 
	cmp ax ,[si]
	jl lab4
	jmp lab6
	lab4: mov ax, [si]
	lab6:loop lab5
	
	call crlf
	mov dx, offset data4
	call writestring
	call writeint_signed
	
	;smallest number 
	mov si,offset numaray
	mov cx, di
	mov ax , [si]
	lab8:add si , 2 
	cmp [si], ax
	jl lab7
	jmp lab9
	lab7: mov ax, [si]
	lab9:loop lab8
	
	call crlf
	mov dx, offset data5
	call writestring
	call writeint_signed

 

		

mov ax,4C00h 
int 21h
main endp
end main