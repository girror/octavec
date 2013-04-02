function v = sameAllLanes(p)
%SAMEALLLANES   parameters that are identical for all roadlanes
%   v = SAMEALLLANES(p) duplicates each row of p up to the nr of lanes TF_l.
%
%   For example:
%     SAMEALLLANES([1;2;3]) creates [1;1;2;2;3;3] in case
%         there are 2 roadlanes
%     SAMEALLLANES([1:10;11:20;21:30]) creates [1:10;1:10;11:20;11:20;21:30;21:30]
%         in case there are 2 roadlanes
%
%   See also: GETIDX, SAMEALLUCS, SAMEALLPOINTS

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

global TF_l TF_m;
sz = size(p);
n = sz(2);
m = sz(1);
v = reshape(repmat(p,1,TF_l)', n,TF_l*m)';
