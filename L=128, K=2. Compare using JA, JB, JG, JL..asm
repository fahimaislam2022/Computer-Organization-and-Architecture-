.MODEL SMALL
.STACK 100H

.DATA
L DB 128
K DB 2

MSG_JA DB "UNSIGNED: L > K (JA)",13,10,"$"
MSG_JB DB "UNSIGNED: L < K (JB)",13,10,"$"
MSG_JG DB "SIGNED: L > K (JG)",13,10,"$"
MSG_JL DB "SIGNED: L < K (JL)",13,10,"$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; UNSIGNED COMPARE
    ;===========================
    MOV AL, L
    MOV BL, K
    CMP AL, BL

    JA U_GREATER
    JB U_LESS

U_GREATER:
    MOV DX, OFFSET MSG_JA
    MOV AH, 09H
    INT 21H
    JMP SIGNED_COMP

U_LESS:
    MOV DX, OFFSET MSG_JB
    MOV AH, 09H
    INT 21H
    JMP SIGNED_COMP

    ;===========================
    ; SIGNED COMPARE
    ;===========================
SIGNED_COMP:
    MOV AL, L
    MOV BL, K
    CMP AL, BL

    JG S_GREATER
    JL S_LESS

S_GREATER:
    MOV DX, OFFSET MSG_JG
    MOV AH, 09H
    INT 21H
    JMP END_

S_LESS:
    MOV DX, OFFSET MSG_JL
    MOV AH, 09H
    INT 21H
    JMP END_

END_:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
