function save_data(exproot, filename)
% SAVE_DATA  store MFVPDES-output
%   SAVE_DATA(exproot, filename) stores the times, meshpoints and solutions
%   from the current global variables MM_ALLT, MM_ALLX, MM_ALLU
%   in a file named 'filename.mat', placed in the exproot-directory.
%
%   SAVE_DATA(filename) stores the times, meshpoints and solutions.
%   The system then uses workroot as the experiments-directory.
%
%   The user is asked for input of a short description of the data.
%
%   See also: LIST_DATA, LOAD_DATA, WORKROOT

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

global MM_ALLT MM_ALLX MM_ALLU;
global MM_datasource;

if nargin==1
    filename = exproot;
    exproot = workroot;
end

filesep = '/';

stamp = clock;

fullpath = [exproot, filesep, filename,'.mat'];
save(fullpath, 'MM_ALLT', 'MM_ALLX', 'MM_ALLU');
MM_datasource = sprintf('''%s.mat''',filename);

fprintf('Data written to ''%s'':\n',fullpath);
whos MM_ALLT MM_ALLX MM_ALLU;

tocpath = [exproot, filesep, 'experiments.txt'];
fid = fopen(tocpath, 'a');

userInfo = input('Please enter your own information for this run (within ''quotes'').\nIt will be written to the file ''experiments.txt''.\nEnter ''E'' to open an editor for advanced editing:');

fprintf(fid, '--BOR--\nFile: %s\nDate: %02.0f-%02.0f-%4.0f %02.0f:%02.0f:%02.0f\n', fullpath, stamp(3), stamp(2), stamp(1), stamp(4), stamp(5), stamp(6));
if ~isempty(userInfo) & ~ strcmp(userInfo, 'E')
    fprintf(fid, '%s\n', userInfo);
else
    fprintf(fid, '-> Place additional user-info here.\n');
end
fprintf(fid, '--EOR--\n');
fclose(fid);

if strcmp(userInfo, 'E')
    edit(tocpath);
end

