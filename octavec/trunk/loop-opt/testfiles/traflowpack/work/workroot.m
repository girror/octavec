function s = workroot()
%WORKROOT work-dir for MMFVPDES- and TraFlow-experiments
%   WORKROOT returns the full path to the work-dir for MMFVPDES- and TraFlow-experiments.

%   NOTE! This file workroot.m should always be placed in the workdir.

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

loc = which('workroot');
ind = index(loc, 'workroot.m');
s = substr(loc,1,(ind-2));

%[s,name,ext,ver] = fileparts(loc);
