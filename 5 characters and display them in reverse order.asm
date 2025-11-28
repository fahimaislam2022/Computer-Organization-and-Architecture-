ORG 100h

.MODEL SMALL
.STACK 100h

.DATA
msgPrompt DB 'Enter 5 characters: $'
chars DB 5 DUP(?)         ; space to store 5 characters
msgNewLine DB 0Ah,0Dh,'$' ; for newline

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt the user
    MOV AH, 09h
    LEA DX, msgPrompt
    INT 21h

    ; Read 5 characters one by one
    MOV CX, 5
    LEA SI, chars
READ_LOOP:
    MOV AH, 01h     ; read character
    INT 21h
    MOV [SI], AL    ; store in array
    INC SI
    LOOP READ_LOOP

    ; Print newline
    MOV AH, 09h
    LEA DX, msgNewLine
    INT 21h

    ; Display characters in reverse
    MOV CX, 5
    LEA SI, chars
    ADD SI, 4        ; point to last character
DISPLAY_LOOP:
    MOV DL, [SI]
    MOV AH, 02h
    INT 21h
    DEC SI
    LOOP DISPLAY_LOOP

    ; Exit
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
