.MODEL SMALL
.STACK 100H

.DATA
D DB 0FFH    ; D = 0FFH
E DB 01H     ; E = 1

MSG_JA DB "Unsigned: D > E (JA)", 13, 10, "$"
MSG_JB DB "Unsigned: D < E (JB)", 13, 10, "$"
MSG_JG DB "Signed: D > E (JG)", 13, 10, "$"
MSG_JL DB "Signed: D < E (JL)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; UNSIGNED COMPARISON
    ;===========================
    MOV AL, D
    MOV BL, E
    CMP AL, BL
    JA UNSIGNED_GREATER   ; D > E (unsigned)
    JB UNSIGNED_LESS      ; D < E (unsigned)

UNSIGNED_GREATER:
    MOV DX, OFFSET MSG_JA
    MOV AH, 09H
    INT 21H
    JMP SIGNED_PART

UNSIGNED_LESS:
    MOV DX, OFFSET MSG_JB
    MOV AH, 09H
    INT 21H
    JMP SIGNED_PART

    ;===========================
    ; SIGNED COMPARISON
    ;===========================
SIGNED_PART:
    MOV AL, D
    MOV BL, E
    CMP AL, BL
    JG SIGNED_GREATER_PART  ; D > E (signed)
    JL SIGNED_LESS_PART     ; D < E (signed)

SIGNED_GREATER_PART:
    MOV DX, OFFSET MSG_JG
    MOV AH, 09H
    INT 21H
    JMP FINISH

SIGNED_LESS_PART:
    MOV DX, OFFSET MSG_JL
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
