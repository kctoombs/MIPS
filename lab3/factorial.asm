# xSpim Demo Program
# 
#   CPE 315
#   fall 2001
#
# By: Dan Stearns
# Date:  
# Modifications: 
#	4/10/03 knico Tabbed code
#	4/10/03 knico Modified to use s registers instead of t registers
#           
#
# declare global so programmer can see actual addresses.

#  Data Area - allocate and initialize variables
.data

prompt:
	.asciiz "Enter the number:\n"
newline:
	.asciiz "\n"

#Text Area (i.e. instructions)
.text

main:

	#Display the prompt
	ori $v0, $0, 4
	la $a0, prompt
	syscall

	#Read in the number
	ori $v0, $0, 5
	syscall

	#Store the number in $s0
	add $s0,  $v0, $zero

	#Set accum to 1 (store 1 in $s1)
	li $s1, 1


	#Implement the while loop
	loop:	
	beq $s0, $zero, print
	mult $s0, $s1
	mflo $s1
	li $v0, 1            #Print accum
	move $a0, $s1
	syscall
	ori $v0, $0, 4       #Print newline
	la $a0, newline
	syscall
	addi $s0, $s0, -1    #Decrement n
	j loop


	#Print the result
	print:
	li $v0, 1
	move $a0, $s1
	syscall

exit:

	# Exit
	ori     $v0, $0, 10
	syscall
