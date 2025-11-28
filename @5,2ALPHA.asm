.MODEL SMALL
.STACK 100H

.DATA
MSG1 DB 'ENTER TWO ALPHABETS: $'
MSG2 DB 'THE CORRECT ORDER IS: $'
CR EQU 13
LF EQU 10
CHAR1 DB ?
CHAR2 DB ?

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX

    ; --------------------------------------------------
    ; (a) PRINT '@' 5 TIMES USING JMP (NO LOOP)
    ; --------------------------------------------------
    MOV CX,5
PRINT_AT:
    MOV AH,2
    MOV DL,'@'
    INT 21H
    DEC CX
    JNZ PRINT_AT

    ; NEW LINE
    MOV AH,2
    MOV DL,CR
    INT 21H
    MOV DL,LF
    INT 21H

    ; --------------------------------------------------
    ; (b) READ TWO ALPHABETS FROM USER
    ; --------------------------------------------------
    LEA DX,MSG1
    MOV AH,9
    INT 21H

    ; READ FIRST ALPHABET
    MOV AH,1
    INT 21H
    MOV CHAR1,AL

    ; READ SECOND ALPHABET
    MOV AH,1
    INT 21H
    MOV CHAR2,AL

    ; NEW LINE
    MOV AH,2
    MOV DL,CR
    INT 21H
    MOV DL,LF
    INT 21H

    ; --------------------------------------------------
    ; (c) DISPLAY THEM IN CORRECT ORDER
    ; --------------------------------------------------
    LEA DX,MSG2
    MOV AH,9
    INT 21H

    MOV AL,CHAR1
    MOV BL,CHAR2
    CMP AL,BL
    JBE ORDER_OK    ; AL <= BL ? already sorted
    XCHG AL,BL      ; swap if needed

ORDER_OK:
    ; print first character
    MOV AH,2
    MOV DL,AL
    INT 21H

    ; print second character
    MOV AH,2
    MOV DL,BL
    INT 21H

    ; EXIT PROGRAM
    MOV AH,4CH
    INT 21H
MAIN ENDP
END MAIN
