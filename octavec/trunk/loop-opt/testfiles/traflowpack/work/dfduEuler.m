function dfdu = dfduEuler(u)
% DFDUEULER    Definition of df/du for 'ShockTube/Euler example'

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

n = size(u, 2); % number of points

for i = 1:n
  dfdu(:,(i-1)*3+1:3*i) = jac(u(:,i)); % jacobian at one specific point.
end


%%%%
%function J=jac(u)
%global gamma;

%v = u(2) / u(1);
%p = pEuler(u);
%J = [ 0, ...
%      1, ...
%      0 ...
%    ; 0.5 * (gamma-3) * v^2, ...
%      (3-gamma) * v, ...
%      gamma-1 ...
%    ; 0.5 * (gamma-1) * v^3 - v * (u(3)+p) / u(1), ...
%      (u(3)+p) / u(1) - (gamma-1) * v^2, ...
%      gamma * v ...
%    ];
