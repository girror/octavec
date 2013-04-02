function w = monitorUnif(u, xa, dxi)
% MONITORUNIF constant monitor function
%   w = MONITORUNIF(u, xa, dxi) where xa is an 1 x n matrix
%   and u is an m x n matrix (possibly m==1) of solution values
%   at the points in xa, and dxi is the cellsize of the uniform mesh (float),
%   returns an 1 x n matrix of monitor-values, all equal to 1,
%   to produce a uniform (non-moving) mesh.
%
%   See also: MONITORBM, MONITORXIN

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
w = 1 + 0*xa;
return;
