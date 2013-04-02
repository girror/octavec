function globaliseUCs(ucs)
%GLOBALISEUCS Registers and initializes userclass-parameters in the global workspace
%   GLOBALISEUCS(ucs) takes the structure ucs (of dimension TF_m, all userclasses)
%   For each fieldname an array with that name is added to the global workspace.
%
%   For example:
%   ucs=struct(...
%       'name',{'slow person-car','fast person-car','truck'},...
%       'v0',{27.5, 32.5, 24},...
%       'remax',{0.2, 0.2, 0.2},...
%       'tau',{10, 10, 10}...
%   );
%   creates four global arrays of length 3 with the above values (the name array is useless however)
%   This function is actually only for internal use (automatically called by TraFlow).

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

fields = fieldnames(ucs);
M = length(fields);
for m = 1:M
  field = fields(m);
  field = field{:};
  eval(['values = {ucs.', field, '};']);
  if isnumeric(values{1})
    eval(['global ', field, '; ' field ' = [ucs.', field, ']'';']);
  end
end
