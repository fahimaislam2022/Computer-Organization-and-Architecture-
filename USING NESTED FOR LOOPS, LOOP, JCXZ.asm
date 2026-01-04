.MODEL SMALL
.STACK 100H

.DATA
CRLF DB 13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

   
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL          ; BL = ROW COUNT

    
    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BH, AL          ; BH = COLUMN COUNT

    
    MOV CL, BL
    MOV CH, 00H
    JCXZ EXIT_PROGRAM

ROW_LOOP:
   
    MOV CL, BH
    MOV CH, 00H
    JCXZ NEXT_ROW

COL_LOOP:
    MOV AH, 02H
    MOV DL, '*'
    INT 21H
    LOOP COL_LOOP

NEXT_ROW:
    ; PRINT NEW LINE
    LEA DX, CRLF
    MOV AH, 09H
    INT 21H

    DEC BL
    JNZ ROW_LOOP

EXIT_PROGRAM:
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
