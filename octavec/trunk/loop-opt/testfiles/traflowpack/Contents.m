% TraFlowPACK, v1 by Arthur van Dam
%                   _                  ___             ___    
%       |¯¯¯\_  ___|,| /¯¯¯\      __ _/[]L\__        _/[]L\__                 
% [¯¯¯¯¯| º / \|  __|||  O  | __ / /(_,.__,._)  ___ (_,.__,._)
%  ¯| |¯|_|/ A \ |_] |_\___/ v  v /---`'--`'--_/[]L\__`'--`'---
%   |_|   /_/-\_\| |    |   \_/\_/           (_,.__,._)
%                   ¯¯¯¯          P A C K   ---`'--`'--
%                                 ¯¯¯¯¯¯¯
% TraFlowPACK consists of:
%  * TraFlow traffic simulator
%  * MMFVPDES, moving mesh finite volume PDE solver
%
%
% TraFlowPACK uses a directory structure to keep things clean:
%
%   traflowpackroot
%     |
%     |_mmfvpdesroot
%     |   |_helpers
%     |   |_visualization
%     |
%     |_traflowroot
%     |   |_helpers
%     |   |_visualization
%     |
%     |_workroot
%
% (all names above are documented functions, for example, use: 'help visualization')
%
% Usage:
%   ADDPATHS extends the MATLAB-path with the TraFlowPACK filetree
%   Further info is specified by the solver and the simulator
%
% See also: TRAFLOWPACKROOT,
%           MMFVPDES, TRAFLOW, WORK,
%           VISUALIZATION,
%           HELPERS

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
