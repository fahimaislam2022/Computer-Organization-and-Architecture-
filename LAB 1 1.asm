.MODEL SMALL        
.STACK 64           
.DATA 
DATA1 DB 72H        
DATA2 DB 35H        
SUBTRACTION   DB ?          
.CODE 
MAIN PROC FAR 
    MOV AX, @DATA   
    MOV DS, AX      
    
    MOV AL, DATA1   
    MOV BL, DATA2   
    
    SUB AL, BL      
    MOV SUBTRACTION, AL     
    
    MOV AH, 4CH     
    INT 21H         
MAIN ENDP
END MAIN

  