function info = settingsInfo(m)
%SETTINGSINFO   Detailed info on ModelSettings
%   SETTINGSINFO(m) prints information on the variables
%   as defined in the modelsettings m.

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

info = sindent(sprintf('Model settings:\n'), 2);

n = length(m.variables);
for i = 1:n
  varid = m.variables(i).varid;
  varname = m.variables(i).varname;
  varvalue = eval(['m.',m.variables(i).varid]);
  if(varid == 'w')
    info = [info, variablesInfo(varvalue, 4)];
  else
    info = [info, sindent(settingInfo(varname, varvalue),4), sprintf('\n')];
  end
end


%%%%
function info = settingInfo(varname, varvalue)
info = sprintf('» %s%s: %s', varname, repeat(' ', 15-length(varname)),varvalue);


%%%%
function info = variablesInfo(variables, indent)
n = length(variables);
info = sindent(sprintf('» Model variables:\n'), indent);
for i = 1:n
  info = [info, sindent(variableInfo(variables(i), '¤'),indent+2), sprintf('\n')];
end


%%%%
function info = variableInfo(variable, prefix)
info = sprintf('%s %s%s(= %s)', prefix, variable.symbol, repeat(' ', 10-length(variable.symbol)), variable.name);
