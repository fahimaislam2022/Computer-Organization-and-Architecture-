.MODEL SMALL
.STACK 100H

.DATA
M DB 5          ; M = 5
N DB 250        ; N = 250

MSGUNSIGNEDLESS DB "UNSIGNED: M < N (JB)", 13, 10, "$"
MSGUNSIGNEDGREATEROREQUAL DB "UNSIGNED: M >= N (JAE)", 13, 10, "$"
MSGSIGNEDGREATER DB "SIGNED: M > N (JG)", 13, 10, "$"
MSGSIGNEDLESS DB "SIGNED: M < N (JL)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; UNSIGNED COMPARISON
    ;===========================
    MOV AL, M
    MOV BL, N
    CMP AL, BL

    JB  UNSIGNEDLESS            ; M < N (unsigned)
    JAE UNSIGNEDGREATEROREQUAL  ; M >= N (unsigned)

UNSIGNEDLESS:
    MOV DX, OFFSET MSGUNSIGNEDLESS
    MOV AH, 09H
    INT 21H
    JMP SIGNEDPART

UNSIGNEDGREATEROREQUAL:
    MOV DX, OFFSET MSGUNSIGNEDGREATEROREQUAL
    MOV AH, 09H
    INT 21H
    JMP SIGNEDPART

    ;===========================
    ; SIGNED COMPARISON
    ;===========================
SIGNEDPART:
    MOV AL, M
    MOV BL, N
    CMP AL, BL

    JG SIGNEDGREATER          ; M > N (signed)
    JL SIGNEDLESS             ; M < N (signed)

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
