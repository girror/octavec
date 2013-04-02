function ft = fact(m)
%FACT   Non-linear spectrum
%   FACT(M) returns an M-by-3 matrix containing a "fact" colormap.
%   FACT, by itself, is the same length as the current colormap.
%
%   FACT is intended to display 'factors' around one, like:
%     0.25 is in fact '4 times as small'
%     4    is in fact '4 times as big'
%     Therefore, 0.25 and 4 lie (colorwise) at the same distance to 1.
%
%   FACT also dims the colors for high factors, so the small factors
%     draw far more attention.
%
%   FACT currently sets the factor-limits internally to:
%     min=0.1, max=5
%
%   See also COLORMAP, FACTGV, MESHDYNAMICS.

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

startcolor = [.5 1 .5];
endcolor = [1 0 0];

min = 0.1;
max = 5;

minf = 1/min;
maxf = max;

hm = round(m/2);                     % half-length of colormap-array
stoph = 0.8;                         % maximum value of hue (determines where the spectrum stops)
mv = stoph*minf/(minf+maxf);         % hue value 'in the middle', i.e. at 1
minh = mv/(hm-1);
maxh = (stoph-mv)/(m-hm);
h=0:minh:mv;
h=[h, mv+maxh:maxh:stoph];

a=0;b=1;
c=0.9;d=1;
s=b:-(b-a)/(m-1):a;                  % For diminishing the color (saturation) for the higher factors)
v=d:-(d-c)/(m-1):c;                  % For making colors for high factors less 'bright' (i.e. do NOT end with white)

ft = hsv2rgb([h' s' v']);
return;