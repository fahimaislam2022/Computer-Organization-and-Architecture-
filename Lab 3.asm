ORG 100h            

.MODEL SMALL
.STACK 100h

.DATA
MSG1 DB 'Hello, this is MSG1$'
MSG2 DB 'Hello, this is MSG2$'

.CODE
MAIN PROC
    MOV AX, @DATA    ; initialize DS
    MOV DS, AX

    ; Display first message
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    ; Skip displaying MSG2
    JMP SKIP_MSG2

    ; Display second message (this will be skipped)
    MOV AH, 09h
    LEA DX, MSG2
    INT 21h

SKIP_MSG2:
    ; Exit program
    MOV AH, 4Ch
    INT 21h

MAIN ENDP
END MAIN
