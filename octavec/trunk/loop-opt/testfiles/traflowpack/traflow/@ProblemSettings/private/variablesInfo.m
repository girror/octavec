function info = variablesInfo(p)
%VARIABLESINFO   Detailed info on ProblemSettings
%   VARIABLESINFO(p) prints information on the variables
%   as defined in the problemsettings p.

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

info = sindent(sprintf('Problem variables:\n'), 2);

n = length(p.variables);
for i = 1:n
  varname = p.variables(i).varname;
  varvalue = eval(['p.',p.variables(i).varid]);
  if(isnumeric(varvalue))
    varvalue = num2str(varvalue);
  end
  if(strcmp(varname, 'user-classes'))
    %    varvalue = [sprintf('\n'), toString(varvalue, 6, '¤')];%varvalue.name;
    varvalue = listUCStruct(varvalue, 6);
    sz = size(varvalue);
    varvalue = [varvalue, reshape(repeat(sprintf('\n'), sz(1)), sz(1), 1)];
    varvalue = reshape(varvalue', sz(1)*(sz(2)+1), 1)' ;
    info = [info, sindent(variableInfo(varname, ''),4), sprintf('\n'),varvalue];
  else
    info = [info, sindent(variableInfo(varname, varvalue),4), sprintf('\n')];
  end
end


%%%%
function info = variableInfo(varname, varvalue)
info = sprintf('» %s%s: %s', varname, repeat(' ', 15-length(varname)),varvalue);
