.MODEL SMALL
.STACK 100H

.DATA
R DB -10      ; R = -10
S DB -10      ; S = -10

MSG_EQUAL DB "Equal: R == S (JE)", 13, 10, "$"
MSG_NOT_EQUAL DB "Not Equal: R != S (JNE)", 13, 10, "$"
MSG_GREATER DB "Greater: R > S (JG)", 13, 10, "$"
MSG_LESS DB "Less: R < S (JL)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; EQUALITY COMPARISON
    ;===========================
    MOV AL, R
    MOV BL, S
    CMP AL, BL
    JE EQUAL              ; R == S (JE)
    JNE NOT_EQUAL         ; R != S (JNE)

EQUAL:
    MOV DX, OFFSET MSG_EQUAL
    MOV AH, 09H
    INT 21H
    JMP GREATER_LESS

NOT_EQUAL:
    MOV DX, OFFSET MSG_NOT_EQUAL
    MOV AH, 09H
    INT 21H
    JMP GREATER_LESS

    ;===========================
    ; GREATER AND LESS COMPARISON
    ;===========================
GREATER_LESS:
    MOV AL, R
    MOV BL, S
    CMP AL, BL
    JG GREATER          ; R > S (JG)
    JL LESS             ; R < S (JL)

GREATER:
    MOV DX, OFFSET MSG_GREATER
    MOV AH, 09H
    INT 21H
    JMP FINISH

LESS:
    MOV DX, OFFSET MSG_LESS
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
