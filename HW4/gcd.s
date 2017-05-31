# GCD
# 

	.data
theValueIs:	.asciiz "\nThe value is "
linebreak:	.asciiz	"\n"

	.text

	.globl main
main:
	# Get the first number
	li $v0, 5
	syscall

	# Store the first number in $a0
	add $a0, $v0, $zero

	# Get the second number
	li $v0, 5
	syscall

	# Store the number of disks in $a1
	add $a1, $v0, $zero

	jal gcd

	# Save result
	move $t0, $v0

	# Print result
	li	$v0, 4
	la	$a0, theValueIs
	syscall
	
	li	$v0, 1
	move $a0, $t0
	syscall
	
	li	$v0, 4
	la	$a0, linebreak
	syscall

	# End Of Program
	li	$v0, 10
	syscall

gcd:
	move $t0, $a0
	move $t1, $a1

	# If the first number is 0, return the second number
	beq $t0, $zero, returnSecondNumber

recursion:
	beq $t1, $zero, returnFirstNumber
	
	# If the first number is larger than the second one, subtract the second number from the first one
	# Otherwise, subtract the first number from the second one.
	slt $t2, $t1, $t0
	beq $t2, $zero, subFirstFromSecond
	sub $t0, $t0, $t1
	j recursion

subFirstFromSecond:
	sub $t1, $t1, $t0
	j recursion

returnFirstNumber:
	move $v0, $t0
	jr $ra

returnSecondNumber:
	move $v0, $t1
	jr $ra