.data

affirmative:
   .asciiz "The string "
negative:
   .asciiz " is not a palindrome" 
positive:
    .asciiz " is a palindrome"
word:
   .space 11
newline:
   .asciiz "\n"
promptuser:
   .asciiz "Enter a word(Max 10 chars):\n"


       

.text
la $a0, promptuser
li $v0, 4       # Ask User for Input
syscall
la $a0, affirmative
li $v0, 4
syscall

la $a0, word
li $a1,11   # Max number of characters 10
li $v0,8
syscall         # Prompting User

la $t0, ($a0) #word
la $t1, ($a0) #backword
li $s0, 10
li $s2, 0
la $t2, 10($t1)
strip:
   
   lb $t3, ($t2)
   beqz $t3, check
   addi $t2, $t2, -1
   addi $s0, $s0, -1
   
   j strip

check:
   div $s1, $s0, 2
   addi $t2, $t2, -2
   check2:
      beq $s2, $s1, palindrome
      lb $t4,($t2)
      lb $t3,($t0)
      bne $t4,$t3,notpalindrome
      addi $t0, $t0, 1
      addi $t2, $t2, -1
      addi $s2, $s2, 1
      j check2

notpalindrome:
   la $a0, negative
   addi $v0, $zero, 4
   syscall
   addi $v0, $zero, 10
   syscall

palindrome:
   la $a0, positive
   addi $v0, $zero, 4
   syscall
   addi $v0, $zero, 10
   syscall
   
   
