.MODEL SMALL
.STACK 100H

.DATA
A DB 30     ; A = 30
B DB 10     ; B = 10

MSGUNSIGNEDABOVE DB "UNSIGNED: A > B (JA)", 13, 10, "$"
MSGUNSIGNEDBELOW DB "UNSIGNED: A < B (JB)", 13, 10, "$"

MSGSIGNEDGREATER DB "SIGNED: A > B (JG)", 13, 10, "$"
MSGSIGNEDLESS DB "SIGNED: A < B (JL)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; UNSIGNED COMPARISON
    ;===========================
    MOV AL, A
    MOV BL, B
    CMP AL, BL

    JA  UNSIGNEDABOVE     ; A > B (unsigned)
    JB  UNSIGNEDBELOW     ; A < B (unsigned)

UNSIGNEDABOVE:
    MOV DX, OFFSET MSGUNSIGNEDABOVE
    MOV AH, 09H
    INT 21H
    JMP SIGNEDPART

UNSIGNEDBELOW:
    MOV DX, OFFSET MSGUNSIGNEDBELOW
    MOV AH, 09H
    INT 21H
    JMP SIGNEDPART

    ;===========================
    ; SIGNED COMPARISON
    ;===========================
SIGNEDPART:
    MOV AL, A
    MOV BL, B
    CMP AL, BL

    JG SIGNEDGREATER      ; A > B (signed)
    JL SIGNEDLESS         ; A < B (signed)

SIGNEDGREATER:
    MOV DX, OFFSET MSGSIGNEDGREATER
    MOV AH, 09H
    INT 21H
    JMP FINISH

SIGNEDLESS:
    MOV DX, OFFSET MSGSIGNEDLESS
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
