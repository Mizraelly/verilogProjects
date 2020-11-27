restart -force;
force a 2#0 0ns, 2#1 100ns, 2#0 150ns, 2#1 200ns, 2#0 250ns, 2#1 300ns , 2#0 350ns, 2#1 400ns; 
force b 2#0 0ns, 2#0 100ns, 2#1 150ns, 2#1 200ns, 2#0 250ns, 2#0 300ns , 2#1 350ns, 2#1 400ns; 
force c 2#0 0ns, 2#0 100ns, 2#0 150ns, 2#0 200, 2#1 250ns, 2#1 300ns , 2#1 350ns, 2#1 400ns; 
run 500ns;