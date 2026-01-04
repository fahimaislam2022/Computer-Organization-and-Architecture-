.MODEL SMALL
.STACK 100H

.DATA
P DB -5     ; P = -5
Q DB 3      ; Q = 3

MSGSIGNEDLESS DB "SIGNED: P < Q (JL)", 13, 10, "$"
MSGSIGNEDGREATER DB "SIGNED: P > Q (JG)", 13, 10, "$"

MSGUNSIGNEDGREATER DB "UNSIGNED: P > Q (JA)", 13, 10, "$"
MSGUNSIGNEDLESS DB "UNSIGNED: P < Q (JB)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; SIGNED COMPARISON
    ;===========================
    MOV AL, P
    MOV BL, Q
    CMP AL, BL

    JL SIGNEDLESS         ; P < Q (signed)
    JG SIGNEDGREATER     ; P > Q (signed)

SIGNEDLESS:
    MOV DX, OFFSET MSGSIGNEDLESS
    MOV AH, 09H
    INT 21H
    JMP UNSIGNEDPART

SIGNEDGREATER:
    MOV DX, OFFSET MSGSIGNEDGREATER
    MOV AH, 09H
    INT 21H
    JMP UNSIGNEDPART

    ;===========================
    ; UNSIGNED COMPARISON
    ;===========================
UNSIGNEDPART:
    MOV AL, P
    MOV BL, Q
    CMP AL, BL

    JA  UNSIGNEDGREATER   ; P > Q (unsigned)
    JB  UNSIGNEDLESS      ; P < Q (unsigned)

UNSIGNEDGREATER:
    MOV DX, OFFSET MSGUNSIGNEDGREATER
    MOV AH, 09H
    INT 21H
    JMP FINISH

UNSIGNEDLESS:
    MOV DX, OFFSET MSGUNSIGNEDLESS
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
