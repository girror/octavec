function sv = sumUCs(v, q, m, l, n)
%SUMUCS sum values over all userclasses
%   sv = SUMUCS(v, q, m, l, n) takes the input-value-matrix v and assumes it
%   to contain q variables, m userclasses, l roadway lanes and n points,
%   and sums over all these m userclasses.
%
%   By letting the user specify q, m, l and n, SUMUCS can be applied to any
%   (sub)set of the original data, independent of TF_q, TF_m, TF_l and TF_n.
%
%   For example:
%     SUMUCS([1:10; 11:20; 21:30; 31:40; 41:50; 51:60; 61:70; 71:80], 2, 2, 2, 10)
%       creates [22:2:40; 42:2:60; 102:2:120; 122:2:140]
%
%   See also: GETIDX, SAMEALLUCS

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

sv = reshape(squeeze(sum(reshape(v', n, l, m, q), 3)), n, q*l)';
