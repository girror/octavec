function iir_tb
# Load function
#source("iir.m");

# Evaluate function
disp(iir([0.5;-0.25;-0.1;0.1],[0.5;-0.25;-0.1;0.1],
	 [0;0.5;1;0.5;0;-0.5;-1;-0.5;0;0.5;1;0.5;0;-0.5;-1;-0.5],
	 4,4,16));
