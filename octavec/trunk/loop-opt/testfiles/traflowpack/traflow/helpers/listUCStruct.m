function table = listUCStruct(ucs, varargin)
%LISTUCSTRUCT pretty-prints a userclasses-structure
%   table = LISTUCSTRUCT(ucs, sin) returns a string containing an aligned list of userclass parameters
%   optionally indented by sin spaces.
%
%   For example:
%   For the following userclasses:
%
%   ucs=struct(...
%       'name',{'slow person-car','fast person-car','truck'},...
%       'v0',{27.5, 32.5, 24},...
%       'remax',{0.2, 0.2, 0.2},...
%       'tau',{10, 10, 10}...
%   );
%
%   listUCStruct returns the following:
%   +-------------------------------------------------------------+
%   |  name:  slow person-car | fast person-car |      truck      |
%   |    v0:        27.5      |       32.5      |        24       |
%   | remax:        0.2       |       0.2       |       0.2       |
%   |   tau:         10       |        10       |        10       |
%   +-------------------------------------------------------------+

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

if nargin>1
    sin = varargin{1};
else
    sin = 0;
end

n = length(ucs);
fields = fieldnames(ucs);
M = length(fields);

colwidth = 0;
fcwidth = 0;
for m = 1:M
    field = fields(m);
    field = field{:};
    eval(['[maxwidth, strs{m}] = toStr(ucs.' field ');']);
    colwidth = max(colwidth, maxwidth);
    fcwidth = max(fcwidth, length(field));
end
colwidth = colwidth + 2;
fcwidth = fcwidth + 3;
sepwidth = 1;
hline = ['+', repeat('-', sepwidth + fcwidth + n*(sepwidth + colwidth)-2),'+'];
table = sindent(hline, sin);
for m = 1:M
    field = fields(m);
    field = field{:};
    row = [sindent('|', sin), sindent([' ', field], fcwidth - 3 - length(field)), ': '];
    for i = 1:n
        str = strs{m};
        value = str{i};
        row = [row, strcenter(value, colwidth - length(value))];
        row = [row, '|'];
    end
    table = [table;row];
end
table = [table;sindent(hline, sin)];
return

%%%%
function strc = strcenter(str, nspc)
l1 = round(nspc/2);
l2 = nspc - l1;
strc = sindent(spad(str, l2), l1);

%%%%
function [maxwidth, strings] = toStr(varargin)
maxwidth = 0;
for i = 1:nargin
    if isnumeric(varargin{i})
        strings{i} = num2str(varargin{i});
    else
        strings{i} = varargin{i};
    end
    maxwidth = max(maxwidth, length(strings{i}));
end
