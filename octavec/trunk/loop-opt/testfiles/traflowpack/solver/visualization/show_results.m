function show_results(plotIdx, plotExact)
% SHOW_RESULTS  show the results by MMFVPDES
%   SHOW_RESULTS(plotIdx, pltExact) shows the the latest results produced by MMFVPDES.
%   plotIdx is used to specify which variable(s) to plot
%     -> plotIdx \in 1..MM_NU : plot only one model-variable, with index plotIdx
%     -> plotIdx = -1         : plot all model-variables
%     -> plotIdx = other      : user-defined plot, edit this file.
%   plotExact indicates whether (1) or not (0) to plot also an exact solution at the endtime.
%             A file 'mmfvexact.mat' is required! See MMFVPDES and ERROR_CHECK for details.
%
%   Read the notes on 'mmfvexact.mat' by typing 'help error_check'.
%
%   This function is intended to be modified by the user to his own needs.
%   From here, the numerical and exact solution can be accessed,
%   and the desired visualization routines can be called.
%
%   See also: ERROR_CHECK, PLOT_DATA, VISUALIZATION.

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
global MM_numplotdata MM_plotlabels;

if nargin < 2
    plotExact = 0;
    if nargin < 1
        plotIdx = -1;
    end
end

nt = length(MM_ALLT);

% Retrieve exact solution
exactpath = [workroot,filesep,'mmfvexact.mat'];
if plotExact
    fid = fopen(exactpath);
    if fid==-1
        plotExact=0;
    else
        fclose(fid);
        exact = load(exactpath);
        plotExact=1;
    end
end

% Ignore scaling warnings during drawing
%warning off;


%% Preparing data
rhodata = reshape(MM_ALLU(1,1:1:end,:), nt, MM_NX+1);
%%
% velocity data vary between models:

% VARIANT 1: v is second model variable
%vdata = reshape(MM_ALLU(2,1:1:end,:), nt, MM_NX+1);

% VARIANT 2: m is second mode variable (v = m/r)
%vdata = reshape(MM_ALLU(2,:,:) ./ MM_ALLU(1,:,:), nt, MM_NX+1);

%mdata = reshape(rhodata.*vdata, nt, MM_NX+1);


% Using if's is an easy way to turn on and off certain visualization calls

%% movement of the mesh as x-t diagram with color-indexing.
%% -> figure 8
if(1)
    meshdynamics;
end

%% x-t trajectories
%% -> figure 7
if(0)
    trajectories(MM_ALLT, MM_ALLX, rhodata, vdata,1,18);
end

%% 3D x-t-m surface plot
%% -> figure 6
if(0)
    plot_surf(mdata(:,3:MM_NX-1),'m', 6);
end

%% 3D x-t-v surface plot
%% -> figure 5
if(0)
    plot_surf(vdata(:,3:MM_NX-1),'V (m/s)', 5);
end

%% 3D x-t-\rho surface plot
%% -> figure 4
if(1)
    plot_surf(rhodata(:,3:MM_NX-1),'r (veh./m)', 4);
end

%% movement of the mesh as x-t diagram.
%% -> figure 3
if(1)
    plot_data('meshmov');
end

%% mesh-mapping x(\xi) at the endtime.
%% -> figure 2
if(1)
    plot_data('meshmap_t', MM_ALLT(end));
end

%% u-x plot of some solution variable(s) at endtime.
%% -> figure 1
switch plotIdx
case -1
    for i=1:MM_NU
        MM_plotlabels{i} = ['u_', num2str(i)];
    end
    %% Manually modify to your own needs
    % MM_plotlabels = {'r', 'V', 'm'};
    MM_plotlabels = {'\rho', 'm_1', 'm_2', 'B_2', 'e', 'v_1'};
    
    MM_numplotdata = MM_ALLU;
    if plotExact
        exactdata = exact.un;
    end

case num2cell(1:MM_NU)
    MM_plotlabels{1} = ['u_', num2str(plotIdx)];
    MM_numplotdata = reshape(MM_ALLU(plotIdx,:,:),nt,MM_NX+1);
    if plotExact
        exactdata = squeeze(exact.un(plotIdx,:));
    end
case -2 % add the velocity as the third variable (1=rho, 2=m, for example in Hoogendoorns conservative 2PDE-model)
    MM_plotlabels = {'r', 'm', 'V'};

    MM_numplotdata = MM_ALLU;
    MM_numplotdata(end+1,:,:) = squeeze(MM_ALLU(2,:,:) ./ MM_ALLU(1,:,:));
    if plotExact
        exactdata = exact.un;
        exactdata(end+1,:,:) = exact.un(2,:) ./ exact.un(1,:);
    end
case -3 % MHD example: all variables + v_1
    MM_plotlabels = {'\rho', 'm_1', 'm_2', 'B_2', 'e', 'v_1'};
    MM_numplotdata = MM_ALLU;
    MM_numplotdata(end+1,:,:) = squeeze(MM_ALLU(2,:,:) ./ MM_ALLU(1,:,:));
    if plotExact
        exactdata = exact.un;
        exactdata(end+1,:,:) = exact.un(2,:) ./ exact.un(1,:);
    end
case 4 % velocity
    MM_plotlabels = {'V'};

    MM_numplotdata = reshape(MM_ALLU(2,:,:) ./ MM_ALLU(1,:,:),nt,MM_NX+1);
    if plotExact
        exactdata = exact.un(2,:) ./ exact.un(1,:);
    end
case 5 % pressure
    global gamma;
    MM_plotlabels = {'p'};

    MM_numplotdata = reshape((gamma-1) * (MM_ALLU(3,:,:) - (MM_ALLU(2,:,:).^2 ./ (MM_ALLU(1,:,:) * 2))),nt,MM_NX+1);
    if plotExact
        exactdata = (gamma-1) * (exact.un(3,:) - (exact.un(2,:).^2 ./ (exact.un(1,:) * 2)));
    end
case 6 % internal energy
    MM_plotlabels = {'E_i'};

    MM_numplotdata = reshape((MM_ALLU(3,:,:) - (MM_ALLU(2,:,:).^2 ./ (MM_ALLU(1,:,:) * 2))) ./ MM_ALLU(1,:,:),nt,MM_NX+1);
    if plotExact
        exactdata = (exact.un(3,:) - (exact.un(2,:).^2 ./ (exact.un(1,:) * 2))) ./ exact.un(1,:);
    end
end

% udata is global and therefore available for plotdata; exactdata is not global and thus passed as an argument.
if plotExact
    plot_data('sol_t', MM_ALLT(nt), exact.tn, exact.xn, exactdata);
else
    plot_data('sol_t', MM_ALLT(nt));
end

warning on;
