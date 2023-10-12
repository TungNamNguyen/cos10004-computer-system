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
      B getsecretcode
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
      RET
invalid_input:
      MOV R0, #error_message
      STR R0, .WriteString
      B getcode
getsecretcode:
      MOV R0, #new_line
      STR R0, .WriteString
      MOV R0, #codemaker
      STR R0, .WriteString
      MOV R0, #secret_code_message
      STR R0, .WriteString
      PUSH {R1}
      MOV R1, #secretcode
      BL getcode
      POP {R1}
      MOV R5, #1
      ADD R12,R12,#1
stage4:
      PUSH {R2}
      CMP R5, R12
      BLT get_query_code
      POP {R2}
      BL print_lose
;
get_query_code:
      MOV R0, #new_line
      STR R0, .WriteString
      MOV R0, #new_line
      STR R0, .WriteString
      MOV R0, #codebreaker
      STR R0, .WriteString
      MOV R0, #guess_count_message
      STR R0, .WriteString
      STR R5, .WriteSignedNum
      PUSH {R1}
      MOV R1, #querycode
      BL getcode
stage5:
      PUSH {R2, R3, R4, R5, R6, R7, R8}
      MOV R0, #0 
      MOV R1, #0 
      MOV R4, #0
      MOV R5, #0
      MOV R6, #0
      MOV R7, #0
      MOV R8, #0 
      BL comparecodes
      POP {R2, R3, R4, R5, R6, R7, LR}
      CMP R0, #4 
      BEQ print_win
      POP {R1}
      ADD R5, R5, #1
      B stage4
comparecodes: 
      MOV R7, #0 
      MOV R2, #querycode 
      LDRB R2, [R2 + R4] 
      MOV R6, #secretcode 
      LDRB R3, [R6 + R5] 
      CMP R3, R2 
      BNE compare_byte 
      ADD R0, R0, #1 
      B next_byte
compare_byte: 
      LDRB R3, [R6 + R7] 
      CMP R7, R4 
      BEQ next_byte
      CMP R2, R3
      BNE next_byte
      ADD R1, R1, #1 
next_byte:
      ADD R7, R7, #1
      CMP R7, #4
      BLT compare_byte
      ADD R4, R4, #1
      ADD R5, R5, #1
      CMP R4, #4
      BLT comparecodes
      PUSH {LR} 
      POP {LR}
      RET
print_win: 
      MOV R0, #new_line
      STR R0, .WriteString
      MOV R0, #codebreaker
      STR R0, .WriteString
      MOV R0, #win
      STR R0, .WriteString
      MOV R0, #game_over
      STR R0, .WriteString
      HALT
print_lose: 
      MOV R0, #new_line
      STR R0, .WriteString
      MOV R0, #codebreaker
      STR R0, .WriteString
      MOV R0, #lose
      STR R0, .WriteString
      MOV R0, #game_over
      STR R0, .WriteString
      HALT
codemaker: .BLOCK 16
codebreaker: .BLOCK 16
maxguesses: .BLOCK 5
message1: .ASCIZ "Codemaker is: "
message2: .ASCIZ "\nCodebreaker is: "
message3: .ASCIZ "\nMaximum number of guesses: "
get_code_message: .ASCIZ "\nEnter a code: \n"
error_message: .ASCIZ "\nInvalid code! \n"
secret_code_message: .ASCIZ ", please enter a 4-character secret code"
secretcode: .BLOCK 128
new_line: .ASCIZ "\n"
querycode: .BLOCK 128
guess_count_message: .ASCIZ ", this is guess number: "
win:  .ASCIZ ", You WIN!"
lose: .ASCIZ ", You LOSE!"
game_over: .ASCIZ "\nGame Over!"
