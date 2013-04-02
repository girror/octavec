function u = neumann_sol(t, x, u)
% NEUMANN_SOL Neumann boundary conditions
%   u = NEUMANN_SOL(t, x, u) where x is an 1 x (MM_NX+2) matrix
%   and u is an MM_NU x (MM_NX-1) matrix (possibly MM_NU==1) of solution values
%   at the cell-middles of the points in x, and t is the current time (float),
%   returns an MM_NU x (MM_NX+1) matrix of the same solution values, but now with
%   boundary values added to it:
%   u(1:MM_NU,[1, 2, MM_NX, MM_NX+1]) = u(1:MM_NU,[4, 3, MM_NX-1, MM_NX-2]);
%   i.e.: a Neumann-boundary with zero slope.
%
%   See also: PERIODIC_SOL, PERIODIC_ANTISOL

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
global MM_NX MM_NU;

u(1:MM_NU,[1, 2, MM_NX, MM_NX+1]) = u(1:MM_NU,[4, 3, MM_NX-1, MM_NX-2]);
