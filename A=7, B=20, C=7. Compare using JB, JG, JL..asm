.MODEL SMALL
.STACK 100H

.DATA
A DB 7         ; A = 7
B DB 20        ; B = 20
C DB 7         ; C = 7

MSG_B DB "A < B (JB)", 13, 10, "$"
MSG_G DB "A > B (JG)", 13, 10, "$"
MSG_L DB "A < C (JL)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; JB: A < B
    ;===========================
    MOV AL, A
    MOV BL, B
    CMP AL, BL
    JB LESS_THAN_B           ; A < B (JB)

    ;===========================
    ; JG: A > B
    ;===========================
    MOV AL, A
    MOV BL, B
    CMP AL, BL
    JG GREATER_THAN_B        ; A > B (JG)

LESS_THAN_B:
    MOV DX, OFFSET MSG_B
    MOV AH, 09H
    INT 21H
    JMP FINISH

GREATER_THAN_B:
    MOV DX, OFFSET MSG_G
    MOV AH, 09H
    INT 21H
    JMP COMPARE_C

    ;===========================
    ; JL: A < C
    ;===========================
COMPARE_C:
    MOV AL, A
    MOV BL, C
    CMP AL, BL
    JL LESS_THAN_C           ; A < C (JL)

LESS_THAN_C:
    MOV DX, OFFSET MSG_L
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
