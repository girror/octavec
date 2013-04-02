function mm_callback(action, varargin)
% MM_CALLBACK   callback routine for the moving-mesh figure
%   MM_CALLBACK('click') takes the clicked coordinate,
%   finds the nearest timesample, and redraws the current solution
%   and meshmap at that time.

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
case 'click'
   hx = findobj(figure(3), 'Tag','mm_axes');
   point = get(hx, 'CurrentPoint');
   tp = point(1,2);
   t = plot_data('sol_t', tp);
   plot_data('meshmap_t', t);

   hl = findobj(hx, 'Tag', 'mm_timeline');
   set(hl, 'YData', [t;t]);
end