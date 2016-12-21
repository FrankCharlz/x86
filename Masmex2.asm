title demo program        (ch3ex2.asm)

; This program is for demonstration purpose!"
; to show how to use MASM and codeview

.model small
.stack 100h
.data
val1 dw 2000h
val2 dw 0100h
wordlist dw 1000h,2000h,3000h
bytelist db 10h,20h,30h

sumdb db 0
sumdw dw 0
message1 db "Starting of demo",0dh,0ah,"$"  ; CR and LF characters
message2 DB "This is the end of demo$"

.code
main proc
    mov  ax,@data
    mov  ds,ax
    mov  ah,9
    mov  dx,offset message1
    int  21h
    
    ; accessing an array of 8 bits

    mov   di,offset bytelist  ; use SI, DI or BX registers for offset
    mov   al,[di]	; first number
    mov   al,[di+1]	; second number
    mov   al,[di+2] 	; third number

    ; accessing an array of 16 bits

    mov   si,offset wordlist  ; use SI, DI or BX registers for offset
    mov   ax,[si]	; first number
    mov   ax,[si+2]	; second number
    mov   ax,[si+4] 	; third number

    ; adding an array of 8 bits
    mov   di,offset bytelist  ; use SI, DI or BX registers for offset
    mov   al,[di]	; first number
    add   al,[di+1]	; add second number
    add   al,[di+2] 	; add third number
    mov   sumdb,al      ;store the sum, sum=96 dec.

    ; adding an array of 16 bits

    mov   bx,offset wordlist
    mov   ax,[bx]	; first number
    add   ax,[bx+2]	; add second number
    add   ax, [bx+4] 	; add third number
    mov	  [bx+6],ax	; sum= [bx+6]=ax
    mov   sumdw,ax      ; another way of expressing the sum
                        ; sumdw = 24576 dec.
    
     mov  ah,9
     mov  dx,offset message2
    ;lea  dx,message
    int  21h

    mov  ax,4C00h    ; exit program
    int  21h
main endp

end main
