org 100h

.MODEL SMALL
.STACK 100h

.DATA
MSG1        DB 'Enter a number: $'
MSG_LESS    DB 0Dh,0Ah,'Sum is Less than 5$'
MSG_GREATER DB 0Dh,0Ah,'Sum is Greater than 5$'
MSG_EQUAL   DB 0Dh,0Ah,'Sum is Equal to 5$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX             ; Initialize DS

    MOV CL, 5              ; CL = reference value

    ; Prompt user
    MOV AH, 09h
    LEA DX, MSG1
    INT 21h

    ; Read single digit number
    MOV AH, 01h
    INT 21h
    SUB AL, '0'            ; Convert ASCII to integer

    ; ---- SUM with CL ----
    ADD AL, CL             ; AL = AL + CL

    ; Compare SUM (AL) with CL
    CMP AL, CL
    JL LESS_THAN           ; Less
    JG GREATER_THAN        ; Greater
    JE EQUAL_TO            ; Equal

LESS_THAN:
    MOV AH, 09h
    LEA DX, MSG_LESS
    INT 21h
    JMP EXIT

GREATER_THAN:
    MOV AH, 09h
    LEA DX, MSG_GREATER
    INT 21h
    JMP EXIT

EQUAL_TO:
    MOV AH, 09h
    LEA DX, MSG_EQUAL
    INT 21h

EXIT:
    MOV AH, 4Ch
    INT 21h

MAIN ENDP
END MAIN
