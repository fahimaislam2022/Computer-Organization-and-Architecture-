.MODEL SMALL
.STACK 100H

.DATA
U DB 100         ; U = 100
V DB 100         ; V = 100

MSG_EQUAL DB "EQUAL: U == V (JE)", 13, 10, "$"
MSG_NOT_EQUAL DB "NOT EQUAL: U != V (JNE)", 13, 10, "$"
MSG_GREATER_EQUAL DB "GREATER OR EQUAL: U >= V (JGE)", 13, 10, "$"
MSG_LESS_EQUAL DB "LESS OR EQUAL: U <= V (JLE)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; EQUALITY COMPARISON
    ;===========================
    MOV AL, U
    MOV BL, V
    CMP AL, BL

    JE  EQUAL            ; U == V (JE)
    JNE NOT_EQUAL        ; U != V (JNE)

EQUAL:
    MOV DX, OFFSET MSG_EQUAL
    MOV AH, 09H
    INT 21H
    JMP GREATER_EQUAL_PART

NOT_EQUAL:
    MOV DX, OFFSET MSG_NOT_EQUAL
    MOV AH, 09H
    INT 21H
    JMP GREATER_EQUAL_PART

    ;===========================
    ; GREATER OR EQUAL AND LESS OR EQUAL COMPARISON
    ;===========================
GREATER_EQUAL_PART:
    MOV AL, U
    MOV BL, V
    CMP AL, BL

    JGE GREATER_EQUAL        ; U >= V (JGE)
    JLE LESS_EQUAL           ; U <= V (JLE)

GREATER_EQUAL:
    MOV DX, OFFSET MSG_GREATER_EQUAL
    MOV AH, 09H
    INT 21H
    JMP FINISH

LESS_EQUAL:
    MOV DX, OFFSET MSG_LESS_EQUAL
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
