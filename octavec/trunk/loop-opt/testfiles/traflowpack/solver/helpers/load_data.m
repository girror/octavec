function load_data(exproot, filename)
% LOAD_DATA  retrieve MFVPDES-output
%   LOAD_DATA(exproot, filename) reloads the times, meshpoints and solutions
%   from a file named 'filename.mat', placed in the exproot-directory
%
%   LOAD_DATA(filename) reloads the times, meshpoints and solutions
%   The system then uses workroot as the experiments-directory
%
%   See also: LIST_DATA, SAVE_DATA, WORKROOT

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
global MM_ALLT MM_ALLX MM_ALLU MM_A MM_B MM_NX MM_NU MM_plotlabels;
global MM_datasource;

if nargin==1
    filename = exproot;
    exproot = workroot;
end

fullpath = [exproot, filesep, filename,'.mat'];
load(fullpath, 'MM_ALLT', 'MM_ALLX', 'MM_ALLU');
MM_datasource = sprintf('''%s.mat''',filename);
MM_NX = size(MM_ALLX, 2) - 2;
MM_NU = size(MM_ALLU, 1);
MM_A = MM_ALLX(1,3);
MM_B = MM_ALLX(1,MM_NX);
MM_plotlabels = {};
for i = 1:MM_NU
    MM_plotlabels = {MM_plotlabels{:},['u_',num2str(i)]};
end



fprintf('Restored and deduced data from ''%s'':\n',fullpath);
whos MM_ALLT MM_ALLX MM_ALLU MM_A MM_B MM_NX MM_NU MM_plotlabels;
