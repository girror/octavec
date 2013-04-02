function rb = redblue(m)
%REDBLUE   Spectrum from intense red to soft blue
%   REDBLUE(M) returns an M-by-3 matrix containing a "redblue" colormap.
%   REDBLUE, by itself, is the same length as the current colormap.
%
%   See also COLORMAP, MESHCONTOUR.

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

if nargin < 1, m = size(get(gcf,'colormap'),1); end

startcolor = [0.5 .5 1];
endcolor = [1 0 0];
r = lin_f(1:m, startcolor(1), endcolor(1));
g = lin_f(1:m, startcolor(2), endcolor(2));
b = lin_f(1:m, startcolor(3), endcolor(3));

rb = [r' g' b'];