function p = ProblemSettings(varargin)
%PROBLEMSETTINGS  ProblemSettings class constructor
%   p = PROBLEMSETTINGS(descriptor, settingsfile) creates a
%   ProblemSettings-object, identified by the descriptor
%   and using the settings from the settingsfile.

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

% Note: this class will only be called with the two arguments
% no fancy constructors ('copy' or 'default') are implemented.
if nargin < 2
  error('Wrong number of input arguments')
end
p.descriptor = varargin{1};
p.f_psettings = varargin{2};
p.info = '';
p.domain = [0,0];
p.bounds = '';
p.ucs = {};
p.lanes = [];
p.f_init = '';

vars = [...
    struct('varid','domain', 'varname','domain');...
    struct('varid','bounds', 'varname','boundary-type');...
    struct('varid','ucs', 'varname','user-classes');...
    struct('varid','lanes', 'varname','roadlanes');...
    struct('varid','f_init', 'varname','initial-solution')...
  ];
p.variables = vars;

p = class(p,'ProblemSettings');
% load settings from file:
p = init(p);
