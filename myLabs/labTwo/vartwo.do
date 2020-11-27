restart -force;
force pin_name 2#0 0ns, 2#1 50ns, 2#0 100ns, 2#1 150ns, 2#0 200ns, 2#1 250ns , 2#0 300ns, 2#1 350ns; 
force pin_name1  2#0 0ns, 2#0 50ns, 2#1 100ns, 2#1 150ns, 2#0 200ns, 2#0 250ns , 2#1 300ns, 2#1 350ns; 
force pin_name2  2#0 0ns, 2#0 50ns, 2#0 100ns, 2#0 150ns, 2#1 200ns, 2#1 250ns , 2#1 300ns, 2#1 350ns; 
run 400ns;