function u = initST(x)
% INITST    initfile for 'ShockTube example'

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

% Besides setting the initial solution, it is also possible
% to define some other needed parameters:
global gamma;
gamma = 1.4;

% Produces a step-like function with shock at x=0.5
il = find(x < .5);
u(1:3,il) = [1;0;2.5] * ones(1,length(il));

ir = find(x >= .5);
u(1:3,ir) = [0.125;0;0.25] * ones(1,length(ir));
