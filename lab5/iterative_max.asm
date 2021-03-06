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

    jal     IterativeMax

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

IterativeMax:
	#TODO: write your code here, $a0 stores the address of the array, $a1 stores the length of the array

	addi $sp, $sp, -4
	sw $s0, 0($sp)

	addi $sp, $sp, -4
	sw $s1, 0($sp)

	addi $sp, $sp, -4
	sw $s2, 0($sp)

	addi $sp, $sp, -4
	sw $s3, 0($sp)

	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $s0, 0                   #This will store the index
	li $s1, -2147483648         #This will hold the max
	move $s2, $a0               #Now $s2 holds the address of the array
	move $s3, $a1               #Now $s3 holds the length of the array

loop:
	slt $t0, $s0, $s3
	beq $t0, $zero, after_loop
	lw $t1, 0($s2)              #Store the number in $t1

	li $v0, 1                   #Print the number
	move $a0, $t1
	syscall

	ori $v0, $0, 4              #Print newline
	la $a0, newline
	syscall

	li $t3, 1                   #Compare the number we are looking at to the max
	slt $t2 $s1, $t1
	beq $t2, $t3, set_max
	j print_max
	

set_max:
	move $s1, $t1               #If $t1 is the max, move it into $s1 which holds the max

print_max:
	
	li $v0, 1                   #Print the max
	move $a0, $s1
	syscall

	jal ConventionCheck 
	
	addi $s0, $s0, 1            #Increment s0
	addi $s2, $s2, 4            #Add 4 to the address to get to the next number

	       	

	j loop

after_loop:

	lw $ra, 0($sp)
	addi $sp, $sp, 4

	lw $s3, 0($sp)
	addi $sp, $sp, 4

	lw $s2, 0($sp)
	addi $sp, $sp, 4

	lw $s1, 0($sp)
	addi $sp, $sp, 4

	lw $s0, 0($sp)
	addi $sp, $sp, 4

	#Do not remove this line
	jr      $ra

exit:
	# exit the program
        li $v0, 10
        syscall
