restart -force;
force x[0] 2#1;
force x[1] 2#0;
force x[2] 2#1;
force x[3] 2#1;
force x[4] 2#0;
force x[5] 2#0;
force x[6] 2#1;
force x[7] 2#0;

force a[0] 2#0 0ns, 2#1 50ns, 2#0 100ns, 2#1 150ns, 2#0 200ns, 2#1 250ns , 2#0 300ns, 2#1 350ns; 
force a[1] 2#0 0ns, 2#0 50ns, 2#1 100ns, 2#1 150ns, 2#0 200ns, 2#0 250ns , 2#1 300ns, 2#1 350ns; 
force a[2] 2#0 0ns, 2#0 50ns, 2#0 100ns, 2#0 150ns, 2#1 200ns, 2#1 250ns , 2#1 300ns, 2#1 350ns; 
force en 2#0 0ns, 2#1 70ns, 2#0 150ns;
run 400ns;