start:
addiu $t1,$zero,5 
addiu $t2,$zero,11 
add $t3,$t1,$t2 
loop:
lw $t4,($t1) 	
#addiu $t4,$zero,2
add $t0,$t0,$t4 
addiu $t1,$t1,1 
bne $t1,$t3,loop  
nop
sw $t0,($t1)  
