function d2wdx2 = mm_ddx2(w, xa)
% MM_DDX2 centered second-order spatial derivative on non_uniform mesh.
%   d2wdx2 = DDX(w, xa) where xa is an 1 x n matrix
%   and w is an m x n matrix (possibly m==1) of solution values
%   at the points in xa,
%   returns an m x n matrix of second-order derivatives d2w/dx2
%   computed with a central-difference formula, and interpolated
%   on the non-uniform mesh.
%   Only n-2 derivative values can, by definition, be computed:
%   d2wdx2(1)=d2wdx2(2);d2wdx2(n)=d2wdx2(n-1);
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
n = length(xa);
dx = (xa(n)-xa(1))/(n-1);
xu = xa(1):dx:xa(n);
wu = interp1(xa', w', xu', 'cubic');
d2wdx2u(2:n-1) = (wu(1:n-2)-2*wu(2:n-1) + wu(3:n))/(dx^2);
d2wdx2u([1,n]) = d2wdx2u([2,n-1]);

d2wdx2 = interp1(xu',d2wdx2u',xa')';