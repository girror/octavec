function varargout = trajectories(allt, allx, allrho, allv, doPlot, varargin)
%TRAJECTORIES  x-t trajectories of imaginary cars
%   TRAJECTORIES(allt, allx, allrho, allv, doPlot, n, bounds) draws the trajectories
%   of n points (e.g. cars), initially uniformly distributed over the domain.
%   The trajectories are computed by integrating the macro-data:
%     allt is a vector of length K, with all the discrete timesteps
%     allx is a K x N matrix with x-values of the discretized domain at all times.
%     allv is a K x N matrix with the velocity values at all times, all x-points.
%     doPlot indicates whether to plot, or (if not) to return the trajectories.
%
%   varargin:
%       1. n, a positive integer: the number of trajectories to be drawn
%       1. 'periodic' indicates that the domain is periodic. (default)
%           Any other value will cause exiting trajectories not to enter periodically.
%
%   TRAJECTORIES(allt, allx, allv) uses n=N-1
%
%   Whenever doPlot==1, in the same plot, also the flow-values are shown as an underlying gray-scaling.
%
%   Only whenever doPlot==0, the points of the trajectories are returned
%   as two 1 x n cell-arrays. Each element of this cell-array is a 1 x K array containing the points of
%   one specific trajectory at all discrete times.
%   varargout = {tt, tp}; where tt contains the trajectories times
%   and tp the trajectories points.

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

K = length(allt);
sz = size(allx);
N = sz(2);
a = allx(1,1);
b = allx(1,N);
alltm = allt' * ones(1,N-1);
bounds = 'periodic';
n = N-1;

newOnRotate = doPlot;
returnSol = ~doPlot;

if nargin > 5
    if isnumeric(varargin{1})
        n = varargin{1};
    elseif ischar(varargin{1})
        bounds = varargin{1};
    end
end
if nargin > 6
    if ischar(varargin{2})
        bounds = varargin{2};
    end
end

dx = (allx(1,end-2)-allx(1,3)) / n; % note: the '/ n' is correct (not n-1)!
p = num2cell(allx(1,3) : dx : allx(1,end-2)-dx);
t = num2cell(allt(1)' * ones(1, n));

np = n;

% loop over all startingpoints of the trajectories:
for j = 1:n
    % from now, jp is the index of the trajectory that we currently integrate
    % originally jp-j, but if a trajectory exits the domain and periodically re-enters
    % it is stored as a new trajectory (for convenient plotting)
    jp = j;

    for k = 1:K-1
        xa = cellaverages(allx(k,:));
        idx = find(xa >= p{jp}(end));
        if(isempty(idx))
            jb = N-1;
        else
            jb = idx(1);
        end
        if jb==1
            ja = N-1;
        else
            ja = jb-1;
        end
        % ja and jb are the indices of teh two meshpoints that points jp is currently between
        % determine velocity at point jp by simple linear interpolation.
        v = ((xa(jb) - p{jp}(end)) * allv(k,jb) + (p{jp}(end) - xa(ja)) * allv(k,ja)) / (xa(jb) - xa(ja));
        
        to = allt(k);
        po = p{jp}(end);
        % determine the next point of the trajectory by 1st order forward time-integration step
        pn = p{jp}(end) + (allt(k+1)-allt(k)) * v;

        if pn <= b                        % simplest case: just a new point within [a,b]
            p{jp}(end+1) = pn;
            t{jp}(end+1) = allt(k+1);
        elseif strcmp(bounds, 'periodic') % new point exits domain, if periodic: re-enter domain
           if newOnRotate                 % re-entering trajectories are stored as new trajectories
                p{jp}(end) = pn;
                t{jp}(end) = allt(k+1);
                np = np+1;
                jp = np;
                p{jp}(1) = po - b + a;
                t{jp}(1) = to;
                p{jp}(2) = pn - b + a;
                t{jp}(2) = allt(k+1);
            else                          % re-entering trajectory is still stored as the same
                p{jp}(end+1) = pn - b + a;
                t{jp}(end+1) = allt(k+1);
            end
        else                              % no periodicity, store last point and end this trajectory.
            p{jp}(end+1) = pn;
            t{jp}(end+1) = allt(k+1);
            break;
        end
    end
end

if returnSol
    varargout = {t, p};
else
    varargout = {};
end
allm = allrho .* allv;
if doPlot
    fh = figure(17);
    clf;
    ah=axes;
    set(fh,'Name',['trajectories of ', num2str(n), ' imaginary cars']);
    hold off;
    sh = surf(alltm, cellaverages(allx), allm,'EdgeColor','flat','FaceColor','flat');%contour3(Z,30);
    colormap(0.8*gray+0.2);
    maxm = max(max(allm));
    view([0, 0, 1]);
    for j=1:np
        hold on;
        lh = plot3(t{j}, p{j},maxm*1.01 + 0*t{j},'k-');
    end
    %titleDS;
    axis([allt(1),allt(end),allx(1,3),allx(1,end-2),min(min(allm)), maxm*1.02]);
    xlabel('time (s)');
    ylabel('x (m)');
    cbh = colorbar;
    axes(cbh);
    title('Flow');
    axes(ah);
    lgh = legend([sh,lh],'Flow (veh./s)','trajectories',2);
    set(lgh, 'Layer','top');
end
