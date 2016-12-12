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
	.word 0 33 123 -66 332 -1 -223 453 9 45 -78 -14  

#Text Area (i.e. instructions)
.text

main:
    ori     $v0, $0, 4          
    la      $a0, dispArray 
    syscall

    ori     $s1, $0, 12
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

    jal     PrintReverse

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
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

PrintReverse:
	#TODO: write your code here, $a0 stores the address of the array, $a1 stores the length of the array

	addi $sp, $sp, -4      #Grow the stack one level
        sw $s0, 0($sp)

	addi $sp, $sp, -4      #Grow the stack one level
        sw $s1, 0($sp)

	addi $sp, $sp, -4      #Grow the stack one level
        sw $s2, 0($sp)

	addi $sp, $sp, -4      #Grow the stack one level
        sw $s3, 0($sp)

	addi $sp, $sp, -4      #Grow the stack one level
        sw $ra, 0($sp)         #Store ra on the stack

	addi $a1, $a1, -1      #Decrease the size by 1 so that it now represents the index of the array.
	move $s0, $a0          #Now the address of the array is stored in $s0.
	li $t1, 4
	mult $t1, $a1          #multiply the index by 4 to obtain the address of the last element
	mflo $s2               #Put that number in $s2
	add $s3, $s0, $s2      #Now $s3 holds the address of the last number in the array
	move $s1, $a1          #Now $s1 holds the index we are at
	
	 
loop:	slt $t7, $s1, $zero    #Once the size becomes < zero, we have printed all of the values. So exit.
	li $t6, 1
	beq $t7, $t6, print_array
	lw $t4, 0($s3)

	# print out the number
        li $v0, 1
        move $a0, $t4
        syscall

	jal ConventionCheck    #Run the ConventionCheck function after each print.

	addi $s3, $s3, -4      #Subtract 4 to obtain the address of the previous number in the array.
	addi $s1, $s1, -1      #Decrease the size by 1.
	
	j loop

print_array:
	lw $ra, 0($sp)         #Put the original value of ra (from the stack) back in ra
        addi $sp, $sp, 4       #Shrink the stack one level

	lw $s3, 0($sp)         
        addi $sp, $sp, 4

	lw $s2, 0($sp)         
        addi $sp, $sp, 4

	lw $s1, 0($sp)         
        addi $sp, $sp, 4

	lw $s0, 0($sp)         
        addi $sp, $sp, 4 
    # Do not remove this line
	jr      $ra

	
exit:
	# exit the program
        li $v0, 10
        syscall
