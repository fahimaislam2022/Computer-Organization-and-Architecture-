.MODEL SMALL
.STACK 100H

.DATA
COUNT DB 0
MSG DB 13,10,'TOTAL VOWELS = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

READ_CHAR:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE DISPLAY

    CMP AL, 'A'
    JE INC_COUNT
    CMP AL, 'E'
    JE INC_COUNT
    CMP AL, 'I'
    JE INC_COUNT
    CMP AL, 'O'
    JE INC_COUNT
    CMP AL, 'U'
    JE INC_COUNT
    CMP AL, 'a'
    JE INC_COUNT
    CMP AL, 'e'
    JE INC_COUNT
    CMP AL, 'i'
    JE INC_COUNT
    CMP AL, 'o'
    JE INC_COUNT
    CMP AL, 'u'
    JE INC_COUNT

    JMP READ_CHAR

INC_COUNT:
    INC COUNT
    JMP READ_CHAR

DISPLAY:
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    MOV DL, COUNT
    ADD DL, '0'
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN