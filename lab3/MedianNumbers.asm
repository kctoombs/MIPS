# xSpim MedianNumbers.asm program
# 
#

#  Data Area - allocate and initialize variables
.globl prompt
.globl median	
	
.data

	# TODO: Complete these declarations / initializations
prompt:	
	.asciiz "Enter the next number:\n"
	
median:	
	.asciiz "Median: "


#Text Area (i.e. instructions)
.text

main:
	#Ask for the next number
	ori $v0, $0, 4
	la $a0, prompt
	syscall

	#Read in the number
	ori $v0, $0, 5
	syscall

	#Store the number in $s0 (by adding 0 to it)
	add $s0, $v0, $zero

	#Ask for the next number
	ori $v0, $0, 4
	la $a0, prompt
	syscall

	#Read in the number
	ori $v0, $0, 5
	syscall

	#Store the number in $s1
	add $s1, $v0, $zero

	#Ask for the next number
	ori $v0, $0, 4
	la $a0, prompt
	syscall

	#Read in the number
	ori $v0, $0, 5
	syscall

	#Store the number in $s2
	add $s2, $v0, $zero

	#Compare the number in $s0 to the numbers in $s1 and $s2
	#If $s4 != $s3 after the comparisons, then $s0 is the median
	slt $s3, $s0, $s1
	slt $s4, $s0, $s2
	bne $s3, $s4, median_s0


	#Compare the number in $s1 to the numbers in $s0 and $s2
	#If $s5 != $s6 after the comparisons, then $s1 is the median
	slt $s5, $s1, $s0
	slt $s6, $s1, $s2
	bne $s5, $s6, median_s1


	#Compare the number in $s2 to the numbers in $s0 and $s1
	#If $s6 != $s7 after the comparisons, then $s2 is the median
	slt $s6, $s2, $s0
	slt $s7, $s2, $s1
	bne $s6, $s7, median_s2

	#If the median is in $s0
	median_s0:
	move $t0, $s0
	j medianPrompt

	#If the median is in $s1
	median_s1:
	move $t0, $s1
	j medianPrompt

	#If the median is in $s2
	median_s2:
	move $t0, $s2
	j medianPrompt

	#Display the median prompt
	medianPrompt:	
	ori $v0, $0, 4
	la $a0, median
	syscall

	#Print the median	
        li $v0, 1
        move $a0, $t0
        syscall



exit:

	# Exit
	ori     $v0, $0, 10
	syscall

