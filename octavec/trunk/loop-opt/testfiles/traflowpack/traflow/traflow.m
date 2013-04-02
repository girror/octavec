function traflow(action, f_msettings, f_psettings, f_monitor, n, Tstart, Tend, varargin)
%TRAFLOW  Run a macroscopic (currently MultiClass) traffic flow simulation
%   TRAFLOW(action, f_msettings, f_psettings, f_monitor, n, Tstart, Tend, varargin)
%   Arguments:
%     action      - one of:
%       'info': prints info on the specified problem, model-variables, PDE solver
%       'sim' : run a simulation with the specified settings
%     f_msettings - file containing info on the traffic-model, which variables etc.
%     f_psettings - file containing info on the problem to be solved, road-dimensions etc.
%     f_monitor   - function name of monitor to be used in moving-mesh algorithm. (monitorBM is a good choice)
%     n           - the number of gridcells in the domain.
%     Tstart      - start-time for the simulation
%     Tend        - end-time for the simulation
%     the rest of the arguments should come in name-value pairs, where name comes from the following (defaults are in [..]):
%       > mm_maxit      : The mesh is moved until mm_maxit iterations were done OR:                        [   3]
%       > mm_tol        : \|xnew-xold\| <= mm_tol*(XRIGHT-XLEFT)                                           [1e-6]
%       > cflC          : specifies how stringent the adaptive time-step should be set to the CFL-limit    [ 0.5]
%                         (usually below 0.5 suffices)
%                         Whenever clfC < 0, no adaptive timestep is used: \Delta t = abs(cflC)
%       > solver        : specifies wich solver to use, see 'help mmfvpdes' for more info                  [   1]
%       > storeInterval : specifies the interval (in simulation-seconds) that the solution should be stored[   5]
%       > plotVar       : Specifies which variable to plot (see MMFVPDES documentation)                    [  -1]
%       > saveData      : Specifies whether (1) or not (0) to save the solution data in a file             [   0]
%       > errorCheck    : Specifies whether (1) or not (0) to compute some errordiagnostics                [   0]
%                         A file 'mmfvexact.mat' is required! See MMFVPDES and ERROR_CHECK for details.
%
%     Examples:
%       » traflow('sim', 'mcsl_conservative','ringroad1','monitorBM', 50, 16*3600, 20*3600, 'cflSigma', 0.5);
%       » traflow('sim', 'hd_sl','hd_test1','monitorxin',100,0,100,'storeInterval',5);
%
%   See also: MMFVPDES

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

% Symbol- and naming conventions:
% w   : Model variables are placed in w,
%       e.g. w = [r, v, theta];
% q   : Number of model variables, q = length(w);
% NOTE: MMFVPDES still works on u (instead of w) and stores results in MM_ALLU
%
% u   : Userclass (object)
% U   : set of UserClasses
% m   : number of UserClasses, m = dim(U);
%
% j   : index of roadway-lane
% J   : set of roadway-lanes (indices)
% l   : number of roadway-lanes, l = dim(J);
% NOTE: roadlanes have not yet been used, and index j is sometimes used in spatial (x) domain.
%
% a,b : left- and right bound of spatial domain
% x   : spatial coordinate vector
% n   : number of gridpoints, n+1 = length(x);
%       Note!: values W are evaluated between gridpoints (n discrete W-values)
%
% t      : time-vector
% Tstart : start-time simulation
% Tend   : end-time simulation
% K      : Number of timesteps during simulation, K = length(t);
% NOTE   : global variables are prefixed with 'TF_'
%
% dim(w) = (q·m·l) × K × n

% t \in [t^{(0)},t^{(1)}], \Delta t may be variable
% x \in [a,b], (initial) \Delta x = (b-a)/(n-1)

global PROGRAM_NAME PROGRAM_VERSION PROGRAM_VERSION_ADD PROGRAM_AUTHOR;

PROGRAM_NAME        = 'TraFlow';

%%%%% version info:
%   % 0.1 - input model settings
%   % 0.2 - input problem settings
%   %    .1 domain
%   %    .2 userclasses
%   %    .3 initial solutions
%   %    .4 parameters
%   % 0.3 - PDE solver
%   %    .1 settings
%   %    .2 algorithm
%   % 0.4 - Advancements
%   %    .1 MultiLane
%   %    .2 auto-redim
%   % 0.5 - output functions
%   %    .1 'Real World' plot
%   %    .2 scientific plots, density etc
%   %
%   % 1.0 - first user-friendly TraFlow pack
%%%%%
PROGRAM_VERSION     = '1.x';
PROGRAM_VERSION_ADD = '';
PROGRAM_AUTHOR      = 'Arthur van Dam';

global TF_q TF_m TF_l TF_n;
%%
% First check commandline-arguments
%%
if nargin < 7
    warn('Insufficient arguments!');
    help traflow
    return;
end

% parse optional args (varargin)
[reg, prop] = parseparams(varargin);

% process property-value pairs
pl = length(prop)-1;
for i = 1:2:pl
    if ischar(prop{i+1})
        del = '''';
    else
        del='';
    end
    eval([prop{i}, '=', del, num2str(prop{i+1}), ';']);
end

fprintf('\n Processing additional parameters...\n');
% some required vars, and their default values
reqVars = struct('mm_maxit', 3, 'mm_tol', 1E-6, 'cflC', 0.5, 'solver', 1, 'storeInterval', 5, 'plotIdx', -1, 'saveData', 0, 'errorCheck', 0);

% for unspecified variables, set the default:
names = fieldnames(reqVars);
nv = length(names);
for i = 1:nv
    if ~exist(names{i}, 'var')  | isempty(eval(names{i}))
        eval([names{i},'=reqVars.',names{i},';']);
        fprintf('  » Using default %s: %s\n', names{i}, num2str(eval(['reqVars.',names{i}])));
    else
        fprintf('  » Using specified %s: %s\n', names{i}, num2str(eval(names{i})));
    end
end

% Initialize settings-objects
[msettings, psettings] = init(n, f_msettings, f_psettings);

% create PDE settings based upon these settings-objects
[settingsfn, settingsfile] = createPDESSettings(msettings, psettings, f_monitor);

switch action
case 'info'
    printInfo(msettings, psettings);
case 'sim'
    runSimulation(n, Tstart, Tend, settingsfn, mm_maxit, mm_tol, cflC, solver, storeInterval, plotIdx, saveData, errorCheck);
end

%% clean up auto-generated pde-settings file %%
delete(settingsfile);


%%%%
function [msettings, psettings] = init(nw, f_msettings, f_psettings)
global TF_q TF_m TF_l TF_n;

msettings = ModelSettings('Global Model Settings', f_msettings);
psettings = ProblemSettings('Current Problem Settings', f_psettings);

TF_q = get(msettings, 'nMVars');
TF_m = get(psettings, 'nUCs');
TF_l = get(psettings, 'nLanes');
TF_n = nw;

globaliseUCs(get(psettings, 'UCs'));


%%%%
function [settingsfn, fullpath] = createPDESSettings(msettings, psettings, f_monitor)
settingsfn = 'traflow_pdes';
fullpath = [workroot,filesep,settingsfn, '.m'];
fid = fopen(fullpath, 'w');

fprintf(fid, 'function [XLEFT, XRIGHT, f_init, f_monitor, f_f, f_dfdu, f_g, f_boundaries] = %s()\n', settingsfn);
domain = get(psettings, 'Domain');
fprintf(fid, 'XLEFT = %g;\n', domain(1));
fprintf(fid, 'XRIGHT = %g;\n', domain(2));
fprintf(fid, 'f_init = ''%s'';\n', get(psettings, 'fInit'));
fprintf(fid, 'f_monitor = ''%s'';\n', f_monitor);
fprintf(fid, 'f_f = ''%s'';\n', get(msettings, 'f_f'));
fprintf(fid, 'f_dfdu = ''%s'';\n', get(msettings, 'f_dfdu'));
fprintf(fid, 'f_g = ''%s'';\n', get(msettings, 'f_g'));
switch get(psettings, 'bounds')
case 'periodic'
    f_bounds = 'periodic_sol';
case 'neumann'
    f_bounds = 'neumann_sol';
%case 'fxfx'
%    f_bounds = 'dirichlet_bounds';
otherwise
  f_bounds = 'novalidboundsspecified';
end
fprintf(fid, 'f_boundaries = ''%s'';\n', f_bounds);
fclose(fid);


%%%%
function runSimulation(n, Tstart, Tend, settingsfn, mm_maxit, mm_tol, cflC, solver, storeInterval, plotIdx, saveData, errorCheck)
global TF_n;

mm_nsmooth = 0;

varargs = {};
if saveData
    varargs = {varargs{:};'save'};
end
if errorCheck
    varargs = {varargs{:};'errorcheck'};
end

mmfvpdes('plot', settingsfn, TF_n+2, Tstart, Tend, mm_maxit, mm_tol, mm_nsmooth, cflC, solver, storeInterval, plotIdx, varargs{:});


%%%%
function printInfo(msettings, psettings)
fprintf('\n');
fprintf(sindent([repeat('¤', 61), '\n'], 1));
fprintf(strrep(fullProgramInfo, '\\', '\\\\'));
fprintf(' --\n');
display(msettings);
fprintf(' --\n');
display(psettings);


%%%%
function s = fullProgramInfo()
global PROGRAM_NAME PROGRAM_VERSION PROGRAM_VERSION_ADD PROGRAM_AUTHOR;
%s1= sprintf('        ___        _   ___\n  _____|   \\_  ___L.| /   \\      __\n [_   _| º / \\|  __|||  O  | __ / /\n   | | |_|/ A \\ |_] |_\\___/ v  v /\n   |_|   /_/-\\_\\| |____|   \\_/\\_/\n\n');
%s1 = sprintf('        ___        _   ___            ___             ___    \n  _____|   \\_  ___|,| /   \\      __ _/[]L\\__        _/[]L\\__                 \n [_   _| º / \\|  __|||  O  | __ / /(_,.__,._)  ___ (_,.__,._)\n   | | |_|/ A \\ |_] |_\\___/ v  v /---`''--`''--_/[]L\\__`''--`''---\n   |_|   /_/-\\_\\| |____|   \\_/\\_/           (_,.__,._)\n                                           ---`''--`''--\n\n');
s1 = sprintf('                   _                  ___             ___\n       |¯¯¯\\_  ___|,| /¯¯¯\\      __ _/[]L\\__        _/[]L\\__\n [¯¯¯¯¯| º / \\|  __|||  O  | __ / /(_,.__,._)  ___ (_,.__,._)\n  ¯| |¯|_|/ A \\ |_] |_\\___/ v  v /---`''--`''--_/[]L\\__`''--`''---\n   |_|   /_/-\\_\\| |    |   \\_/\\_/           (_,.__,._)\n                   ¯¯¯¯                    ---`''--`''--\n\n');
s2 = sprintf(' %s, v%s %s by %s\n', PROGRAM_NAME, PROGRAM_VERSION, PROGRAM_VERSION_ADD, PROGRAM_AUTHOR);
s=[s1, s2];
