function varargout = plot_data(action, varargin)
%PLOT_DATA  Plot MMFVPDES data
%   PLOT_DATA creates the various plots for the MMFVPDES solution.
%   action is one of {'sol_t', 'meshmap_t', 'meshmov'}
%
%   Further arguments:
%   for 'sol_t' and 'meshmap_t', the required second argument should be t.
%   for 'sol_t' the 3rd, 4th and 5th arguments are optional and are
%     respectively tn, xn and un of a 'pseudoexact' solution at a single time tn
%   for 'meshmov', no further arguments are needed.
%
%   Return values:
%   for 'sol_t' and 'meshmap_t' the sampled time td, closest to
%     input time t is returned.

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

switch action
case 'sol_t'
    t = varargin{1};
    td = plot_solution(t,varargin{2:end});
    varargout{1} = td;
case 'meshmap_t'
    t = varargin{1};
    td = plot_meshmap(t);
    varargout{1} = td;
case 'meshmov'
    plot_meshmovement;
otherwise
    warn(['Invalid plot-action ''', action, '''.Exiting.']);
    return;
end


%%%%
function td = plot_solution(t, varargin)
global MM_NX MM_A MM_B;
global MM_ALLT MM_ALLX;
global MM_numplotdata MM_plotlabels;
global MM_datasource;

ti = time_index(t);
td = MM_ALLT(ti);

sz = size(MM_numplotdata);
if length(sz) == 3
    nu = sz(1);
else
    nu = 1;
    sz = [1, sz];
end

% ensure that dimensions are always nu x nt x nx
MM_numplotdata = reshape(MM_numplotdata, sz);

h = figure(1);
set(h,'Name',['Current solution at t=', num2str(td)]);

nc = min(nu,3);
nr = ceil(nu/nc);
positionWindow(h, 1, nr, nc);

for iu = 1:nu
    ah = subplot(nr, nc, iu);
    hold off;
    if nargin > 1
        te = varargin{1};
        xe = varargin{2};
        ue = varargin{3};
        nx = length(xe)-2;
        plot(cellaverages(xe(3:nx)), ue(iu,3:nx-1),'r--');
        legendtext = {sprintf('exact, t=%g',te)};
        hold on;
    else
        legendtext = {};
    end
    xdata = MM_ALLX(ti,3:MM_NX);
    udata = squeeze(MM_numplotdata(iu, ti,3:MM_NX-1));

    plot(cellaverages(xdata),udata,'b+-','MarkerSize',2)
    legendtext = {legendtext{:};sprintf('t=%g',MM_ALLT(ti))};%num, 
    hold on;

    umin = min(udata);
    umax = max(udata);
    height = umax-umin;
    gridbar = (umin-height/20) * ones(MM_NX-2);
    plot(xdata,gridbar, '+', 'MarkerEdgeColor',[0.5 0.5 0.5]);

    %global shockx;
    %shockbds=unique([shockx (shockx+1)]);
    %xsh = MM_ALLX(ti,shockbds);
    %ns=length(xsh);
    %xsh=ones(2,1) * xsh;
    %shbar = [(umin-height/15);(umax+height/15)] * ones(1,length(xsh));
    %hold on;
    %plot(xsh,shbar, 'x-', 'Color',[0.25 0.5 0.5]);

    xlabel('x (m)');
    ylabel(MM_plotlabels(iu));

    set(ah,'XlimMode','manual');
    set(ah,'Xlim',[MM_A MM_B]);
    set(ah,'YlimMode','manual');
    height = max(height, 1E-10);
    set(ah,'Ylim',[(umin-height/10) umax+height/20]);

    titleDS(ah);
    legend(ah,legendtext{:});
end


%%%%
function td = plot_meshmap(t)
global MM_NX MM_A MM_B;
global MM_ALLT MM_ALLX;

ti = time_index(t);
td = MM_ALLT(ti);

hlines_x = [zeros(1,MM_NX-2);0:1/(MM_NX-3):1];
hlines_y = [1;1] * MM_ALLX(ti,3:MM_NX);

vlines_x = [1;1] * [0:1/(MM_NX-3):1];
vlines_y = [MM_A*ones(1,MM_NX-2); MM_ALLX(ti,3:MM_NX)];

h = figure(2);
positionWindow(h, 4);
set(h,'Name','Current mesh-mapping');

hold off;
plot(0:1/(MM_NX-3):1, MM_ALLX(ti,3:MM_NX),'b-',[0,1],[MM_A,MM_B],'r:');
lh = line([hlines_x, vlines_x], [hlines_y, vlines_y]);
set(lh, 'Color', [0.6 0.6 0.6]);

legend(sprintf('x(\\xi) mapping at t=%g', MM_ALLT(ti)),'identity mapping',2);
xlabel('\xi');
ylabel('x');
hx = get(h,'CurrentAxes');
set(hx,'XlimMode','manual');
set(hx,'Xlim',[0 1]);
set(hx,'YlimMode','manual');
set(hx,'Ylim',[MM_A MM_B]);
titleDS(hx);


%%%%
function plot_meshmovement()
global MM_NX MM_A MM_B;
global MM_ALLT MM_ALLX;
nt = length(MM_ALLT);

h = figure(3);
positionWindow(h, 3);
set(h,'Name','Mesh movement');

hold off;
plot(MM_ALLX(:,1),MM_ALLT, 'b-', 'HitTest','off');
hold on;
for xi = 3:MM_NX+1
  plot(MM_ALLX(:,xi),MM_ALLT, 'b-', 'HitTest','off');
end
xlabel('x');
ylabel('t');

% indicator line for current time:
hl = line([MM_A;MM_B],[MM_ALLT(nt);MM_ALLT(nt)], 'HitTest','off');
set(hl,'Color',[1 0 0]);
set(hl,'Tag','mm_timeline');

hx = get(h,'CurrentAxes');
set(hx, 'Tag', 'mm_axes');
set(hx,'XlimMode','manual');
set(hx,'Xlim',[MM_A MM_B]);
set(hx,'YlimMode','manual');
set(hx,'Ylim',[MM_ALLT(1) MM_ALLT(nt)]);
set(hx,'ButtonDownFcn','mm_callback(''click'')');
titleDS(hx);


%%%%
function ti = time_index(t)
global MM_ALLT;
nt = length(MM_ALLT);

ts=find(MM_ALLT >= t);
if length(ts) < 1
  ti=nt;
  warn(sprintf('Time %g does not exist in domain [%g, %g].\nUsing largest value instead: %g.', t, MM_ALLT(1), MM_ALLT(nt), MM_ALLT(ti)));
elseif MM_ALLT(1) > t
  ti=1;
  warn(sprintf('Time %g does not exist in domain [%g, %g].\nUsing smallest value instead: %g.', t, MM_ALLT(1), MM_ALLT(nt), MM_ALLT(ti)));
else
  ti=ts(1);
end


%%%%
function positionWindow(h, posid, varargin)
scrsz = get(0,'ScreenSize');
if nargin>2
    nr = min(2,varargin{1});
else
    nr = 1;
end
if nargin>3
    nc = min(2,varargin{2});
else
    nc = 1;
end    

% margins as [top, right, bottom, left];
windowmargins = [73, 4, 4, 3]; % title- and menubar is large top-margin.
desktopmargins = [0, 0, 55, 0]; % windows taskbar+one additional toolbar on top of it is large bottom-margin.
                                % windows taskbar only would be 29 pixels high.

wheight = ((scrsz(4)-desktopmargins(1)-desktopmargins(3)) / 2)*nr - windowmargins(1) - windowmargins(3);
wwidth = ((scrsz(3)-desktopmargins(2)-desktopmargins(4)) / 2)*nc - windowmargins(2) - windowmargins(4);

switch posid
case 1
   set(h, 'Position',[1+desktopmargins(4)+windowmargins(4), scrsz(4)-desktopmargins(1)-windowmargins(1)-wheight, wwidth, wheight]);
case 2
   set(h, 'Position',[1+desktopmargins(4)+windowmargins(4)+(2-nc)*(windowmargins(2)+windowmargins(4)+wwidth), scrsz(4)-desktopmargins(1)-windowmargins(1)-wheight, wwidth, wheight]);
case 3
   set(h, 'Position',[1+desktopmargins(4)+windowmargins(4), 1+desktopmargins(3)+windowmargins(3), wwidth, wheight]);
case 4
   set(h, 'Position',[1+desktopmargins(4)+windowmargins(4)+(2-nc)*(windowmargins(2)+windowmargins(4)+wwidth), 1+desktopmargins(3)+windowmargins(3), wwidth, wheight]);
end
