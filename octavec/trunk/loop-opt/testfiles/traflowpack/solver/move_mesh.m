function [xn, un, mm_it] = move_mesh(to, xo, uo, f_monitor, f_boundaries, mm_maxit, mm_tol, mm_nsmooth)
global MM_NX MM_NU;
global maxw totw totmaxw nw diffw;

dxi=1.0/(MM_NX-3);

%%
% Solve the mesh equation: \partial_\xi ( w x_\xi) =0 using Gauss-Seidel iterations
%%
mm_res = mm_tol+1; % always start bigger
mm_it = 0;
while mm_it < mm_maxit & mm_res > mm_tol
    % Compute monitor values
    w = feval(f_monitor,uo, cellaverages(xo), dxi);
    % smoothen the monitor values
    for sm=1:mm_nsmooth
        w = smoothen(w);
    end
    % Some monitor-diagnostics
    diffw = diffw + max(cellsizes(w(3:MM_NX-1))) / (MM_NX-3);
    maxw=max(maxw, max(w(3:MM_NX-1)));
    totw=totw+sum(w(3:MM_NX-1));
    totmaxw=totmaxw+max(w(3:MM_NX-1));
    nw=nw+1;
    
    % Compute the new meshpoint locations with Gauss-Seidel
    xn([3,MM_NX]) = xo([3, MM_NX]); % fixed boundaries
    for j=4:MM_NX-1
        xn(j)=(w(j)*xo(j+1)+w(j-1)*xn(j-1))/(w(j)+w(j-1));
    end
    % periodic mesh-move speed
    xn(1)=xo(1)+(xn(MM_NX-2)-xo(MM_NX-2));
    xn(2)=xo(2)+(xn(MM_NX-1)-xo(MM_NX-1));
    xn(MM_NX+1)=xo(MM_NX+1)+(xn(4)-xo(4));
    xn(MM_NX+2)=xo(MM_NX+2)+(xn(5)-xo(5));

    %% or periodic cell-sizes
    %xn(MM_NX+1)=XO(MM_NX)+(xn(4)-xn(3));
    %xn(MM_NX+2)=XO(MM_NX+1)+(xn(5)-xn(4));
    %xn(2)=XO(3)-(xn(MM_NX)-xn(MM_NX-1));
    %xn(1)=XO(2)-(xn(MM_NX-1)-xn(MM_NX-2));

    mm_res=sum(abs(xn(3:MM_NX)-xo(3:MM_NX))) / (MM_NX-3);
    
    %%
    % Conservative interpolation of u at new mesh
    %%
    xoa=xo;%cellaverages(xo);
    xna=xn;%cellaverages(xn);
    du(1:MM_NU,3:MM_NX) = uo(1:MM_NU,3:MM_NX)-uo(1:MM_NU,2:MM_NX-1); %j - (j-1)
    S(1:MM_NU,3:MM_NX-1)=(sign(du(1:MM_NU,3:MM_NX-1)) + sign(du(1:MM_NU,4:MM_NX))) .* abs(du(1:MM_NU,3:MM_NX-1) .* du(1:MM_NU,4:MM_NX)) ./ (abs(du(1:MM_NU,3:MM_NX-1)) + abs(du(1:MM_NU,4:MM_NX)) + 1.0E-10);
    S(1:MM_NU,[2,MM_NX])=S(1:MM_NU,[MM_NX-1,3]); %periodic boundaries

    up(1:MM_NU,3:MM_NX) = uo(1:MM_NU,3:MM_NX) - 0.5 * S(1:MM_NU,3:MM_NX);
    um(1:MM_NU,3:MM_NX) = uo(1:MM_NU,2:MM_NX-1) + 0.5 * S(1:MM_NU,2:MM_NX-1);

    c = xo - xn;
    cu(1:MM_NU,3:MM_NX) = ones(MM_NU,1)*c(3:MM_NX)/2 .* (up(1:MM_NU,3:MM_NX) + um(1:MM_NU,3:MM_NX)) - (ones(MM_NU,1)*abs(c(3:MM_NX))/2) .* (up(1:MM_NU,3:MM_NX) - um(1:MM_NU,3:MM_NX));

    un(1:MM_NU,3:MM_NX-1) = ((ones(MM_NU,1)*(xoa(4:MM_NX) - xoa(3:MM_NX-1))) .* uo(1:MM_NU,3:MM_NX-1) - (cu(1:MM_NU,4:MM_NX) - cu(1:MM_NU,3:MM_NX-1))) ./ (ones(MM_NU,1)*(xna(4:MM_NX) - xna(3:MM_NX-1)));
    un=feval(f_boundaries, to, xn, un); %periodic boundaries

    % Store new 'old' solution
    xo=xn;
    uo=un;
   
    mm_it = mm_it+1;
end
