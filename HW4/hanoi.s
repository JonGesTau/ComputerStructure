# Hanoi Towers
# 

	.data
prompt:	.asciiz	"Enter number of disks\n"

	.text

	.globl main
main: 
	# Prompt the user to enter number of disks
	li	$v0, 4
	la 	$a0, prompt
	syscall

	# Get the number of disks
	li	$v0, 5
	syscall

	# Store the number of disks in $a0
	add $a0, $v0, $0

	# Init stacks
	# Start stack
	addi $a1, $0, 1

	# Destination stack
	addi $a2, $0, 3

	# Extra stack
	addi $a3, $0, 32

hanoi:


	# EOP
	li $v0, 10   # syscall 10 = exit    
	syscall
