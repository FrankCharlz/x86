.model small
.stack 100h
.data
	bb db 20h, 30h, 40h, 50h
	ww dw 2345h, 0923h, 8495h
	sig db 084,104,105,115,032,099,111,100
		db 101,032,119,097,115,032,119,114
		db 105,116,116,101,110,032,098,121
		db 032,121,111,117,114,032,098,101
		db 110,101,118,111,108,101,110,116
		db 032,100,105,099,116,097,116,111
		db 114,046,032,070,101,101,108,032
		db 102,114,101,101,032,116,111,032
		db 115,104,097,114,101,032,064,070
		db 082,065,078,075,046,067,072,065
		db 082,076,090,0ah,0dh,000,000,000

.code
	extrn writestring:proc, writeint:proc, crlf:proc, str_ucase:proc
	extrn clrscr:proc, readint:proc, writeint_signed:proc

	main proc
		mov ax,@data
		mov ds,ax

		mov dx, offset sig
		call writestring

		mov ax,4C00h 
		int 21h

	main endp
	end main


