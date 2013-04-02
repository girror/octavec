function m = ModelSettings(varargin)
%MODELSETTINGS  ModelSettings class constructor
%   m = MODELSETTINGS(descriptor, settingsfile) creates a
%   ModelSettings-object, identified by the descriptor
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
m.descriptor = varargin{1};
m.f_msettings = varargin{2};
m.desc = '';
m.info = '';
m.w = [];
m.f_f = '';
m.f_dfdu = '';
m.f_g = '';

vars = [...
    struct('varid','w', 'varname','Model variables');...
    struct('varid','f_f', 'varname','f(u) of which space-derivative is taken');...
    struct('varid','f_dfdu', 'varname','u-derivative of f: df(u)/du');...
    struct('varid','f_g', 'varname','righthand-side of PDE (non-convective terms)');...
  ];
m.variables = vars;

m = class(m,'ModelSettings');
% load settings from file:
m = init(m);
