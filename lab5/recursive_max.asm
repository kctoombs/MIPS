# xSpim Memory Demo Program

#  Data Area
.data

space:
    .asciiz " "

newline:
    .asciiz "\n"

dispArray:
    .asciiz "\nCurrent Array:\n"

convention:
    .asciiz "\nConvention Check\n"

myArray:
	.word 0 5 3 12 7 15 13 21

#Text Area (i.e. instructions)
.text

main:
    ori     $v0, $0, 4          
    la      $a0, dispArray 
    syscall

    ori     $s1, $0, 8
    la      $s0, myArray

    add     $a1, $0, $s1
    add     $a0, $0, $s0
 
    jal     DispArray

    ori     $s2, $0, 0
    ori     $s3, $0, 0
    ori     $s4, $0, 0
    ori     $s5, $0, 0
    ori     $s6, $0, 0
    ori     $s7, $0, 0
    
    add     $a1, $0, $s1
    add     $a0, $0, $s0

    jal     RecursiveMax

    add     $s1, $s1, $s2
    add     $s1, $s1, $s3
    add     $s1, $s1, $s4
    add     $s1, $s1, $s5
    add     $s1, $s1, $s6
    add     $s1, $s1, $s7

    add     $a1, $0, $s1
    add     $a0, $0, $s0
    jal     DispArray

    j       Exit

DispArray:
    addi    $t0, $0, 0 
    add     $t1, $0, $a0

dispLoop:
    beq     $t0, $a1, dispend
    sll     $t2, $t0, 2
    add     $t3, $t1, $t2
    lw      $t4, 0($t3)

    ori     $v0, $0, 1
    add     $a0, $0, $t4
    syscall

    ori     $v0, $0, 4
    la      $a0, space
    syscall

    addi    $t0, $t0, 1
    j       dispLoop    

dispend:
    ori     $v0, $0, 4
    la      $a0, newline
    syscall
    jr      $ra 

ConventionCheck:

 addi $t0, $0, -1
 addi $t1, $0, -1
 addi $t2, $0, -1
 addi $t3, $0, -1
 addi $t4, $0, -1
 addi $t5, $0, -1
 addi $t6, $0, -1
 addi $t7, $0, -1
 ori $v0, $0, 4
 la $a0, convention
 syscall
 addi $v0, $zero, -1
 addi $v1, $zero, -1
 addi $a0, $zero, -1
 addi $a1, $zero, -1
 addi $a2, $zero, -1
 addi $a3, $zero, -1
 addi $k0, $zero, -1
 addi $k1, $zero, -1
 jr $ra
    #addi    $t0, $0, -1
    #addi    $t1, $0, -1
    #addi    $t2, $0, -1
    #addi    $t3, $0, -1
    #addi    $t4, $0, -1
    #addi    $t5, $0, -1
    #addi    $t6, $0, -1
    #addi    $t7, $0, -1
    #ori     $v0, $0, 4
    #la      $a0, convention
    #syscall
    #jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

	# COPYFROMHERE - DO NOT REMOVE THIS LINE
	
        
# Parameters:
# $a0: The address of the array
# $a1: The length of the array        
RecursiveMax:
       #TODO: write your code here, which should simply call TailRecursiveMax
       #with the correct parameters.

       li $a2, -2147483648

       addi $sp, $sp, -4
       sw $ra, 0($sp)
	
       jal TailRecursiveMax

       lw $ra, 0($sp)
       addi $sp, $sp, 4
	
       #Do not remove this line
       jr $ra


# Parameters:
# $a0: The address of the array
# $a1: The length of the array        
# $a2: The running maximal element of the array        
TailRecursiveMax:
        #TODO: write your code here, which should make a _tail-recursive_
        #call to TailRecursiveMax

	addi $sp, $sp, -4       #Save s registers and $ra
	sw $ra, 0($sp)

	addi $sp, $sp, -4
	sw $s1, 0($sp)

	addi $sp, $sp, -4
	sw $s2, 0($sp)

	addi $sp, $sp, -4     #***
	sw $s3, 0($sp)	      #***

        move $s1, $a1         #Now $s1 holds the length of the array
	move $s2, $a0         #Now $s2 holds the address of the array
	move $s3, $a2         #Now $s3 holds the max ***
	
	beq $a1, $zero, base_case  #If size=0, we've reached the base case

	lw $t2, 0($s2)         #Load the number into $t2

	li $v0, 1              #Print the number
	move $a0, $t2
	syscall

	ori $v0, $0, 4         #Print newline
	la $a0, newline
	syscall

	li $t3, 1
	slt $t4, $s3, $t2      #Compare the max to the number in the array
	beq $t3, $t4, set_max
	j print_max

set_max:
	move $s3, $t2

print_max:
	li $v0, 1               #Print the max which is in $s3
	move $a0, $s3
	syscall

	jal ConventionCheck     #Call ConventionCheck after printing

	addi $a1, $s1, -1       #Decrement the length of the array
	addi $a0, $s2, 4        #Go to the next element in the array
	move $a2, $s3           #*** Move value of $s3 back into $a3

	lw $s3, 0($sp)
	addi $sp, $sp, 4        #***

	lw $s2, 0($sp)          #Restore s registers and $ra
	addi $sp, $sp, 4

	lw $s1, 0($sp)
	addi $sp, $sp, 4

	lw $ra, 0($sp)
	addi $sp, $sp, 4


	j TailRecursiveMax      #Recursively call the function

base_case:

	lw $s3, 0($sp)
	addi $sp, $sp, 4        #***

	lw $s2, 0($sp)          #Restore s registers and $ra
	addi $sp, $sp, 4

	lw $s1, 0($sp)
	addi $sp, $sp, 4

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	#Do not remove this line
	jr $ra
