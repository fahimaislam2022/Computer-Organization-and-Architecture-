ORG 100h

.MODEL SMALL
.STACK 100h

.DATA
msg1 DB 'Enter a lowercase letter: $'
msg2 DB 0Ah,0Dh,'Uppercase letter: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt
    MOV AH, 09h
    LEA DX, msg1
    INT 21h

    ; Read a character
    MOV AH, 01h
    INT 21h
    MOV BL, AL

    ; Convert lowercase to uppercase
    ; 'a' = 97 (61h), 'A' = 65 (41h) ? subtract 20h
    SUB BL, 20h

    ; Print newline and result
    MOV AH, 09h
    LEA DX, msg2
    INT 21h

    MOV DL, BL
    MOV AH, 02h
    INT 21h

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
