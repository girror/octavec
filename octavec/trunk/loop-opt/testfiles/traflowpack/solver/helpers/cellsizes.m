function dx = cellsizes(x)
% CELLSIZES cell-sizes
%   dx = CELLSIZES(x) where x is an m x n matrix (possibly m==1)
%   returns an m x (n-1) matrix of cellsizes between each two columns
%   dx(i,j) = x(i,j+1) - x(i,j);
%
%   See also: CELLAVERAGES

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

n = size(x,2);
leftpoints = [1:n-1];
rightpoints = [2:n];
dx = x(:,rightpoints) - x(:,leftpoints);
