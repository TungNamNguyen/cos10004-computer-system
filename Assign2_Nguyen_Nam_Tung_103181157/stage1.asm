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
      HALT
codemaker: .BLOCK 16
codebreaker: .BLOCK 16
maxguesses: .BLOCK 5
message1: .ASCIZ "Codemaker is: "
message2: .ASCIZ "\nCodebreaker is: "
message3: .ASCIZ "\nMaximum number of guesses: "
