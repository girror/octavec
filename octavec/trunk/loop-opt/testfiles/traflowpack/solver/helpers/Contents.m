% MMFVPDES help-functions
%   A wide variety of helper-functions
%
%   Finite Differences  
%     cellaverages     - The middles of mesh-cells
%     cellsizes        - The sizes of mesh-cells
%     ddx              - Central-spaced first order derivative
%     ddxi             - Central-spaced first order derivative in xi-space
%     mm_ddx2          - Central spaced second order derivative (interpolated on non-uniform mesh)
%
%   Monitor functions
%     monitorBM        - Beckett-Mackenzie monitor
%     monitorUnif      - monitor fo uniform mesh
%     monitorxin       - normalized x-derivatives monitor
%
%   Boundary conditions
%     neumann_sol      - neumann-boundary, dudx=0
%     periodic_antisol - periodical boundaries, negated solutions, u(end) = -u(start)
%     periodic_sol     - periodical boundaries, u(end) = u(start)
%
%   I/O functions
%     list_data        - list the stored datafiles
%     load_data        - reload a stored solution
%     save_data        - store the current solution
%
%   Error checking
%     save_exact       - save 'pseudoexact' solution at current Tend
%     error_check      - compute some error-diagnostics
%
%   Various
%     lin_f            - interpolate a linear function on range of points
%     nonZero          - replace zeros by a dummy
%     numZero          - count the zeros
%     warn             - display warning message, without system halt.

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
