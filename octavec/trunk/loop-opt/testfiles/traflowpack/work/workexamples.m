% TraFlowPACK example user-files in work-directory
%   TraFlowPACK initially comes with some example user-files.
%   Some details are below, including example commandline calls to TraFlow.
%
%
%   kerner.m      (r, V) model by Kerner, 1 lane, 1 userclass
%                 well-known for various results in case of initial small
%                 perturbation.
%                 Set the global Rhobase and drho0 (see kerner1_init.)
%                 to test this initial perturbation.
%                 Experiment with various perturbations and other initial distributions
%                 for many interestings results.
%       » global rhobase drho0; rhobase=0.038; drho0=0.001;
%       » traflow('sim','kerner','kerner1','monitorBM',100,0,500,'cflC',0.1,'storeInterval',10)
%
%
%   settingsST.m  The Euler-ShockTube problem: a 1D bar with gas. High pressure
%                 in left half, low in right half, at t=0 the 'gate' is opened
%                 and a shockwave moves to the right.
%                 This example is not traffic flow related, directly solved by MMFVPDES.
%                 Make sure to set vdata to variant 2 in show_results.m
%       » mmfvpdes('plot','settingsST',100,0.0,0.2,3,1e-6,0,0.5,1,.004)
%
%
%   settings51.m  The Burgers' equation: a 1D sinus-wave that steepens up into a shock
%                 Make sure to turn of vdata and mdata in show_results.m, as well as
%                 all v- and m- related plot (change 'if(1)' into 'if(0)' )
%
%       » mmfvpdes('plot','settings51',100,0.0,2,3,1e-6,0,0.5,1,.04)
%
%
%   See also: WORKROOT

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
