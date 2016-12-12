.globl prompt1
.globl prompt2
.globl prompt3
.globl prompt4
.globl prompt5
.globl prompt6
.globl prompt7
.globl prompt8
.globl prompt9

.data
	
prompt1:
	.asciiz "What are the first 3 digits of your phone number?"

prompt2:
	.asciiz "Add it to itself \n"

prompt3:
	.asciiz "Multiply by 80 \n"

prompt4:
	.asciiz "Add 450 \n"

prompt5:
	.asciiz "Divide by 5 \n"

prompt6:
	.asciiz "Subtract 10 \n"

prompt7:
	.asciiz "Divide by 4 \n"

prompt8:
	.asciiz "Subtract 20 \n"

prompt9:
	.asciiz "Divide by 8 \n"

newline:
	.asciiz "\n"

.text

main:
	# Display prompt1 (What are the first three digits of your phone number?)
	ori     $v0, $0, 4			
	la	$a0, prompt1
	syscall

	# Read in the number
	ori     $v0, $0, 5
	syscall

	# print out the entered number
	ori     $s0, $0, 0
	addu    $s0, $v0, $s0
        li $v0, 1
        move $a0, $s0
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt2 (Add it to itself)
	ori     $v0, $0, 4			
	la	$a0, prompt2
	syscall
	
        # add it to itself
        addu $t3, $s0, $0
	add $t3, $t3, $t3

	# print out the result
        li $v0, 1
        move $a0, $t3
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt3 (Multiply by 80)
	ori     $v0, $0, 4			
	la	$a0, prompt3
	syscall


	#multiply by 80, putting result in $t2
	li $t1, 80
	mult $t3, $t1
	mflo $t2
        
        # print out the result
        li $v0, 1
        move $a0, $t2
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt4 (Add 450)
	ori     $v0, $0, 4			
	la	$a0, prompt4
	syscall

	#add 450, putting result in $t2
	li $t1, 450
	addu $t2, $t2, $t1

	# print out the result
        li $v0, 1
        move $a0, $t2
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt5 (Divide by 5)
	ori     $v0, $0, 4			
	la	$a0, prompt5
	syscall

	# Divide by 5 and keep result in $t2
	li $t1, 5
	divu $t2, $t1
	mflo $t2

	# print out the result
        li $v0, 1
        move $a0, $t2
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt6 (Subtract 10)
	ori     $v0, $0, 4			
	la	$a0, prompt6
	syscall

	# Negate 10, and then add it to the number
	li $t0, 9
	nor $t1, $zero, $t0
	add $t2, $t1, $t2

	# print out the result
        li $v0, 1
        move $a0, $t2
        syscall
	
	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt7 (Divide by 4)
	ori     $v0, $0, 4			
	la	$a0, prompt7
	syscall

	# Divide by 4 and keep result in $t2
	li $t1, 4
	divu $t2, $t1
	mflo $t2

	# print out the result
        li $v0, 1
        move $a0, $t2
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt8 (Substract 20)
	ori     $v0, $0, 4			
	la	$a0, prompt8
	syscall

	# Negate 20, and then add it to the number
	li $t0, 19
	nor $t1, $zero, $t0
	add $t2, $t1, $t2

	# print out the result
        li $v0, 1
        move $a0, $t2
        syscall

	#newline
	ori     $v0, $0, 4			
	la	$a0, newline
	syscall

	# Display prompt9 (Divide by 8)
	ori     $v0, $0, 4			
	la	$a0, prompt9
	syscall

	# Divide by 8 and keep result in $t2
	li $t1, 8
	divu $t2, $t1
	mflo $t2

	# print out the result
        li $v0, 1
        move $a0, $t2
        syscall

	# exit the program
        li $v0, 10
        syscall
