start:
add $t0,$t1,$t2
sub $t0,$t0,$t2
and $t0,$t1,$t2
or  $t0,$t3,$t4
nor $t0,$t0,$t0
slt $t0,$t2,$t1
addiu $t1,$t2,2
sw $t0,($t1)
lw $t3,($t1)
beq $t3,$t3,skip
nop 
nor $t0,$t0,$t0
nor $t0,$t0,$t0
skip:
j start
