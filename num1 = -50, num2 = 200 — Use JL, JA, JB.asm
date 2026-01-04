.MODEL SMALL
.STACK 100H

.DATA
NUM1 DB -50
NUM2 DB 200

MSG_JL DB "SIGNED: NUM1 < NUM2 (JL)",13,10,"$"
MSG_JA DB "UNSIGNED: NUM1 > NUM2 (JA)",13,10,"$"
MSG_JB DB "UNSIGNED: NUM1 < NUM2 (JB)",13,10,"$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; SIGNED COMPARE (JL)
    ;===========================
    MOV AL, NUM1
    MOV BL, NUM2
    CMP AL, BL

    JL SIGNED_LESS

SIGNED_LESS:
    MOV DX, OFFSET MSG_JL
    MOV AH, 09H
    INT 21H

    ;===========================
    ; UNSIGNED COMPARE (JA/JB)
    ;===========================
    MOV AL, NUM1
    MOV BL, NUM2
    CMP AL, BL

    JA UNSIGNED_GREATER
    JB UNSIGNED_LESS

UNSIGNED_GREATER:
    MOV DX, OFFSET MSG_JA
    MOV AH, 09H
    INT 21H
    JMP FINISH

UNSIGNED_LESS:
    MOV DX, OFFSET MSG_JB
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
