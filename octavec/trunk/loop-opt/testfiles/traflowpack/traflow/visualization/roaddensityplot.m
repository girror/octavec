function [ym, zm] = roaddensityplot(x, r, z, L)
%ROADDENSITYPLOT    'real-world view' of traffic densities
%   [ym,zm] = ROADDENSITYPLOT(x, r, z, L) takes as input:
%       x, a 1 x n vector with the discrete x-points,
%       r, a (z*L x n) matrix, with the density values at those points,
%       z, the number of userclasses
%       L, the number of roadwaylanes
%   and returns the y and z coordinate of some marker point, which can be used
%   for drawing imaginary cars in the same window at sensible locations.
%
%   Multiple lanes are possible. multiple classes are drawn in separate subplots.
%
%   See also: DENSITYANIMATION

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

global floor_pos ceil_pos road_width grass_sidemargin;
ym = (road_width + 2*grass_sidemargin)/2;
zm = floor_pos + (ceil_pos-floor_pos)/25;

n = length(x);
figno = 14;

%%
% Set up road-length en width and scaling factors
%%
init_geometry([x(1), x(n)], r, L, z, figno);

%%
% Draw each userclass in a separate subplot
%%
for i=1:z
  plotgrass([x(1),x(n)], z, figno, i);
  plotroad([x(1),x(n)], L, z, figno, i);
  plotdensity(x, r((i-1)*L + [1:L],:), L, z, figno, i);
end


%%%%
function plotgrass(xlims, z, figno, subno)
global grass_width;
global grass_color;
global floor_pos ceil_pos;

a = xlims(1);
b = xlims(2);
h = figure(figno);
subplot(z, 1, subno);

grass_x = [a, b, b, a];
grass_y = [0, 0, grass_width, grass_width];
grass_z = 0*grass_x + floor_pos;
patch(grass_x, grass_y, grass_z, grass_color);



%%%%
function plotroad(xlims, L, z, figno, subno)
global lane_width lane_sidemargin road_width road_sidemargin grass_width grass_sidemargin;
global road_color line_color;
global floor_pos ceil_pos;

a = xlims(1);
b = xlims(2);
h = figure(figno);
subplot(z, 1, subno);

%%
% Draw the road
%%
road_x = [a, b, b, a];
road_y = [grass_sidemargin, grass_sidemargin, road_width+grass_sidemargin, road_width+grass_sidemargin];
road_z = 0 * road_x + floor_pos + (ceil_pos-floor_pos)/100; % quick 'n dirty correction
patch(road_x, road_y, road_z, road_color);

%%
% Place side-lines and lane-separating-lines
%%
line_x = [a,b];
ypos = grass_sidemargin+road_sidemargin;
line_y = [ypos, ypos];
line_z = 0 * line_x + floor_pos + (ceil_pos-floor_pos)/50;
lh = line(line_x, line_y, line_z);
set(lh, 'Color', line_color);
set(lh, 'LineStyle', '-');
for l=1:L-1
  line_y = line_y + lane_width;
  lh = line(line_x, line_y, line_z);
  set(lh, 'Color', line_color);
  set(lh, 'LineStyle', '--');
end
ypos = grass_width - grass_sidemargin - road_sidemargin;
line_y = [ypos, ypos];
lh = line(line_x, line_y, line_z);
set(lh, 'Color', line_color);
set(lh, 'LineStyle', '-');


%%%%
function plotdensity(x, r, L, z, figno, subno)
global grass_sidemargin road_width road_sidemargin lane_width lane_sidemargin;

h = figure(figno);
xh = subplot(z, 1, subno);

lane_space = lane_width - 2*lane_sidemargin;

ypos = grass_sidemargin + road_sidemargin + lane_sidemargin;
ydata = [ypos; ypos+lane_space];

hold on;

%%
% Draw the data at the various roadway lanes next to each other
%%
for l = 1:L
    rdata = [1;1] * r(l,:);
    sh = surf(x,ydata,rdata);
    set(sh,'FaceColor','interp');
    colormap(redblue);
    ydata = ydata + lane_width;
end
view(3);


%%%%
function init_geometry(xlims, r, L, z, figno)
global lane_width lane_sidemargin road_width road_sidemargin grass_width grass_sidemargin;
global road_color line_color grass_color sky_color;
global floor_pos ceil_pos;

%%
% Compute scaling-factors and set colors for road, lines, grass and sky
%%

a = xlims(1);
b = xlims(2);

lane_width = (b-a)/25;
lane_sidemargin = lane_width/5;

road_sidemargin = lane_width/10;
road_width = L*lane_width + 2*road_sidemargin;

grass_sidemargin = 4*road_sidemargin;
grass_width = road_width + 2*grass_sidemargin;

road_color = [.3 .3 .3];
line_color = [1 1 1];
grass_color = [0.3 .6 0.3];
sky_color = [0.8 0.86 0.94];

floor_indent = lane_width;
ceil_indent = lane_width;
comp_domain = 5*lane_width;

rmax = .15;%max(max(max(r)));
rmin = 0;%min(min(min(r)));

if rmax~=rmin
    scale = (rmax-rmin) / comp_domain;
else
    scale = rmax / floor_indent;
end

floor_pos =rmin - scale * floor_indent;
ceil_pos = rmax + scale * ceil_indent;

figure(figno);
clf;
for i=1:z
    xh = subplot(z,1,i);
    set(xh, 'XLim', [a,b]);
    set(xh, 'YLim', [0,road_width+2*grass_sidemargin]);
    set(xh, 'ZLim', [floor_pos,ceil_pos]);
    set(xh, 'DataAspectRatio', [1 1 scale]);
    set(xh, 'DataAspectRatioMode', 'manual');
    set(xh, 'YTick',[]);
    set(xh, 'Color', sky_color);
    xlabel('Location x (m)');
    zlabel('Density r (veh./m)');
end

