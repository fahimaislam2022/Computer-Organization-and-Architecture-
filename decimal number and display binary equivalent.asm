ORG 100h

.MODEL SMALL
.STACK 100h

.DATA
msg1 DB 'Enter a decimal digit (0–9): $'
msg2 DB 0Ah,0Dh,'Binary = $'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt
    MOV AH, 09h
    LEA DX, msg1
    INT 21h

    ; Read decimal number
    MOV AH, 01h
    INT 21h
    SUB AL, 30h         ; ASCII to number (0–9)
    MOV BL, AL          ; store number
    MOV CX, 4           ; for 4-bit binary output

    ; Print binary header
    MOV AH, 09h
    LEA DX, msg2
    INT 21h

PRINT_BINARY:
    ROL BL, 1           ; rotate left through carry
    MOV DL, '0'
    JNC skip
    MOV DL, '1'
skip:
    MOV AH, 02h
    INT 21h
    LOOP PRINT_BINARY

    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
