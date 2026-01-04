
.MODEL SMALL
.STACK 100H

.DATA
MSG DB 13,10,'DIGIT FOUND: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

REPEAT:
    MOV AH, 01H
    INT 21H
    MOV BL, AL

    CMP BL, '0'
    JB REPEAT
    CMP BL, '9'
    JA REPEAT

    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    MOV DL, BL
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN