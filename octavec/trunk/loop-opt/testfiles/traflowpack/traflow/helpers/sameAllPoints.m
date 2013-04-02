function v = sameAllPoints(p, varargin)
%SAMEALLPOINTS   parameters that are identical at all x-points
%   v = SAMEALLPOINTS(p) duplicates each column of p up to the nr of points TF_n.
%   v = SAMEALLPOINTS(p, n) duplicates each column of p up to the user-defined nr of points n.
%
%   For example:
%     SAMEALLPOINTS([1;2;3]) creates [1,1;2,2;3,3] in case
%         there are 2 x-points
%
%   See also: GETIDX, SAMEALLLANES, SAMEALLUCS

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

global TF_n;
if nargin>1
  n = varargin{1};
else
  n = TF_n;
end

v = repmat(p,1,n);
