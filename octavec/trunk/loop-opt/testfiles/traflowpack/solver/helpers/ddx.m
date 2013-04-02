function dudx = ddx(u, xa)
% DDX centered first-order spatial derivative
%   dudx = DDX(u, xa) where xa is an 1 x n matrix
%   and u is an m x n matrix (possibly m==1) of solution values
%   at the points in xa,
%   returns an m x (n-1) matrix of first-order derivatives du/dx
%   computed with a central-difference formula.
%   Only n-2 derivative values can, by definition, be computed:
%   the n'th element does not exist, and the first element is set to 0.
%   So only elements 2:n-1 are to be used.
%
%   See also: DDXI, MM_DDX2

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

sz = size(u);
n = sz(2); % array-length

dudx(:,2:n-1) = (u(:,3:n) - u(:,1:n-2)) ./ (ones(sz(1),1) * (xa(:,3:n) - xa(:,1:n-2)));
