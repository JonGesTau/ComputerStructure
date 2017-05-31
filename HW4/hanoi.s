# Hanoi Towers
# 

	.data
prompt:		.asciiz	"Enter number of disks\n"
arrow:		.asciiz ">"
A:			.asciiz "A"
B:			.asciiz "B"
C:			.asciiz "C"
linebreak:	.asciiz "\n"

	.text

	.globl main
main: 
	# Prompt the user to enter number of disks
	li $v0, 4
	la $a0, prompt
	syscall

	# Get the number of disks
	li $v0, 5
	syscall

	# Store the number of disks in $a0
	add $a0, $v0, $0

	# Init stacks
	# Source stack (A)
	la $a1, A

	# Destination stack (C)
	la $a2, C

	# Extra stack (B)
	la $a3, B

hanoi:
	# Base case - Number of disks is 1
	addi $t0, $a0, 0
	addi $t1, $0, 1

	bne $a0, $t1, handleMultiplePegs

	# Print "A>C"
	li $v0, 4
	move $a0, $a1
	syscall

	li $v0, 4
	la $a0, arrow
	syscall

	li $v0, 4
	move $a0, $a2
	syscall

	li $v0, 4
	la $a0, linebreak
	syscall

	# Reset $a0
	addi $a0, $t0, 0
	jr $ra

	# End Of Program
	li $v0, 10   # syscall 10 = exit    
	syscall

handleMultiplePegs:
	# Make stack larger
	addi $sp, $sp -20

	# Init stack vars
	sw $a0, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $a3, 12($sp)
	sw $ra, 16($sp)

	# Ready recursion
	move $t3, $a3
	move $a3, $a2
	move $a2, $t3
	addi $a0, $a0, -1

	jal hanoi

	# Load stack
	lw $a0, 0($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $a3, 12($sp)
	lw $ra, 16($sp)

	# Move disks and print
	addi $t0, $a0, 0
	addi $t1, $zero, 1

	li $v0, 4
	move $a0, $a1
	syscall

	li $v0, 4
	la $a0, arrow
	syscall

	li $v0, 4
	move $a0, $a2
	syscall

	li $v0, 4
	la $a0, linebreak
	syscall

	# Reset $a0
	addi $a0, $t0, 0

	# Ready recursion
	move $t3, $a3
	move $a3, $a1
	move $a1, $t3
	addi $a0, $a0, -1

	jal hanoi

	# Reset stack
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	add $v0, $zero, $t5
	jr $ra

	