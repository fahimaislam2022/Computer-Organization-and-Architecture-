ORG 100h

.MODEL SMALL
.STACK 100h

.DATA
msgPrompt  DB 'Enter a number: $'
msgPos     DB 0Ah,0Dh, 'Positive$',0
msgNeg     DB 0Ah,0Dh, 'Negative$',0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Prompt user
    MOV AH, 09h
    LEA DX, msgPrompt
    INT 21h

    ; Read character (digit or '-')
    MOV AH, 01h
    INT 21h
    CMP AL, '-'        ; Check if negative sign
    JE READ_NEGATIVE

READ_POSITIVE:
    SUB AL, '0'        ; Convert ASCII to integer
    JMP CHECK_DONE

READ_NEGATIVE:
    ; Read next digit
    MOV AH, 01h
    INT 21h
    SUB AL, '0'
    NEG AL              ; Make it negative

CHECK_DONE:
    CMP AL, 0
    JL PRINT_NEGATIVE
    JG PRINT_POSITIVE

PRINT_POSITIVE:
    MOV AH, 09h
    LEA DX, msgPos
    INT 21h
    JMP EXIT

PRINT_NEGATIVE:
    MOV AH, 09h
    LEA DX, msgNeg
    INT 21h

EXIT:
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
