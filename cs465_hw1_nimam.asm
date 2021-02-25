.data 
	prompt: .asciiz "Please enter a positive int: "
	factors: .asciiz "The factors are: "
	abundant: .asciiz ": abundant number\n"
	perfect: .asciiz ": perfect number\n"
	deficient: .asciiz ": deficient number\n"
	space: .asciiz " "
	newline: .asciiz "\n"
.text
.globl main
main:
	#prompt user for an int
	li $v0, 4 #print prompt
	la $a0, prompt
	syscall
	li $v0, 5 #read the entered int
	syscall
	#store the int and load variables
	move $s0,$v0 #store the entered input in $s0
	li $s1 , 0 #the sum of divisors
	li $s2 , 1 #counter to check for divisors
while:
	bge $s2, $s0, display #while $s2 < $s0
	rem $t0, $s0, $s2 #$t0 = $s0 % $s2
	bne $t0, $zero, incr #if $t0 != 0, go to incr
	addu $s1, $s1, $s2 #$s1 += $s2
	li $v0, 1 #print factor
	move $a0, $s2
	syscall
	li $v0, 4 # print space for legibility
	la $a0, space
	syscall
incr:
	addi $s2, $s2, 1 #$s2++
	j while #jump back to beginning
display:
	li $v0, 4 #print newline
	la $a0, newline
	syscall
	li $v0, 1 #print factor
	move $a0, $s0
	syscall
	bgt $s1, $s0, is_abundant #if sum > n, then n = abundant number
	beq $s1, $s0, is_perfect #if sum = n, then n = perfect number
	blt $s1, $s0, is_deficient #if sum < n, then n = deficient number
	j end #jump to end
is_abundant:
    li $v0, 4 #print abundant
    la $a0, abundant
    syscall
    j end
is_perfect:
    li $v0, 4 #print perfect
    la $a0, perfect
    syscall
    j end
is_deficient:
    li $v0, 4 #print deficient
    la $a0, deficient
    syscall
    j end
 end:
     #loop back to top for continous testing
     #j main