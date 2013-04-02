function densityAnimation()
%DENSITYANIMATION   'real-world animation' of traffic flow
%   DENSITYANIMATION creates a movie of the current solution values in MM_ALLU
%
%   Make sure to edit this file, for proper computation of densities and velocities.
%   Currently only suitable for one lane, one class.
%
%   Afterwards, a global variable M contains the movie; play it with
%       global M; movie(M, 1);
%
%   See also: ROADDENSITYPLOT, TRAJECTORIES

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

global MM_ALLT MM_ALLX MM_ALLU MM_NX;
global M;

sz = size(MM_ALLX);
nt = sz(1);

%%
% Compute trajectories to draw imaginary cars as moving white dots
%%
[tt, tp] = trajectories(MM_ALLT, MM_ALLX(:,3:MM_NX), squeeze(MM_ALLU(2,:,3:MM_NX-1)),squeeze(MM_ALLU(2,:,3:MM_NX-1)),0,50);

ntr = length(tp);

for j = 1:ntr
  trx(1:nt,j) = (tp{j})';
end

%%
% Start movie-building
%%
figure(14);
clf;
M = moviein(nt);

%%
% For each discrete time, create a new 3dplot
%%
for i = 1:nt-1
    [ym, zm] = roaddensityplot(cellaverages(squeeze(MM_ALLX(i,3:MM_NX))), reshape(MM_ALLU(1,i,3:MM_NX-1), 1, MM_NX-3),1,1);
    set(gca,'NextPlot','replacechildren');
    set(gca,'CLim',[0,.15]); % Maintain the same color-scaling during animation. Edit the limits to your own needs.

    % Plot the white dots inside the existing roaddensityplot
    % NOTE!: roaddensityplot is suitable for multiple lanes, multiple classes. The trajectories are not (yet).
    hold on;
    plot3(trx(i,:), 0*trx(i,:) + ym, 0*trx(i,:) + zm,'w.','MarkerSize',5);

    M(:,i)=getframe(gca,[-60,-15,500,320]);
    hold off;
end
