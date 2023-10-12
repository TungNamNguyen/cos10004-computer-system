      MOV R0, #message1 
      STR R0, .WriteString
      MOV R1, #codemaker
      STR R1, .ReadString
      STR R1, .WriteString
;
      MOV R0, #message2 
      STR R0, .WriteString
      MOV R2, #codebreaker
      STR R2, .ReadString
      STR R2, .WriteString
;
      MOV R0, #message3 
      STR R0, .WriteString
      MOV R12, #maxguesses
      LDR R12, .InputNum
      STR R12, .WriteSignedNum
getcode:
      PUSH {R2, R3}
      MOV R0, #get_code_message
      STR R0, .WriteString
      MOV R2, R1
      STR R2, .ReadString
      STR R2, .WriteString
      MOV R3, #0
check_code:
      LDRB R0, [R2+R3]
      CMP R0, #114      ; "r"
      BEQ next
      CMP R0, #103      ; "g"
      BEQ next
      CMP R0, #98       ; "b"
      BEQ next
      CMP R0, #121      ; "y"
      BEQ next
      CMP R0, #112      ; "p"
      BEQ next
      CMP R0, #99       ; "c"
      BEQ next
      B invalid_input
next:
      ADD R3,R3,#1
      CMP R3, #4
      BLT check_code
      LDRB R0, [R2+R3]  
      CMP R0, #0        
      BNE invalid_input
      POP {R2, R3}      
      HALT
invalid_input:
      MOV R0, #error_message
      STR R0, .WriteString
      B getcode
codemaker: .BLOCK 16
codebreaker: .BLOCK 16
maxguesses: .BLOCK 5
message1: .ASCIZ "Codemaker is: "
message2: .ASCIZ "\nCodebreaker is: "
message3: .ASCIZ "\nMaximum number of guesses: "
get_code_message: .ASCIZ "\nEnter a code: \n"
error_message: .ASCIZ "\nInvalid code! \n"
