function idx = getIdx(varargin)
%GETIDX Get indices in solution-matrix
%   idx = GETIDX() returns ALL indices (i.e. all variables, classes and lanes)
%
%   idx = GETIDX(var) returns ALL indices for one model variable (i.e. all classes and lanes)
%
%   idx = GETIDX(var,uc) returns ALL indices for one model variable, one userclass (i.e. all lanes)
%
%   idx = GETIDX(var,uc,lane) returns the index for one model variable, one userclass, one roadway lane
%
%   In TraFlow the number of model variables is equal to TF_q
%       Generally, there are also TF_q accompanying PDEs
%   However, there may be more userclasses, TF_m
%       Each PDE is duplicated, with class-specific parameters (TF_q*TF_m PDEs)
%   Finally, there may also be multiple roadway lanes: TF_l
%       Once again, PDEs are duplicated: (TF_q*TF_m*TF_l PDEs)
%
%   Variable  Userclass  Lane
%    1         1          1
%    1         1          2
%    1         1          3
%    1         1          4
%    1         2          1
%    1        ...        ...
%    1         2          4
%    1         3          1
%    1        ...        ...
%    1         3          4
%    2         1          1
%    2        ...        ...
%    2         3          4
%
%   Or in formula: idx = lane + ((var-1)*TF_m + (uc-1))*TF_l;

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

global TF_q TF_m TF_l;

switch nargin
case 0
  idx = 1:1:(TF_q*TF_m*TF_l);
case 1
  var = varargin{1};
  if ~isvalid(var, TF_q)
    warning(sprintf('getIdx(%d) invalid parameters!', var));
    return
  end
  idx = (1:(TF_m*TF_l)) + (var-1)*(TF_m*TF_l);
case 2
  var = varargin{1};
  uc  = varargin{2};
  if ~isvalid(var, TF_q) | ~isvalid(uc, TF_m)
    warning(sprintf('getIdx(%d, %d) invalid parameters!', var, uc));
    return
  end
  idx = (1:TF_l) + (var-1)*(TF_m*TF_l) + (uc-1)*TF_l;
case 3
  var  = varargin{1};
  uc   = varargin{2};
  lane = varargin{3};
  if ~isvalid(var, TF_q) | ~isvalid(uc, TF_m) | ~isvalid(lane, TF_l)
    warning(sprintf('getIdx(%d, %d, %d) invalid parameters!', var, uc, lane));
    return
  end
  idx  = [lane + ((var-1)*TF_m + (uc-1))*TF_l];
end


%%%%
function bool = isvalid(var, upperlim)
if ~isnumeric(var)
  bool = 0;
else
  bool = (isint(var) & var > 0 & var <= upperlim);
end
