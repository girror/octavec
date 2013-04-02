function plot_surf(zdata, zlbl,figno)
%PLOT_SURF  Plot MMFVPDES data in a 3D view
%   PLOT_SURF creates a 3D view of some zdata in the x-t plane.
%   The z-labels should be specified as well as the figure number.

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

global MM_ALLX MM_ALLT MM_NX;

nt = length(MM_ALLT);
xa = cellaverages(MM_ALLX);

fh = figure(figno);
set(fh,'Name',['3D plot of ',zlbl, ' at the x-t domain']);

surf(xa(1:1:end,3:MM_NX-1), MM_ALLT, zdata);%,'EdgeColor','interp');
colormap(redblue);

xlabel('x (m)');
ylabel('t (s)');
zlabel(zlbl);

view([15,60])

zmax = max(max(zdata));
zmin = min(min(zdata));
axis([MM_ALLX(nt,3) MM_ALLX(nt,MM_NX),MM_ALLT(1), MM_ALLT(nt), min(0, zmin), zmax]);
titleDS;
%% For gray-valued flat faces
%sh=get(gca,'Children');set(sh,'FaceColor',[.5 .5 .5]);
