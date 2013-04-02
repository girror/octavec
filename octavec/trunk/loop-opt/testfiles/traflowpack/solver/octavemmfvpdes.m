function varargout = octavemmfvpdes(action, f_settings, N, Tstart, Tend, ...)
%MMFVPDES Solve a PDE-system with moving mesh and 2nd order finite volume scheme
%
%   varargout = MMFVPDES(action, f_settings, N, Tstart, Tend, varargin)
%
%   solves the PDE's specified by settings that f_settings should return:
%   [MM_A, MM_B, f_init, f_monitor, f_f, f_dfdu, f_boundaries, f_g]=feval(f_setting);
%   The domain [MM_A,MM_B] is discretized using N-2 points.
%   PDE-evolution starts at time=Tstart, and ends at Tend.
%
%   Valid actions:
%    > 'comp'        : just compute the solution, don't plot anything, and return t, x, and u (in varargout)
%    > 'exact'       : compute the solution (probably for large N) and store it at Tend in a file.
%    > 'plot'        : compute and plot the solution
%   Check for required arguments below.
%
%   Optional arguments (varargin)
%   1. mm_tol     : The mesh is moved until \|xnew-xold\| <= mm_tol*(MM_B-MM_A)... {default: 1e-6}
%   2. mm_maxit   : ... or mm_maxit iterations were done. {default: 3}
%   3. mm_nsmooth : specifies the number of smoothing-iterations to use for smoothing the monitor-values {default: 0}
%   4. cflC specifies how stringent the adaptive time-step should be set to the CFL-limit (usually 0.5 suffices) {default: 0.5}
%      Whenever clfC < 0, no adaptive timestep is used: \Delta t = abs(cflC)
%   5. solverId   : which solver to use
%    > 1 : MUSCL-type finite volume               (2nd-order accurate, 'shock-proof')
%    > 2 : McCormack finite volume               (Not 'shock-proof')
%    > 3 : forward-time upwind finite differences (Usually too simple and unstable)
%    {default 1}
%   6. timesample : A positive number, indicating the interval (in simulation time) between two
%      successive samples of the solution. [comp, plot] {default: 1}
%   7. plotIdx    : which variable of the solution to plot, in case dim(u)>1. [plot] {default -1 (all)}
%   8. 'save' as the 13th argument indicates to write the data into a .mat file
%      In the workroot a file 'experiments.txt' contains a 'table of contents' of all datafiles.
%   9. 'errorcheck' as the 14th argument indicates to determine some error-diagnostics.
%      A file 'mmfvexact.mat' is required for this
%
%   Concerning the 'exact' option, and the 'errorcheck' option be sure to read the documentation
%   for ERROR_CHECK as well.
%
%   Examples:
%       mmfvpdes('plot', 'settings51', 53, 0.0, 2.0, 3, 1E-6, 2, 0.5, 1, 5, 1,'save');

%   Based on article by Hua-Zhong Tang and Tao Tang.
%   Extended, generalised and implemented in matlab by Arthur van Dam.

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

global MM_NX MM_A MM_B MM_NU;
global MM_ALLT MM_ALLX MM_ALLU;
global maxw totw totmaxw diffw nw;
global userInterrupt;
global runningtime;
global MM_alpha_clear;
global MM_datasource;

%%
% Initialize monitor-diagnostics
%%
maxw = 0;
totw = 0;
totmaxw = 0;
diffw = 0;
nw = 0;

%%
% First check commandline-arguments
%%
if nargin < 8
    warn("Insufficient arguments!");
%    help octavemmfvpdes
% Does not work in Octave
    return;
end

% Default values:
mm_maxit = 3;    % max # remeshing steps
mm_tol = 1E-6;   % remeshing tolerance
mm_nsmooth = 0;  % # monitor-smoothings
cflC = 0.5;      % CFL-prefactor
solverId = 1;    % which PDE solver to user
timesample = 1;  % time-interval between two successive solution-samples.
plotIdx = -1;    % which variable to plot
storeAll = 1;    % whether to store all (sampled) timesteps; if action=='exact': storeAll=0
storeInFile = 0; % whether to store ALL sampled data in a file (not mmfvexact.mat)
errorCheck = 0;  % whether to do some error-checking afterwards

if nargin > 5
    mm_maxit = va_arg();
end

if nargin > 6
    mm_tol = va_arg();
end

if nargin > 7
    mm_nsmooth = va_arg();
end

if nargin > 8
    cflC = va_arg();
end

if nargin > 9
    solverId=va_arg();
end

% The other optional-arguments are action-dependent
switch action
case 'comp'
    if nargin > 10
        timesample=va_arg();
    end
    if nargin > 11
        dataFile = va_arg();
    end
case 'plot'
    if nargin > 10
        timesample=va_arg();
    end
    if nargin > 11
        plotIdx = va_arg();
    end
    if nargin > 12 & strcmp(va_arg(),'save')
        storeInFile = 1;
    end
%    if nargin > 13 & strcmp(va_arg(),'errorcheck')
%        errorCheck = 1;
%    end
case 'exact'
    storeAll = 0;
end

%%
% Parameter Processing
%%
[MM_A, MM_B, f_init, f_monitor, f_f, f_dfdu, f_g, f_boundaries] = feval(f_settings);

MM_NX = N;

%%
% Start the solution procedure
%%
programstart = cputime;

%%
% STEP 1: Set the initial grid and solution
%%
[xn, un] = init(f_init);

if storeAll
    MM_ALLX = [xn];
    MM_ALLU = [];
    MM_ALLU(:,:) = un;  

%Octave does not provide 3-dimensional features needed here. The time dimension
%is not needed here, so we use a 2-dimensional matrix.
    
end

%%
% Start the time-loop
%%
ti = 1;          % time-step counter
ts = 1;          % taken-samples counter
pt = timesample; % passed time since last sample (dummy to store first time).
tn = Tstart;     % current time
MM_ALLT = [tn];
mm_totit = 0;    % total amount of remeshing iterations
fprintf('t=%g (start)', tn);

while tn < (Tend + 1e-12)  % '<=' since if tn=Tend, we still want to remesh for the final time.
    %%
    % STEP 2&3: Move mesh and update solution
    %%
    [xn, un, mm_it] = move_mesh(tn, xn, un, f_monitor, f_boundaries, mm_maxit, mm_tol*(MM_B-MM_A), mm_nsmooth);
    mm_totit = mm_totit + mm_it;
    
    %%
    % STEP 3.5: If needed, store a sample of the existing, remeshed solution
    %%
    if storeAll & (pt >= timesample | abs(tn-Tend)< 1e-12)
        pt = pt - timesample;
        MM_ALLT(ts) = tn;
        MM_ALLX(ts,:) = xn;
        MM_ALLU = [MM_ALLU;un];      %Changed into 2-dimensional matrix
        ts = ts + 1;
        msg = '[S]';
    else
        msg = '';
    end

    fprintf(' \t%s\n', msg);

    %%
    % STEP 4: Use the PDE solver to compute solution at new time
    %%
    if tn < (Tend - 1e-12)  % '<' since if tn=Tend, no further timestep should be made.
        [dt, un] = pdes_step(xn, un, tn, Tend, f_f, f_dfdu, f_boundaries, f_g, cflC, solverId);
        pt = pt + dt;
        tn = tn + dt;
        ti = ti + 1;
        fprintf('t=%g (\\Delta t=%g)', tn, dt);
    else
        break;
    end

end
runningtime = cputime-programstart;

% This is used by the monitorxin function, that determines an optimal alpha value by itself.
% Clear the automatically set value, unless user has specified MM_alpha himself.

if(exist('MM_alpha_clear'))
  if(exist('var'))  
    if(MM_alpha_clear == 1)
      clear global MM_alpha;
      MM_alpha_clear = 0;
    end
  end
end

%%
% Output solution diagnostics (pretty-printed)
%%

txt1 = sprintf("Execution took %g seconds", runningtime);
txt2 = sprintf("Total number of time steps: %g", ti-1);
txt3 = sprintf("Average number of remeshing steps: %g", (mm_totit / ti));
txt4 = sprintf("maxw   : %g",maxw);
txt5 = sprintf("avgw   : %g",totw/(nw*(MM_NX-3)));
txt6 = sprintf("avgmaxw: %g",totmaxw/nw);
bw = max([length(txt1), length(txt2), length(txt3)]) + 4;
disp(fillString(0,bw,0));
printf("| %s%s |\n", txt1, fillString(length(txt1),bw,1));
printf("| %s%s |\n", txt2, fillString(length(txt2),bw,1));
printf("| %s%s |\n", txt3, fillString(length(txt3),bw,1));
disp(fillString(0,bw,0));
printf("| %s%s |\n", txt4, fillString(length(txt4),bw,1));
printf("| %s%s |\n", txt5, fillString(length(txt5),bw,1));
printf("| %s%s |\n", txt6, fillString(length(txt6),bw,1));
disp(fillString(0,bw,0));

%fprintf('\a');
%txt1 = sprintf('Execution took %g seconds', runningtime);
%txt2 = sprintf('Total number of time steps: %g', ti-1);
%txt3 = sprintf('Average number of remeshing steps: %g', (mm_totit / ti));
%txt4 = sprintf('maxw   : %g',maxw);
%txt5 = sprintf('avgw   : %g',totw/(nw*(MM_NX-3)));
%txt6 = sprintf('avgmaxw: %g',totmaxw/nw);
%bw = max([length(txt1), length(txt2), length(txt3)]) + 4;
%fprintf('+%s+\n', repeat('-', bw-2));
%fprintf('| %s%s |\n', txt1, repeat(' ', bw-4-length(txt1)));
%fprintf('| %s%s |\n', txt2, repeat(' ', bw-4-length(txt2)));
%fprintf('| %s%s |\n', txt3, repeat(' ', bw-4-length(txt3)));
%fprintf('+%s+\n', repeat('-', bw-2));
%fprintf('| %s%s |\n', txt4, repeat(' ', bw-4-length(txt4)));
%fprintf('| %s%s |\n', txt5, repeat(' ', bw-4-length(txt5)));
%fprintf('| %s%s |\n', txt6, repeat(' ', bw-4-length(txt6)));
%fprintf('+%s+\n', repeat('-', bw-2));

%%
% Optionally store all sampled data in a .mat file
%%
if storeInFile
    %save_data(workroot, [f_settings,'_',num2str(now)]);
    save_data(workroot, [f_settings]);
else
    MM_datasource = 'Live Simulation Output';
end

%%
% Optionally, check accuracy of solution
%%
if errorCheck
    error_check;
end

%%
% output grid and solution
%%

% nearly equivalent: if a 'mmfvexact.mat' is available for error-checking, then also use it to plot the exact solution.
plotExact = errorCheck;

switch action
case 'comp'  % Pretty useless, since they're globally available anyway
    varargout = {MM_ALLT, MM_ALLX, MM_ALLU};
case 'plot'  % The best value. Visualisation is configured by the user, by editing the file 'show_results.m'
    show_results(plotIdx, plotExact);
case 'exact' % Only stores solution at Tend (useful for storing semi-exact solutions with *many* points)
    save_exact(tn, xn, un);
end


%%%%
%function [xo, uo] = init(f_init)
%global MM_NX MM_NU MM_A MM_B;

%dx = (MM_B - MM_A) / (MM_NX - 3);
%xo = MM_A-2*dx:dx:MM_B+2*dx;
%uo = feval(f_init, cellaverages(xo));
%su = size(uo);
%MM_NU = su(1);


%%%%

%function [xn, un, mm_it] = move_mesh(to, xo, uo, f_monitor, f_boundaries, mm_maxit, mm_tol, mm_nsmooth)
%global MM_NX MM_NU;
%global maxw totw totmaxw nw diffw;

%dxi=1.0/(MM_NX-3);

%%
% Solve the mesh equation: \partial_\xi ( w x_\xi) =0 using Gauss-Seidel iterations
%%
%mm_res = mm_tol+1; % always start bigger
%mm_it = 0;
%while mm_it < mm_maxit & mm_res > mm_tol
    % Compute monitor values
%    w = feval(f_monitor,uo, cellaverages(xo), dxi);
    % smoothen the monitor values
%    for sm=1:mm_nsmooth
%        w = smoothen(w);
%    end
    % Some monitor-diagnostics
%    diffw = diffw + max(cellsizes(w(3:MM_NX-1))) / (MM_NX-3);
%    maxw=max(maxw, max(w(3:MM_NX-1)));
%    totw=totw+sum(w(3:MM_NX-1));
%    totmaxw=totmaxw+max(w(3:MM_NX-1));
%    nw=nw+1;
    
    % Compute the new meshpoint locations with Gauss-Seidel
%    xn([3,MM_NX]) = xo([3, MM_NX]); % fixed boundaries
%    for j=4:MM_NX-1
%        xn(j)=(w(j)*xo(j+1)+w(j-1)*xn(j-1))/(w(j)+w(j-1));
%    end
    % periodic mesh-move speed
%    xn(1)=xo(1)+(xn(MM_NX-2)-xo(MM_NX-2));
%    xn(2)=xo(2)+(xn(MM_NX-1)-xo(MM_NX-1));
%    xn(MM_NX+1)=xo(MM_NX+1)+(xn(4)-xo(4));
%    xn(MM_NX+2)=xo(MM_NX+2)+(xn(5)-xo(5));

    %% or periodic cell-sizes
    %xn(MM_NX+1)=XO(MM_NX)+(xn(4)-xn(3));
    %xn(MM_NX+2)=XO(MM_NX+1)+(xn(5)-xn(4));
    %xn(2)=XO(3)-(xn(MM_NX)-xn(MM_NX-1));
    %xn(1)=XO(2)-(xn(MM_NX-1)-xn(MM_NX-2));

%    mm_res=sum(abs(xn(3:MM_NX)-xo(3:MM_NX))) / (MM_NX-3);
    
    %%
    % Conservative interpolation of u at new mesh
    %%
%    xoa=xo;%cellaverages(xo);
%    xna=xn;%cellaverages(xn);
%    du(1:MM_NU,3:MM_NX) = uo(1:MM_NU,3:MM_NX)-uo(1:MM_NU,2:MM_NX-1); %j - (j-1)
%    S(1:MM_NU,3:MM_NX-1)=(sign(du(1:MM_NU,3:MM_NX-1)) + sign(du(1:MM_NU,4:MM_NX))) .* abs(du(1:MM_NU,3:MM_NX-1) .* du(1:MM_NU,4:MM_NX)) ./ (abs(du(1:MM_NU,3:MM_NX-1)) + abs(du(1:MM_NU,4:MM_NX)) + 1.0E-10);
%    S(1:MM_NU,[2,MM_NX])=S(1:MM_NU,[MM_NX-1,3]); %periodic boundaries

%    up(1:MM_NU,3:MM_NX) = uo(1:MM_NU,3:MM_NX) - 0.5 * S(1:MM_NU,3:MM_NX);
%    um(1:MM_NU,3:MM_NX) = uo(1:MM_NU,2:MM_NX-1) + 0.5 * S(1:MM_NU,2:MM_NX-1);

%    c = xo - xn;
%    cu(1:MM_NU,3:MM_NX) = ones(MM_NU,1)*c(3:MM_NX)/2 .* (up(1:MM_NU,3:MM_NX) + um(1:MM_NU,3:MM_NX)) - (ones(MM_NU,1)*abs(c(3:MM_NX))/2) .* (up(1:MM_NU,3:MM_NX) - um(1:MM_NU,3:MM_NX));

%    un(1:MM_NU,3:MM_NX-1) = ((ones(MM_NU,1)*(xoa(4:MM_NX) - xoa(3:MM_NX-1))) .* uo(1:MM_NU,3:MM_NX-1) - (cu(1:MM_NU,4:MM_NX) - cu(1:MM_NU,3:MM_NX-1))) ./ (ones(MM_NU,1)*(xna(4:MM_NX) - xna(3:MM_NX-1)));
%    un=feval(f_boundaries, to, xn, un); %periodic boundaries

    % Store new 'old' solution
%    xo=xn;
%    uo=un;
   
%    mm_it = mm_it+1;
%end


%%%%
%function w = smoothen(w)
%global MM_NX;

% 3-point smoother
%w(3:MM_NX-1) = (w(2:MM_NX-2) + 2*w(3:MM_NX-1) + w(4:MM_NX))/4;


%%%%
%function [dt, un] = pdes_step(xo, uo, to, Tend, f_f, f_dfdu, f_boundaries, f_g, cflC, solver)
%global UO UN XO xn MM_NX WO MM_NU;

%%
% Find appropriate timestep, with CFL condition
%%
%dx(2:MM_NX) = xo(3:MM_NX+1)-xo(2:MM_NX);
%dxavg = (xo(MM_NX)-xo(3)) / (MM_NX-3);
%if cflC > 0
%    dfdudxmax = 0;
%    if MM_NU > 1
%        dfdu(1:MM_NU,2*MM_NU+1:MM_NU*(MM_NX-1)) = feval(f_dfdu, uo(1:MM_NU,3:MM_NX-1));
	%dfdu(:,:,3:MM_NX-1) = feval(f_dfdu, uo(1:MM_NU,3:MM_NX-1));
%        for i=3:MM_NX-1
%            dfdudxmax = max(dfdudxmax, max(abs(eig(dfdu(:,:,i)))) ./ dx(i));
%            dfdudxmax = max(dfdudxmax, max(abs(eig(dfdu(:,(i-1)*3+1:3*i)))) ./ dx(i));
%        end
%    else
%        dfdudxmax = max(abs(feval(f_dfdu, uo(1:MM_NU,3:MM_NX-1))) ./ dx(3:MM_NX-1));
%    end

%    dt=cflC / (dfdudxmax + 1e-10);
%    dtmax = 10; % manually limit the maximal \Delta t, in case dfdudxmax \approx 0.
%    dt = min(dt, dtmax);
%    dt = min(dt, Tend-to); % do not step beyond endtime
%    dtmin = 1e-4*dxavg;
    %dt = max(dt,dtmin);
%else
%    dt=abs(cflC);
%end

%if dt > 50 | dt < 0.0001*dxavg
%    warn('Adaptive timestep is very big or very small now.');
%end

%%
% Perform one time-solve step with requested solver
%%
%switch solver
%case 1, % Finite Volume, and the Heun scheme
%    dudx(1:MM_NU,3:MM_NX) = (uo(1:MM_NU,3:MM_NX)-uo(1:MM_NU,2:MM_NX-1)) ./ (0.5 * ones(MM_NU,1)*(xo(4:MM_NX+1) - xo(2:MM_NX-1))); % nu wel in physical domain.

%    S(1:MM_NU,3:MM_NX-1)=(sign(dudx(1:MM_NU,3:MM_NX-1)) + sign(dudx(1:MM_NU,4:MM_NX))) .* abs(dudx(1:MM_NU,3:MM_NX-1) .* dudx(1:MM_NU,4:MM_NX)) ./ (abs(dudx(1:MM_NU,3:MM_NX-1)) + abs(dudx(1:MM_NU,4:MM_NX)) + 1.0E-10);
%    S(1:MM_NU,[2,MM_NX])=S(1:MM_NU,[MM_NX-1,3]); %periodic boundaries

%    up(1:MM_NU,3:MM_NX) = uo(1:MM_NU,3:MM_NX) + 0.5 * (ones(MM_NU,1)*(xo(3:MM_NX) - xo(4:MM_NX+1))) .* S(1:MM_NU,3:MM_NX);
%    um(1:MM_NU,3:MM_NX) = uo(1:MM_NU,2:MM_NX-1) + 0.5 * (ones(MM_NU,1)*(xo(3:MM_NX) - xo(2:MM_NX-1))) .* S(1:MM_NU,2:MM_NX-1);

%    if MM_NU>1
%	dfdu_p(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
%        dfdu_m(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
        %dfdu_p(:,:,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        %dfdu_m(:,:,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
%        for i=3:MM_NX
%            dfdu_pv(:,i) = diag(dfdu_p(:,(i-1)*3+1:3*i));
%            dfdu_mv(:,i) = diag(dfdu_m(:,(i-1)*3+1:3*i));
%        end
        %for i=3:MM_NX
        %    dfdu_pv(:,i) = diag(dfdu_p(:,:,i));
        %    dfdu_mv(:,i) = diag(dfdu_m(:,:,i));
        %end
%    else
%        dfdu_pv(1:MM_NU,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
%        dfdu_mv(1:MM_NU,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
%    end

%    lf(1:MM_NU,3:MM_NX) = 0.5 * (feval(f_f,um(1:MM_NU,3:MM_NX)) + feval(f_f,up(1:MM_NU,3:MM_NX)) - max(abs(dfdu_pv(1:MM_NU,3:MM_NX)), abs(dfdu_mv(1:MM_NU,3:MM_NX))) .* (up(1:MM_NU,3:MM_NX)-um(1:MM_NU,3:MM_NX)));
%    rhs=feval(f_g, uo, cellaverages(xo));
%    ub(1:MM_NU,3:MM_NX-1) = uo(1:MM_NU,3:MM_NX-1) + dt .* ((ones(MM_NU,1)*(-1 ./ dx(3:MM_NX-1))) .* (lf(1:MM_NU,4:MM_NX) - lf(1:MM_NU,3:MM_NX-1)) + rhs(1:MM_NU,3:MM_NX-1));
%    ub = feval(f_boundaries, to, xo, ub);

    % perform 2nd step of Heun scheme
%    dudx(1:MM_NU,3:MM_NX) = (ub(1:MM_NU,3:MM_NX)-ub(1:MM_NU,2:MM_NX-1)) ./ (0.5 * ones(MM_NU,1)*(xo(4:MM_NX+1) - xo(2:MM_NX-1))); % nu wel in physical domain.
%    S(1:MM_NU,3:MM_NX-1)=(sign(dudx(1:MM_NU,3:MM_NX-1)) + sign(dudx(1:MM_NU,4:MM_NX))) .* abs(dudx(1:MM_NU,3:MM_NX-1) .* dudx(1:MM_NU,4:MM_NX)) ./ (abs(dudx(1:MM_NU,3:MM_NX-1)) + abs(dudx(1:MM_NU,4:MM_NX)) + 1.0E-10);
%    S(1:MM_NU,[2,MM_NX])=S(1:MM_NU,[MM_NX-1,3]); %periodic boundaries

%    up(1:MM_NU,3:MM_NX) = ub(1:MM_NU,3:MM_NX) + (0.5 * ones(MM_NU,1)*(xo(3:MM_NX) - xo(4:MM_NX+1))) .* S(1:MM_NU,3:MM_NX);
%    um(1:MM_NU,3:MM_NX) = ub(1:MM_NU,2:MM_NX-1) + (0.5 * ones(MM_NU,1)*(xo(3:MM_NX) - xo(2:MM_NX-1))) .* S(1:MM_NU,2:MM_NX-1);

%    if MM_NU>1
%	dfdu_p(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
%        dfdu_m(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
        %dfdu_p(:,:,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        %dfdu_m(:,:,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
%        for i=3:MM_NX
%            dfdu_pv(:,i) = diag(dfdu_p(:,(i-1)*3+1:3*i));
%            dfdu_mv(:,i) = diag(dfdu_m(:,(i-1)*3+1:3*i));
%        end
        %for i=3:MM_NX
        %    dfdu_pv(:,i) = diag(dfdu_p(:,:,i));
        %    dfdu_mv(:,i) = diag(dfdu_m(:,:,i));
        %end
%    else
%        dfdu_pv(1:MM_NU,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
%        dfdu_mv(1:MM_NU,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
%    end

%    lf(1:MM_NU,3:MM_NX) = 0.5 * (feval(f_f,um(1:MM_NU,3:MM_NX)) + feval(f_f,up(1:MM_NU,3:MM_NX)) - max(abs(dfdu_pv(1:MM_NU,3:MM_NX)), abs(dfdu_mv(1:MM_NU,3:MM_NX))) .* (up(1:MM_NU,3:MM_NX)-um(1:MM_NU,3:MM_NX)));
%    rhs=feval(f_g, ub, cellaverages(xo));
%    un(1:MM_NU,3:MM_NX-1) = ub(1:MM_NU,3:MM_NX-1) + dt .* ((ones(MM_NU,1)*(-1 ./ dx(3:MM_NX-1))) .* (lf(1:MM_NU,4:MM_NX) - lf(1:MM_NU,3:MM_NX-1)) + rhs(1:MM_NU,3:MM_NX-1));
%    un = feval(f_boundaries, to, xo, un);

    % Combine both solutions in Heun-scheme
%    un(1:MM_NU,3:MM_NX-1) = 0.5 * (un(1:MM_NU,3:MM_NX-1) + uo(1:MM_NU,3:MM_NX-1));
%    un = feval(f_boundaries, to, xo, un);


%case 2, % McCormack
%    xa = cellaverages(xo);
%    rhs=feval(f_g, uo, xa);
%    f(1:MM_NU, 2:MM_NX) = feval(f_f, uo(1:MM_NU, 2:MM_NX));
%    fx(1:MM_NU, 2:MM_NX-1) = (f(1:MM_NU,3:MM_NX) - f(1:MM_NU,2:MM_NX-1)) ./ (ones(MM_NU,1) * (xa(3:MM_NX) - xa(2:MM_NX-1)));

%   us(1:MM_NU, 3:MM_NX-1) = uo(1:MM_NU, 3:MM_NX-1) + dt*(rhs(1:MM_NU,3:MM_NX-1) - fx(1:MM_NU,3:MM_NX-1));
%    us = feval(f_boundaries, to, xo, us);

%    rhss=feval(f_g, us, xa);
%    fs(1:MM_NU, 2:MM_NX) = feval(f_f, us(1:MM_NU, 2:MM_NX));
%    fsx(1:MM_NU, 3:MM_NX) = (f(1:MM_NU,3:MM_NX) - f(1:MM_NU,2:MM_NX-1)) ./ (ones(MM_NU,1) * (xa(3:MM_NX) - xa(2:MM_NX-1)));

%    un(1:MM_NU, 3:MM_NX-1) = (uo(1:MM_NU, 3:MM_NX-1) + us(1:MM_NU, 3:MM_NX-1)) ./ 2 + (dt/2)*(rhss(1:MM_NU,3:MM_NX-1) - fsx(1:MM_NU,3:MM_NX-1));
%    un = feval(f_boundaries, to, xo, un);


%case 3, % easy finite differences
%    rhs=feval(f_g, uo, cellaverages(xo));
%    f(1:MM_NU, 2:MM_NX) = feval(f_f, uo(1:MM_NU, 2:MM_NX));
%    xa = cellaverages(xo);
%    fx(1:MM_NU, 3:MM_NX-1) = (f(1:MM_NU,4:MM_NX) - f(1:MM_NU,3:MM_NX-1)) ./ (ones(MM_NU,1) * (xa(4:MM_NX) - xa(3:MM_NX-1)));
%    un(1:MM_NU, 3:MM_NX-1) = uo(1:MM_NU, 3:MM_NX-1) + dt*(rhs(1:MM_NU,3:MM_NX-1) - fx(1:MM_NU,3:MM_NX-1));
%    un = feval(f_boundaries, to, xo, un);
%end
