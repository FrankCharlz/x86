          .MODEL SMALL
          .STACK 100H
          .DATA
               message   DB  0DH,0AH,"HULLO WORLD",0DH,0AH,"$"
               numbers   db 20h, 30h, 40h, 50h
               x         DW  3
               y         DW  5
               z         DW  ?
               array1    DB  10 DUP(2) 
          .CODE
              MAIN     PROC
                 MOV  AX,@DATA
                 MOV  DS,AX          
                 MOV  X,41H  
                 MOV  CX,55H  
                 MOV  Y,CX    
                 MOV  Z,77H   
                 MOV  DX,OFFSET MESSAGE
                 MOV  AH,9
                 INT  21H
       PLACE:    MOV  DI,9   
                 CALL SUB2
                 MOV  AX,4C00H
                 INT  21H
             MAIN     ENDP
;
; A subroutine follows. 
;
          SUB2      PROC
             MOV  DI,77H  ;NO USE
             RET
          SUB2      ENDP    

          END  MAIN
