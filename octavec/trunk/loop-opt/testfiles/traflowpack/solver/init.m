function [xo, uo] = init(f_init)
global MM_NX MM_NU MM_A MM_B;

dx = (MM_B - MM_A) / (MM_NX - 3);
xo = MM_A-2*dx:dx:MM_B+2*dx;
uo = feval(f_init, cellaverages(xo));
su = size(uo);
MM_NU = su(1);
