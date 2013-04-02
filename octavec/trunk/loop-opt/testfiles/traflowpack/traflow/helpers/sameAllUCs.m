function v = sameAllUCs(p)
%SAMEALLUCS   parameters that are identical for all userclasses
%   v = SAMEALLUCS(p) duplicates the entire matrix p up to the nr of userclasses TF_m
%   and stacks the duplicate(s) on top of each other.
%
%   For example:
%     SAMEALLUCS([1;2;3]) creates [1;2;3;1;2;3] in case
%         there are 2 userclasses
%     SAMEALLUCS([1:10;11:20;21:30]) creates [1:10;11:20;21:30;1:10;11:20;21:30]
%
%   See also: GETIDX, SAMEALLLANES, SAMEALLPOINTS, SUMUCS

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

global TF_m;
v = repmat(p,TF_m,1);
