function w = monitorxin(u, xa, dxi)
% MONITORXIN normalized xi-derivatives monitor
%   w = MONITORXIN(u, xa, dxi) where xa is an 1 x n matrix
%   and u is an m x n matrix (possibly m==1) of solution values
%   at the points in xa, and dxi is the cellsize of the uniform mesh (float),
%   returns an 1 x (n-1) matrix of monitor-values, determined
%   by normalized first-order derivatives in the computational domain
%
%   See also: MONITORBM, MONITORUNIF

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
global MM_alpha;
global MM_alpha_clear;

dudxi = ddxi(u, dxi);
dm = ((max(abs(dudxi')))'+1E-6) * ones(1,length(dudxi));
uxin = (abs(dudxi) ./ dm);

if ~exist('MM_alpha','var') | isempty(MM_alpha)
    optw = 2.5; % approximately, to automaticaly determine proper MM_alpha
    MM_alpha = (optw^2 - 1) / mean(mean((uxin.^2)'));
    fprintf('Using supposed-optimal alpha: %g\n', MM_alpha);
    MM_alpha_clear = 1;
end
sz = size(u);
q=sz(1);

t = q/length(MM_alpha);
MM_alpha = reshape((ones(t, 1)*MM_alpha), 1, q);

w = sqrt(1 + MM_alpha*uxin.^2);