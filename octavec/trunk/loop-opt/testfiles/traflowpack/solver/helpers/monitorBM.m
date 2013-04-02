function w = monitorBM(u, xa, dxi)
% MONITORBM Becket-Mackenzie monitor function
%   w = MONITORBM(u, xa, dxi) where xa is an 1 x n matrix
%   and u is an m x n matrix (possibly m==1) of solution values
%   at the points in xa, and dxi is the cellsize of the uniform mesh (float),
%   returns an 1 x (n-1) matrix of monitor-values defined by
%   the Becket-Mackenzie monitor.
%
%   See also: MONITORUNIF, MONITORXIN

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

dudxi = ddxi(u, dxi);

% alpha(t) still for all variables:
alph = sum((sqrt(abs(dudxi)))')' * dxi;

% |u_xi|^(1/2) for all variables and all meshpoints:
norm = sqrt(abs(dudxi));

sz = size(norm);
n = sz(2);

% tmp=w, but still separate for each variable
tmp = alph * ones(1, n) + norm;

if sz(1) > 1 % u contains multiple variables
    nz = numZero(alph);
    if nz ~= length(alph)
        alph_avg = sum(alph) / (length(alph) - nz);
        norm_fact = alph_avg ./ nonZero(alph, 1);
        tmp_norm = (norm_fact * ones(1,n)) .* tmp;
    else
        tmp_norm = tmp;
    end

    % for example: sum all monitorvalues (for all variables, at each point):
    w = sum(tmp_norm);
    
    % or adapt monitor to only one component:
    %w=tmp_norm(4,:);
else
    w = tmp;
end

if min(w)==0
    w = w+1e-5; % to prevent division by zero, later on.
end

