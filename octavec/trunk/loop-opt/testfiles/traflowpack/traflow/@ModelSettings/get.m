function val = get(m,prop_name)
%GET    Get ModelSettings-properties
%   GET(m, prop_name) Get ModelSettings properties from the specified object
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
case 'Variables'
  val = m.variables;
case 'nMVars'
  val = length(m.w);
case 'f_f'
  val = m.f_f;
case 'f_dfdu'
  val = m.f_dfdu;
case 'f_g'
  val = m.f_g;
otherwise
  error([prop_name,' is not a valid modelsetting property'])
end
  
  
