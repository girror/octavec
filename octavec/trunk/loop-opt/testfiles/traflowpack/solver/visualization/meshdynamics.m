function meshdynamics(varargin)
% MESHDYNAMICS  the movement of the mesh
%   MESHDYNAMICS(sampleD, figNo) plots the movement of every sampleD'th
%   meshpoint om figure figNo. Both arguments are optional
%   and default to (1, 8)
%   a moving-mesh solution should be present in the global workspace
%   (MM_ALLT, MM_ALLX)

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

global MM_ALLX MM_ALLT;
global MM_NX;

if nargin>0
    sampleD = varargin{1};
else
    sampleD = 1;
end
if nargin > 1
    figNo = varargin{2};
else
    figNo = 8;
end

ALLX=MM_ALLX;
ALLT=MM_ALLT;
st = size(ALLT);
if st(1)==1
    ALLT=ALLT';
    nt = st(2);
else
    nt = st(1);
end

sx = size(ALLX);
if sx(1) ~= nt
    ALLX = ALLX';
    nx = sx(1);
else
    nx = sx(2);
end

DX = cellsizes(ALLX);       % the real meshcell-sizes
xmin = min(min(ALLX));
xmax = max(max(ALLX));
dx = (xmax-xmin) / (nx-1);  % the original (uniform) meshcell-sizes

DX = DX / dx;               % DX now contains the factor w.r.t. the unif. mesh

XA = cellaverages(ALLX);    % the mid-cell-points

ALLTt = ALLT*ones(1,nx-1);  % time-values at entire domain.
tmin = min(ALLT);
tmax = max(ALLT);

h = figure(8);
set(h,'Name',['Mesh Dynamics']);

surf(XA', ALLTt', DX','EdgeColor','interp','FaceColor','interp');%contour3(Z,30);
view([0, 0, 1]);

maxz = max(max(DX));
maxz = ones(nt,1)*(maxz+1); % to draw black gridlines above the surface

hold on;
for xi = 1:sampleD:nx
  plot3(ALLX(:,xi),ALLT,maxz, 'k-', 'HitTest','off');
end
xlabel('x');
ylabel('t');
set(gca, 'XLimMode','manual');
set(gca, 'XLim',[MM_ALLX(1,3),MM_ALLX(1,MM_NX)]);
set(gca, 'YLimMode','manual');
set(gca, 'YLim',[tmin,tmax]);
titleDS;

colorbar;
hold off;
colormap(fact);