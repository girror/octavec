function w = kerner1_init(xa)
% KERNER1_INIT  initial conditions for kerner1 problem

% Copyright (C) 2002 Arthur van Dam, Delft, The Netherlands
% 
% This file is part of TraFlowPACK.
% 
% TraFlowPACK is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
% 
% TraFlowPACK is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with TraFlowPACK; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
% 
% More info at: http://www.inro.tno.nl/five/traflow/
global drho0 rhobase;

kerner1_params;

n=length(xa);
roadlength = (xa(n)-xa(1));%/3;

if(1)
% small perturbation; set global drho0 and rhobase (for example to 0.001 resp. 0.038)
xids = 1:n;%floor(n/3);
f1 = cosh(160/roadlength*(xa(xids)-5*roadlength/16));
f2 = cosh(40/roadlength*(xa(xids)-11*roadlength/32));
%dist = drho0 * cos(2*pi*x/roadlength);
dist = [real(drho0*(1./(f1.^2) - 0.25./(f2.^2)))];%, zeros(1,n-floor(n/3))];
%w(1,:) = 0.038 + dist;
w(1,:) = rhobase + dist;
w(2,:) = 0*xa+16;
elseif(1)
% traffic jam in the middle of the road
r_top = 100/1000;
r_bot = 10/1000;

v_top = 5;
v_bot = 30;

basewidth = 2*1000;
roadlength = 6E3;
idx = find(xa >= (roadlength/2-basewidth/2) & xa < (roadlength/2+basewidth/2));

w(getIdx(1),:) = sameAllUCs(sameAllLanes(0*xa + r_bot));
w(getIdx(2),:) = sameAllUCs(sameAllLanes(0*xa + v_bot));
w(getIdx(1),idx) = sameAllUCs(sameAllLanes(0*xa(idx) + r_top));
w(getIdx(2),idx) = sameAllUCs(sameAllLanes(0*xa(idx) + v_top));
elseif(1)
% sinus-wave distribution
r_base = 30/1000;
r_dist = 5/1000;

v_base = 20;
v_dist = 0;

roadlength = 10E3;
pert = sin(2*pi*xa/roadlength);

w(1,:) = r_base + r_dist*pert;
w(2,:) = 20 + 0*w(1,:);
end