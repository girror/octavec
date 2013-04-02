function g = kerner_g(w, x)
% KERNER_G   g definition for Kerners model

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
global tau mu;

sz = size(w);
n = sz(2);
dvdx2 = mm_ddx2(squeeze(w(2,:)), x);
dvdx2([1,n]) = dvdx2([2,n-1]); %ugly...
g(1,:) = 0*w(1,:);
g(2,:) = (ve(w, x)-w(2,:))/tau + mu./w(1,:).*dvdx2;


%%%%
function ve = ve(w,x)
global v0 rhomax rhoi b;
d=1/(1+exp((1-rhoi/rhomax)/b));
%vmsV = speedLimit(w,x);
%vmsV = periodic_sol(0, x, vmsV);
%ve = min(v0,vmsV).*(1./(1+exp((w(1,:) - rhoi)/rhomax / b)) - d);
ve = v0*(1./(1+exp((w(1,:) - rhoi)/rhomax / b)) - d);


%%%%
% some experimental function for modelling Variable Message Signs ('50-70-90')
%%
function sl = speedLimit(w, x)
global sl_x sl_v sl_sl sl_dL sl_dV sl_vmsx sl_vmsV MM_A MM_B;
roadlength=MM_B-MM_A;
vmsdist = 500;
detectdist = 200;

nvms = floor(roadlength/vmsdist);
for i = 1:nvms
    ids = find(x >= mod((i-1)*vmsdist + detectdist, roadlength));
    idx = ids(1);
    detLoc(i) = x(idx);
    detV(i) = w(2,idx);
    vmsV(i) = classifyV(w(2,idx));
end
for i = 1:nvms
    vmsU_x = (i-1)*vmsdist;
    if i~=nvms
        vmsD_x = i*vmsdist;
    else
        vmsD_x = roadlength;
    end

    xids = find(x > vmsU_x & x <= vmsD_x);
    l = (x(xids) - vmsU_x)/(vmsD_x - vmsU_x);
    sl(xids) = (1-l)*vmsV(i) + l*vmsV(mod(i,nvms)+1);
end

sl_x = x;
sl_v = w(2,:);
sl_sl = sl;
sl_dL = detLoc;
sl_dV = detV;
sl_vmsx = (0:nvms-1)*vmsdist;
sl_vmsV = vmsV;

function vmsV = classifyV(v)
global v0;
if v <= 50/3.6
    vmsV = 50/3.6;
elseif v <= 70/3.6
    vmsV = 70/3.6;
elseif v <= 90/3.6
    vmsV = 90/3.6;
else
    vmsV=v0;%500/3.6; %unlimited
end


    
