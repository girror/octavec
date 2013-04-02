function [MM_a, MM_b, f_init, f_monitor, f_f, f_dfdu, f_g, f_boundaries] = settingsST()
% SETTINGSST    Settingsfile for 'ShockTube example'

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

MM_a = 0;
MM_b = 1;
f_init = 'initST';
f_monitor = 'monitorBM';
f_f = 'fEuler';
f_dfdu = 'dfduEuler';
f_g = 'gEuler';
f_boundaries = 'neumann_sol';
