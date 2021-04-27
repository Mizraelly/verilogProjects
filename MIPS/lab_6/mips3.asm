addiu $a0, $zero, 0
addiu $a1, $zero, 5
addiu $a2, $zero, 10
addiu $a3, $zero, 5

addiu $t0, $zero, 0
addiu $t1,$zero,1
sll $t1, $t1, 31


loop:
lw $s0,($a0)
lw $s1,($a1)

and $t2, $s0, $t1

beq $t2, $zero, check0
nor $s0, $s0, $s0
addiu $s0, $s0, 1
check0:

and $t2, $s1, $t1

beq $t2, $zero, check1

nor $s1, $s1, $s1
addiu $s1, $s1, 1
check1:

add $s2, $s1, $s0
sw $s2, ($a2)

addiu $t0,$t0,1
addiu $a0,$a0,1
addiu $a1,$a1,1
addiu $a2,$a2,1