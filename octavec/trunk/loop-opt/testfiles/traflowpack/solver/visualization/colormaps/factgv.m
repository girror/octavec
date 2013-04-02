function ft = factgv(m)
%FACTGV   Non-linear spectrum
%   FACTGV(M) returns an M-by-3 matrix containing a "fact" colormap.
%   FACTGV, by itself, is the same length as the current colormap.
%
%   FACTGV is intended to display 'factors' around one, like:
%     0.25 is in fact '4 times as small'
%     4    is in fact '4 times as big'
%     Therefore, 0.25 and 4 lie (colorwise) at the same distance to 1.
%
%   FACTGV is the gray-valued version of FACT:
%       * Hue is at a constant level of 1,
%       * Saturation is set to zero,
%       * Value is set to the intended non-linear intensity scaling.
%
%   FACT currently sets the factor-limits internally to:
%     min=0.1, max=5
%
%   See also COLORMAP, FACT, MESHDYNAMICS.

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

min = 0.1;
max = 5;

minf = 1/min;
maxf = max;

hm = round(m/2);                     % half-length of colormap-array
stopv = 0.8;                         % maximum value of hue (determines where the spectrum stops)
mv = stopv*minf/(minf+maxf);         % Value 'in the middle', i.e. at 1
minv = mv/(hm-1);
maxv = (stopv-mv)/(m-hm);
v=0:minv:mv;
v=[v, mv+maxv:maxv:stopv];

v=0.2 + v;                           % lift values, to get range [0.2 ... 1]
h=1 + 0*v;
s=0*v;

ft = hsv2rgb([h' s' v']);
return;