# This program should written for data at 0x2000 and text at 0 using RARS.
	.text
_start:	call main	# reset entry point for GNU

	.section	.text.load_register_values,"ax",@progbits
	.globl	load_register_values
load_register_values:
# When this function is called, all registers will be assigned a
# value equal to the register number. One exception is x1, which
# contains the return address to return from this function.
	# x31 = x1 = return address
	add x31, x0, x1
	# store x1 = 1
	addi x1, x0, 1
	# x2 = x1 + x1 = 2
	add x2, x1, x1
	# x3 = x2 OR 1 (immediate) = 3
	ori x3, x2, 1
	# x4 = x3 + 1 (immediate ) = 4
	addi x4, x3, 1
	# x6 = x4 + x2 = 6
	add x6, x4, x2
	# x5 = x6 - 1 = 5
	sub x5, x6, x1
	# x7 = x4 OR 3 (immediate) = 7
	ori x7, x4, 3
	# x10 = x7 + 3 (immediate) = 10
	addi x10, x7, 3
	# x8 = x0 - x2 = -2
	sub x8, x0, x2
	# x8 = x10 + x8 = 8
	add x8 x10, x8
	# x9 = x10 + (-1) (immediate) = 9
	addi x9, x10, -1
	# x27 = x7 + 20 (immediate) = 27 (binary ...00011011)
	addi x27, x7, 20
	# x15 = x9 + x6 = 15             (binary ...00001111)
	add x15, x9, x6
	# x11 = x15 AND x27 = 11
	and x11, x15, x27
# Now perform bit manipulations using identifiable strings
	# x16 = x0 - x1 = -1 = ffffffff
	sub x16, x0, x1
	# x16 = x16 - x1 = -2 = fffffffe
	sub x16, x16, x1
	# x17 = x16 >> x1 (= 1) for (0111....1111) = 7ffffff
	srl x17, x16, x1
	# x18 = x16 AND x17 = (0111...1110) = 7ffffffe
	and x18, x16, x17
	# x19 = x18 XOR x16 = 800000000
	xor x19, x18, x16
	# x20 = x15 << 28 for (1111...0000) = f0000000
	slli x20, x15, 28
	# x21 = x17 >> x8 (arithmetic) = 007fffff
	sra x21, x17, x8
	# x23 = x19 >> 8 (arithmetic immediate) = ff800000
	srai x23, x19, 8
	# x22 = x21 OR x23 = ffffffff
	or x22, x21, x23
# resume filling registers with register values (i.e., 12 in x12, etc.)
	# x12 = x17 AND 12 (immediate) = 12
	andi x12, x17, 12
	# x13 = x17 >> 29 (immediate) = 3
	srli x13, x17, 29
	# x13 = x13 << x2 = 12
	sll x13, x13, x2
	# x13 = x13 + x1 = 13
	add x13, x13, x1
	# x14 = x18 >> x27 (arithmetic) = 15
	sra x14, x18, x27
	# x14 = x14 - x1 = 14
	sub x14, x14, x1
	# Test slti: x16 = x15 < 16 (immediate) = 1
	slti x16, x15, 16
	# x16 = x16 + x15 = 16
	add x16, x16, x15
	# Test sltiu: x17 = x16 < 16 (immediate) = 0
	sltiu x17, x16, 16
	# x17 = x16 + x1 = 17
	add x17, x16, x1
	# Test slt: x18 = x18 < x19 = 0
	slt x18, x18, x19
	# x18 = x17 + x1 = 18
	add x18, x17, x1
	# Test sltu: x19 = x19 < x20 = 1
	sltu x19, x19, x20
	# x19 = x19 + x18 = 19
	add x19, x19, x18
	# Test slti: x20 = x21 < 1 (immediate) = 0
	slti x20, x21, 1
	# x20 = x19 + x1 = 20
	add x20, x19, x1
	# x22 = x22 + 1 (immediate) = 0
	addi x22, x22, 1
	# Test sltiu: x21 = x22 < 1 (immediate) = 1
	sltiu x21, x22, 1
	# x21 = x21 + x20 = 21
	add x21, x21, x20
	# Test slt: x22 = x22 < x1 = 1
	slt x22, x22, x1
	# x22 = x22 + x21 = 22
	add x22, x22, x21
	# Test sltu: x23 = x23 < x0 = 0
	sltu x23, x23, x0
	# x23 = x22 + x1 = 23
	add x23, x22, x1
	# x24 = x6 << x2 = 24
	sll x24, x6, x2
	# x25 = x27 + (-2) (immediate) = 25
	addi x25, x27, -2
	# x26 = x24 + x2 = 26
	add x26, x24, x2
	# x28 = x14 << 1 (immediate) = 28
	slli x28, x14, 1
	# x1 = x31 + x0, restore return address to x1
	add x1, x31, x0
	# x31 = x28 OR 3 (immediate) = 31
	ori x31, x28, 3
	# x29 = x31 + (-2) (immediate) = 29
	addi x29, x31, -2
	# x30 = x31 >> 1 (immediate) = 15
	srli x30, x31, 1
	# x30 = x30 << 1 (immediate) = 30
	slli x30, x30, 1
	ret

	.section	.text.test_load_store,"ax",@progbits
	.globl	test_load_store
test_load_store:
# When this function is called, all registers should contain a
# value equal to the register number. One exception is x1, which
# contains the return address to return from this function. Also,
# x6 will not contain 6 since it is used when this function is called.
	addi	x31, x0, 2	# x31 = x0 + 2 (immediate)
	slli	x31, x31, 12	# x31 = x31 << 12 (immediate) = 0x2000 = RAM[0], start of RAM
	addi	x6, x0, 6	# x6 = x0 + 6 (immediate), store 6 in x6
	# store byte 0 of x1 at RAM[1]
	sb x1, 4
	# store half-word 0 of x2 at RAM[2]
	sh x2, 8
	# store word x3 at RAM[3]
	sw x3, 12
	# store byte 0 of x4 at RAM[4]
	sb x4, 16
	# store half-word 0 of x5 at RAM[5]
	sh x5, 20
	# store word of x6 at RAM[6]
	sw x6, 24
	# store byte 0 of x7 at RAM[7]
	sb x7, 28
	# store half-word 0 x8 at RAM[8]
	sh x8, 32
	# store word of x9 at RAM[9]
	sw x9, 36
	# store byte 0 of x10 at RAM[10]
	sb x10, 40
	# store half-word 0 of x11 at RAM[11]
	sh x11, 44
	# store word of x12 at RAM[12]
	sw x12, 48
	# store byte 0 of x13 at RAM[13]
	sb x13, 52
	# store half-word 0 of x14 at RAM[14]
	sh x14, 56
	# store word of x15 at RAM[15]
	sw x15, 60
	# store byte 0 of x16 at RAM[16]
	sb x16, 64
	# store half-word 0 of x17 at RAM[17]
	sh x17, 68
	# store word of x18 at RAM[18]
	sw x18, 72
	# store byte 0 of x19 at RAM[19]
	sb x19, 76
	# store half-word 0 of x20 at RAM[20]
	sh x20, 80
	# store word of x21 at RAM[21]
	sw x21, 84
	# store byte 0 of x22 at RAM[22]
	sb x22, 88
	# store half-word 0 of x23 at RAM[23]
	sh x23, 92
	# store word of x24 at RAM[24]
	sw x24, 96
	# store byte 0 of x25 at RAM[25]
	sb x25, 100
	# store half-word 0 of x26 at RAM[26]
	sh x26, 104
	# store word of x27 at RAM[27]
	sw x27, 108
	# store byte 0 of x28 at RAM[28]
	sb x28, 112
	# store half-word 0 of x29 at RAM[29]
	sh x29, 116
	# store word of x30 at RAM[30]
	sw x30, 120
	# store word of x31 at RAM[31]
	sw x31, 124
# Now, reset registers x2-x30 equal to zero before returning. Note that x1
# should not be reset to zero because it contains the return address. Also,
# x31 should not be reset to zero because it points to the start of RAM.
	addi x2, x0, 0
	addi x3, x0, 0
	addi x4, x0, 0
	addi x5, x0, 0
	addi x6, x0, 0
	addi x7, x0, 0
	addi x8, x0, 0
	addi x9, x0, 0
	addi x10, x0, 0
	addi x11, x0, 0
	addi x12, x0, 0
	addi x13, x0, 0
	addi x14, x0, 0
	addi x15, x0, 0
	addi x16, x0, 0
	addi x17, x0, 0
	addi x18, x0, 0
	addi x19, x0, 0
	addi x20, x0, 0
	addi x21, x0, 0
	addi x22, x0, 0
	addi x23, x0, 0
	addi x24, x0, 0
	addi x25, x0, 0
	addi x26, x0, 0
	addi x27, x0, 0
	addi x28, x0, 0
	addi x29, x0, 0
	addi x30, x0, 0
	ret

	.section	.text.test_branch,"ax",@progbits
	.globl	test_branch
test_branch:
	# load x2 = byte 1 of RAM[2] = 0
	lb x2, 9
	# Test x2 = 0: branch to X2 taken
	beq x2, x0, X2
	# jump to failed
	j failed
X2:	# load x2 = byte 0 of RAM[2] = 2
	lb x2, 8
	# Test x2 = 0: branch to X2 not taken
	beq x2, x0, X2
	# load x3 = half word 1 of RAM[3] = 0
	lh x3, 12
	# Test x3 != x1: branch to X3 taken
	bne x3, x1, X3
	# jump to failed
	j failed
X3:	# load x3 = half word 0 of RAM[3] = 3
	lh x3, 12
	# Test x3 != x3: branch to X3 not taken
	bne x3, x3, X3
	# Load x4 = byte 0 (unsigned) of RAM[4] = 4
	lbu x4, 16
X4:	# Test x4 < x5: branch to X4 not taken
	bltu x4, x5, X4
	# Load x5 = half word 0 (unsigned) of RAM[5] = 5
	lhu x5, 20
	# Test x4 < x5: branch to X6 taken
	bltu x4, x5, X6
	# jump to failed
	j failed
X6:	# load x6 = word of RAM[6] = 6
	lw x6, 24
X7:	# Test x6 < x7 (unsigned): branch to X7 not taken
	bltu x6, x7, X7
	# load x7 = byte 0 of RAM[7] = 7
	lbu x7, 28
	# Test x6 < x7 (unsigned) branch to X8 taken
	bltu x6, x7, X8
	# jump to failed
	j failed
X8:	# load x8 = half word 0 of RAM[8] = 8
	lhu x8, 32
	# Test x8 >= x9: branch to X9 taken
	bgeu x8, x9, X9
	# jump to failed
	j failed
X9:	# load x9 = byte 0 (unsigned) of RAM[9] = 9
	lbu x9, 36
	# Test x8 >= x9: branch to X9 not taken
	bgeu x8, x9, X9
	# load x10 = half word 0 (unsigned) of RAM[10] = 10
	lhu x10, 40
	# Test x10 >= x11 (unsigned): branch to X11 taken
	bgeu x10, x11, X11
	# jump to failed
	j failed
X11:	# load x11 = word at RAM[11] = 11
	lw x11, 44
	# Test x10 >= x11 (unsigned): branch to X11 not taken
	bgeu x10, x11, X11
	# load x12 = byte 0 at RAM[12] = 12
	lb x12, 48
	# Test x12 >= x11: branch to X27 taken
	bge x12, x11, X27
X13:	# load x13 = half word 0 at RAM[13] = 13
	lh x13, 52
	# load x14 = byte 0 (unsigned) at RAM[14] = 14
	lbu x14, 56
	# Test x13 = x14: branch to X13 not taken
	beq x13, x14, X13
	# load x15 = half word 0 (unsigned) at RAM[15] = 15
	lhu x15, 60
	# load x16 = word at RAM[16] = 16
	lw x16, 64
	# Test x15 != x16: branch to X25 taken
	bne x15, x16, X25
X17:	# load x17 = byte 0 at RAM[17] = 17
	lb x17, 68
	# load x18 = half word 0 at RAM[18] = 18
	lh x18, 72
	# Test x18 < x17: branch to X17 not taken
	blt x18, x17, X17
	# load x19 = byte 0 (unsigned) at RAM[19] = 19
	lbu x19, 76
	# load x20 = half word 0 (unsigned) at RAM[20] = 20
	lhu x20, 80
	# Test x19 < x20 (unsigned): branch to X23 taken
	bltu x19, x20, X23
X31:	# load x29 = byte 0 (unsigend) at RAM[29] = 29
	lbu x29, 116
	# Test x29 = x0: branch to failed not taken
	beq x29, x0, failed
	# jump to almost
	j almost
failed:	# Test x0 = x0: branch to failed taken (infinite loop)
	beq x0, x0, failed
almost:	# jump to done
	j done
X21:	# load x21 = word at RAM[21] = 21
	lw x21, 84
	# load x22 = byte 0 at RAM[22] = 22
	lb x22, 88
	# Test x21 != x22: branch to X31 taken
	bne x21, x22, X31
X27:	# load x27 = byte 0 at RAM[27] = 27
	lb x27, 108
	# load x28 = half word at RAM[28] = 28
	lh x28, 112
	# Test x28 >= x27 (unsigned): branch to X13 taken
	bgeu x28, x27, X13
X25:	# load x25 = half word 0 (unsigned) at RAM[25] = 25
	lhu x25, 100
	# load x26 = word at RAM[26] = 26
	lw x26, 104
	# Test x26 >= x25 (unsigned): branch to X17 taken
	bgeu x26, x25, X17
X23:	# load x23 = half word 0 at RAM[23] = 23
	lh x23, 92
	# load x24 = byte 0 (unsigned) at RAM[24] = 24
	lbu x24, 96
	# Test x23 != x24: branch to X21 taken
	bne x23, x24, X21
done:	# load x30 = word at RAM[30] = 30
	lw x30, 120
	ret

	.section	.text.main,"ax",@progbits
	.globl	main
main:
	call 	load_register_values
	call 	test_load_store
	call 	test_branch
 	lui x31, 0xfffff
end:	beq 	x0, x0, end	# infinite loop
