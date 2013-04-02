function error_check()
% ERROR_CHECK   Error-diagnostics on results by MMFVPDES
%   ERROR_CHECK computes some error-norms for the latest results
%   produced by MMFVPDES.
%   MMFVPDES places its results in global variables, ERROR_CHECK uses these
%   as well as an exact reference solution, read from a file 'mmfvexact.mat'
%
%   ERROR_CHECK is actually only called from within MMFVPDES, but if you want
%   to do so yourself, pay attention to the following:
%       1. MMFVPDES should be run first, to produce a numerical solution in
%          the global variables: MM_ALLU MM_ALLX MM_ALLT.
%       2. A file 'mmfvexact.mat' should exist in the workroot, containing the exact solution
%       3. 'mmfvexact.mat' should contain three variables: tn, xn and un
%          * tn = one single timevalue at which the exact solution is provided
%          * xn = 1 x (n+2) vector of meshpoint locations at t=tn (for some n)
%          * un = MM_NU x (n+1) vector of solution values between meshpoints xn at t=tn
%       4. For proper error-checking, of course tn should be the same as Tend of the latest
%          MMFVPDES-run (i.e. the error is always computed for the latest time-instant).
%       5. ERROR_CHECK contains some manual inline settings for measuring errors not at shocks.
%          Modify the code yourself for your own problems.
%
%   See also: MMFVPDES.

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

global MM_NX MM_NU MM_A MM_B;
global MM_ALLT MM_ALLX MM_ALLU;
global shockx;

filesep = '/';

exactFile = 'mmfvexact.mat';
exactPath = [workroot,filesep,exactFile];

nt = length(MM_ALLT);

fid = fopen(exactPath);
if fid==-1
    warn(sprintf('No file ''%s'' found.\n  Please verify that this file exists, and that it is in the MATLAB-searchpath.\n', exactFile));
    return;
else
    fclose(fid);
end

% now proceed, since file exists.
exact = load(exactPath);
ue = exact.un(1,:);

u  = reshape(MM_ALLU(1,nt,:),1,MM_NX+1);
xa = cellaverages(MM_ALLX(nt,:));

%%
% First locate shock-locations in numerical solution
%%

%ux = ddx(MM_ALLU(:,nt,:),xa);
%mux= (max(abs(ux')))';
%uxw= abs(ux) ./ (mux * ones(1,MM_NX-1));
%if MM_NU>1
%  uxs=sum(uxw) / MM_NU;
%else
%  uxs = uxw;
%end
%%uxs now contains the normalized (sum of) physical gradients

%% several ways to locate shocks...

%% filter on normalized sum of gradients:
%shockx=find(uxs>=0.6);

%% filter on steepness of any component of u:
%shockx=find(max(uxw>=0.5)>0);

%manual for a specific problem:
%shockx=find((xa >= .67 & xa <= .71) | (xa >= .83 & xa <= .87));
%shockx=find((xa >= 4.08 & xa <= 4.22));
shockx=[]; % no shocks predefined

% the indexes of x-points inside the domain.
xids=3:MM_NX-1;

%%
% Next, find 'normal' error in solution:
%%
uni = interp1(cellaverages(exact.xn), exact.un', cellaverages(MM_ALLX(nt,:)));
if MM_NU>1
    uni = uni';
end
e(:,3:MM_NX-1) = abs(reshape(MM_ALLU(:,nt,3:MM_NX-1),MM_NU,MM_NX-3) - uni(:,3:MM_NX-1));
re(:,3:MM_NX-1) = e(:,3:MM_NX-1);
%% or normalized:
%re(:,3:MM_NX-1) = e(:,3:MM_NX-1) ./ abs(uni(:,3:MM_NX-1)); % relatieve fout
rew(:,3:MM_NX-1) = re(:,3:MM_NX-1) .* (ones(MM_NU,1) * cellsizes(MM_ALLX(nt,3:MM_NX))); % gewogen fout, afhankelijk van Delta x
if MM_NU>1
    res(3:MM_NX-1) = sum(rew(:,3:MM_NX-1));
else
    res(3:MM_NX-1) = rew(3:MM_NX-1);
end

fprintf('Rel. error in u\t: L_1 norm=%g\n',norm(res(:,xids),1));
fprintf('Rel. error in u\t: L_2 norm=%g\n',norm(res(:,xids),2));
fprintf('Rel. error in u\t: L_\\infty norm=%g\n',norm(res(xids),inf));

xids = setdiff(xids,shockx); % only the xids that are not at a shock

fprintf('Rel. error in u, outside shock\t: L_1 norm=%g\n',norm(res(:,xids),1));
fprintf('Rel. error in u, outside shock\t: L_2 norm=%g\n',norm(res(:,xids),2));
fprintf('Rel. error in u, outside shock\t: L_\\infty norm=%g\n',norm(res(xids),inf));

return;
%% Below are some additional error-checkers, that are only applicable in specific cases.

% Optionally write values to file for batch-processing
%global alpha1 alpha2;
%fid=fopen('alpha_exps51BM.txt','a');
%global alpha;
%global runningtime;
%fprintf(fid,'N=%d, alpha=%g\n', MM_NX, alpha);
%fprintf(fid,'%%N\talpha1\talpha2\trunning time\t error_2\terror_inf\tnoshocks:error_2\terror_inf\tmaxw\tavgw\tavgmaxw\tavgdiffw\n');
%fprintf(fid,'%d\t%g\t%g\t%g', MM_NX, alpha1, alpha2, runningtime);
%xids=[3:MM_NX-1];
%fprintf(fid,'\t%g\t%g', norm(res(:,xids),2), norm(res(:,xids),inf));
%xids=setdiff(xids,shockx);
%fprintf(fid,'\t%g\t%g', norm(res(:,xids),2), norm(res(:,xids),inf));
%fprintf(fid,'\t%g\t%g\t%g\t%g\n',maxw, totw/(nw*(MM_NX-3)), totmaxw/nw, diffw/nw);
%fprintf(fid,'\n');
%fclose(fid);

%%%%%
% error in x-location of shock is solution contains only one shock, of which the top and bottom peaks
% are also the maximum and minimum value at the entire domain, like in the Burgers' problem.
%shock_p = max(ue);
%shock_m = min(ue);
%shock_h = (shock_p + shock_m)/2;
%shock_ids = find(ue > shock_h);
%shock_i = shock_ids(end);
%
%xna = cellaverages(exact.xn);
%shock_xe = xna(shock_i) + (shock_h - ue(shock_i)) / (ue(shock_i+1) - ue(shock_i)) * (xna(shock_i + 1) - xna(shock_i));
%
%shock_p = max(u);
%shock_m = min(u);
%shock_h = (shock_p + shock_m)/2;
%shock_ids = find(u > shock_h);
%shock_i = shock_ids(end);
%
%shock_x = xa(shock_i) + (shock_h - u(shock_i)) / (u(shock_i+1) - u(shock_i)) * (xa(shock_i + 1) - xa(shock_i));
%
%e_sx = abs(shock_x - shock_xe);
%re_sx = e_sx / (MM_B-MM_A);
%
%fprintf('Rel. error in x-location shock\t: %g\n',re_sx);

%%%%%
% Maximal derivative (should be -\infty at shock for Burgers')
%ux = dudx(u, xa);
%[m,i] = max(abs(ux));
%derinfo1 = sprintf('Largest derivative-value\t: u_x=%g at x=%g\n', ux(i), xa(i));


%%%%%
% burgers only:
%du = cellsizes(uni);
%[m,shock_i] = max(abs(du));
%
%[s_t,shock_s] = max(u);
%[s_b,shock_e] = min(u);
%
%derinfo2 = sprintf('Average derivative-value\t: u_x=%g at x=[%g,%g]\n', (s_b-s_t)/(xa(shock_e) - xa(shock_s)), xa(shock_s), xa(shock_e));
%
%global alpha;
%global maxw totw totmaxw nw;
%fid=fopen('alpha_exps51g.txt','a');
%fprintf(fid,'N=%d, alpha=%g\n', MM_NX, alpha);
%xids = [3:shock_s, shock_e:MM_NX-1];
%fprintf(fid,'excl shock: %g & %g & %g & %3.2f & %3.2f\n', norm(res(:,xids),2), norm(res(:,xids),inf), re_sx, (s_b-s_t)/(xa(shock_e) - xa(shock_s)), ux(i));
%xids=[3:MM_NX-1];
%fprintf(fid,'incl shock: %g & %g & %g & %3.2f & %3.2f\n', norm(res(:,xids),2), norm(res(:,xids),inf), re_sx, (s_b-s_t)/(xa(shock_e) - xa(shock_s)), ux(i));
%
%
%fprintf(fid,'%g \t %g \t %g\n',maxw, totw/(nw*(MM_NX-3)), totmaxw/nw);
%fprintf(fid,'\n');
%fclose(fid);
%
%xids = [3:shock_s, shock_e:MM_NX-1];
%xids=[3:MM_NX-1];
%fprintf(' & %g & %g & %g & %3.2f & %3.2f\\\\\\hline\n', norm(res(:,xids),2), norm(res(:,xids),inf), re_sx, (s_b-s_t)/(xa(shock_e) - xa(shock_s)), ux(i));
%
%fprintf('%s%s',derinfo1, derinfo2);
%
%fprintf('Rel. error in u, outside shock\t: L_1 norm=%g\n',norm(res(:,xids),1));
%fprintf('Rel. error in u, outside shock\t: L_2 norm=%g\n',norm(res(:,xids),2));
%fprintf('Rel. error in u, outside shock\t: L_\\infty norm=%g\n',norm(res(xids),inf));
