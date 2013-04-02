function val = get(p,prop_name)
%GET    Get ProblemSettings-properties
%   GET(p, prop_name) Get ProblemSettings properties from the specified object
%   and return the value

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

switch prop_name
case 'Domain'
  val = p.domain;
case 'UCs'
  val = p.ucs;
case 'nUCs'
  val = length(p.ucs);
case 'Lanes'
  val = p.lanes;
case 'nLanes'
  sz=size(p.lanes);
  val = sz(1);
case 'fInit'
  val = p.f_init;
case 'bounds'
  val = p.bounds;
otherwise
%  if strncmp('pdep_', prop_name, 5)
%    val = getPDEParam(p, prop_name(6:end));
%  else
    error([prop_name,' is not a valid ProblemSetting property'])
%  end
end
  
  
%%%%
% not used anymore (probably)
function val = getPDEParam(p, param_name)
n = length(p.pde_params);
for i = 1:n
  if strcmp(p.pde_params(i).name, param_name)
    val = p.pde_params(i).value;
  end
end
if isempty(val)
  error([param_name,' is not a valid PDE-parameter.']);
end

