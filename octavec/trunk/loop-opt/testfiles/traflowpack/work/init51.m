function u = init51(x)
% INIT51    initial condition for 'Burgers example'

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

u=0.5+sin(x);

%% other initials:
%u = tan(x-pi);
%u = sin(x-4)-10*cos(x-1.6)+10*sin(x)+5*cos(2*x)+2*cos(4*x);%10*sin(x)+5*cos(2*x)+2*cos(4*x);
%b(1:m)=-x(1:m);
%b(m+1:3*m)=x(m+1:3*m)-x(2*m);
%b(3*m+1:n) = -x(3*m+1:n)+x(n);
%u = b/5 + 0.5 + sin(2*x);