ORG 100h

.MODEL SMALL
.STACK 100h

.DATA
msg1 DB 'Enter first digit (0-9): $'
msg2 DB 0Ah,0Dh,'Enter second digit (0-9): $'
msg3 DB 0Ah,0Dh,'Difference = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt and read first number
    MOV AH, 09h
    LEA DX, msg1
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, 30h     ; convert ASCII to number
    MOV BL, AL

    ; Prompt and read second number
    MOV AH, 09h
    LEA DX, msg2
    INT 21h
    MOV AH, 01h
    INT 21h
    SUB AL, 30h
    MOV BH, AL

    ; Compute difference (BL - BH)
    MOV AL, BL
    SUB AL, BH
    JNC ok
    NEG AL          ; make positive if negative

ok:
    ADD AL, 30h     ; convert to ASCII

    MOV AH, 09h
    LEA DX, msg3
    INT 21h

    MOV DL, AL
    MOV AH, 02h
    INT 21h

    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
