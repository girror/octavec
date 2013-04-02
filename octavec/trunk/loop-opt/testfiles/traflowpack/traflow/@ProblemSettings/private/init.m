function p = init(p)
%INIT   Initializes ProblemSettings
%   p = INIT(p) initializes ProblemSettings-object p, using
%   the settings from the settingsfile.

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

[a, b, bounds, ucs, lanes, f_init] = feval(p.f_psettings);
p.domain = [a, b];
p.bounds = bounds;
p.ucs = ucs;
p.lanes = lanes;
p.f_init = f_init;
