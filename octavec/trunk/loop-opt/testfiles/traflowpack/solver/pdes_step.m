function [dt, un] = pdes_step(xo, uo, to, Tend, f_f, f_dfdu, f_boundaries, f_g, cflC, solver)
global UO UN XO xn MM_NX WO MM_NU;

%%
% Find appropriate timestep, with CFL condition
%%
dx(2:MM_NX) = xo(3:MM_NX+1)-xo(2:MM_NX);
dxavg = (xo(MM_NX)-xo(3)) / (MM_NX-3);
if cflC > 0
    dfdudxmax = 0;
    if MM_NU > 1
        dfdu(1:MM_NU,2*MM_NU+1:MM_NU*(MM_NX-1)) = feval(f_dfdu, uo(1:MM_NU,3:MM_NX-1));
	%dfdu(:,:,3:MM_NX-1) = feval(f_dfdu, uo(1:MM_NU,3:MM_NX-1));
        for i=3:MM_NX-1
%            dfdudxmax = max(dfdudxmax, max(abs(eig(dfdu(:,:,i)))) ./ dx(i));
            dfdudxmax = max(dfdudxmax, max(abs(eig(dfdu(:,(i-1)*3+1:3*i)))) ./ dx(i));
        end
    else
        dfdudxmax = max(abs(feval(f_dfdu, uo(1:MM_NU,3:MM_NX-1))) ./ dx(3:MM_NX-1));
    end

    dt=cflC / (dfdudxmax + 1e-10);
    dtmax = 10; % manually limit the maximal \Delta t, in case dfdudxmax \approx 0.
    dt = min(dt, dtmax);
    dt = min(dt, Tend-to); % do not step beyond endtime
    dtmin = 1e-4*dxavg;
    %dt = max(dt,dtmin);
else
    dt=abs(cflC);
end

if dt > 50 | dt < 0.0001*dxavg
    warn('Adaptive timestep is very big or very small now.');
end

%%
% Perform one time-solve step with requested solver
%%
switch solver
case 1, % Finite Volume, and the Heun scheme
    dudx(1:MM_NU,3:MM_NX) = (uo(1:MM_NU,3:MM_NX)-uo(1:MM_NU,2:MM_NX-1)) ./ (0.5 * ones(MM_NU,1)*(xo(4:MM_NX+1) - xo(2:MM_NX-1))); % nu wel in physical domain.

    S(1:MM_NU,3:MM_NX-1)=(sign(dudx(1:MM_NU,3:MM_NX-1)) + sign(dudx(1:MM_NU,4:MM_NX))) .* abs(dudx(1:MM_NU,3:MM_NX-1) .* dudx(1:MM_NU,4:MM_NX)) ./ (abs(dudx(1:MM_NU,3:MM_NX-1)) + abs(dudx(1:MM_NU,4:MM_NX)) + 1.0E-10);
    S(1:MM_NU,[2,MM_NX])=S(1:MM_NU,[MM_NX-1,3]); %periodic boundaries

    up(1:MM_NU,3:MM_NX) = uo(1:MM_NU,3:MM_NX) + 0.5 * (ones(MM_NU,1)*(xo(3:MM_NX) - xo(4:MM_NX+1))) .* S(1:MM_NU,3:MM_NX);
    um(1:MM_NU,3:MM_NX) = uo(1:MM_NU,2:MM_NX-1) + 0.5 * (ones(MM_NU,1)*(xo(3:MM_NX) - xo(2:MM_NX-1))) .* S(1:MM_NU,2:MM_NX-1);

    if MM_NU>1
	dfdu_p(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        dfdu_m(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
        %dfdu_p(:,:,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        %dfdu_m(:,:,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
        for i=3:MM_NX
            dfdu_pv(:,i) = diag(dfdu_p(:,(i-1)*3+1:3*i));
            dfdu_mv(:,i) = diag(dfdu_m(:,(i-1)*3+1:3*i));
        end
        %for i=3:MM_NX
        %    dfdu_pv(:,i) = diag(dfdu_p(:,:,i));
        %    dfdu_mv(:,i) = diag(dfdu_m(:,:,i));
        %end
    else
        dfdu_pv(1:MM_NU,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        dfdu_mv(1:MM_NU,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
    end

    lf(1:MM_NU,3:MM_NX) = 0.5 * (feval(f_f,um(1:MM_NU,3:MM_NX)) + feval(f_f,up(1:MM_NU,3:MM_NX)) - max(abs(dfdu_pv(1:MM_NU,3:MM_NX)), abs(dfdu_mv(1:MM_NU,3:MM_NX))) .* (up(1:MM_NU,3:MM_NX)-um(1:MM_NU,3:MM_NX)));
    rhs=feval(f_g, uo, cellaverages(xo));
    ub(1:MM_NU,3:MM_NX-1) = uo(1:MM_NU,3:MM_NX-1) + dt .* ((ones(MM_NU,1)*(-1 ./ dx(3:MM_NX-1))) .* (lf(1:MM_NU,4:MM_NX) - lf(1:MM_NU,3:MM_NX-1)) + rhs(1:MM_NU,3:MM_NX-1));
    ub = feval(f_boundaries, to, xo, ub);

    % perform 2nd step of Heun scheme
    dudx(1:MM_NU,3:MM_NX) = (ub(1:MM_NU,3:MM_NX)-ub(1:MM_NU,2:MM_NX-1)) ./ (0.5 * ones(MM_NU,1)*(xo(4:MM_NX+1) - xo(2:MM_NX-1))); % nu wel in physical domain.
    S(1:MM_NU,3:MM_NX-1)=(sign(dudx(1:MM_NU,3:MM_NX-1)) + sign(dudx(1:MM_NU,4:MM_NX))) .* abs(dudx(1:MM_NU,3:MM_NX-1) .* dudx(1:MM_NU,4:MM_NX)) ./ (abs(dudx(1:MM_NU,3:MM_NX-1)) + abs(dudx(1:MM_NU,4:MM_NX)) + 1.0E-10);
    S(1:MM_NU,[2,MM_NX])=S(1:MM_NU,[MM_NX-1,3]); %periodic boundaries

    up(1:MM_NU,3:MM_NX) = ub(1:MM_NU,3:MM_NX) + (0.5 * ones(MM_NU,1)*(xo(3:MM_NX) - xo(4:MM_NX+1))) .* S(1:MM_NU,3:MM_NX);
    um(1:MM_NU,3:MM_NX) = ub(1:MM_NU,2:MM_NX-1) + (0.5 * ones(MM_NU,1)*(xo(3:MM_NX) - xo(2:MM_NX-1))) .* S(1:MM_NU,2:MM_NX-1);

    if MM_NU>1
	dfdu_p(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        dfdu_m(:,2*MM_NU+1:MM_NU*MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
        %dfdu_p(:,:,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        %dfdu_m(:,:,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
        for i=3:MM_NX
            dfdu_pv(:,i) = diag(dfdu_p(:,(i-1)*3+1:3*i));
            dfdu_mv(:,i) = diag(dfdu_m(:,(i-1)*3+1:3*i));
        end
        %for i=3:MM_NX
        %    dfdu_pv(:,i) = diag(dfdu_p(:,:,i));
        %    dfdu_mv(:,i) = diag(dfdu_m(:,:,i));
        %end
    else
        dfdu_pv(1:MM_NU,3:MM_NX) = feval(f_dfdu, up(1:MM_NU,3:MM_NX));
        dfdu_mv(1:MM_NU,3:MM_NX) = feval(f_dfdu, um(1:MM_NU,3:MM_NX));
    end

    lf(1:MM_NU,3:MM_NX) = 0.5 * (feval(f_f,um(1:MM_NU,3:MM_NX)) + feval(f_f,up(1:MM_NU,3:MM_NX)) - max(abs(dfdu_pv(1:MM_NU,3:MM_NX)), abs(dfdu_mv(1:MM_NU,3:MM_NX))) .* (up(1:MM_NU,3:MM_NX)-um(1:MM_NU,3:MM_NX)));
    rhs=feval(f_g, ub, cellaverages(xo));
    un(1:MM_NU,3:MM_NX-1) = ub(1:MM_NU,3:MM_NX-1) + dt .* ((ones(MM_NU,1)*(-1 ./ dx(3:MM_NX-1))) .* (lf(1:MM_NU,4:MM_NX) - lf(1:MM_NU,3:MM_NX-1)) + rhs(1:MM_NU,3:MM_NX-1));
    un = feval(f_boundaries, to, xo, un);

    % Combine both solutions in Heun-scheme
    un(1:MM_NU,3:MM_NX-1) = 0.5 * (un(1:MM_NU,3:MM_NX-1) + uo(1:MM_NU,3:MM_NX-1));
    un = feval(f_boundaries, to, xo, un);


case 2, % McCormack
    xa = cellaverages(xo);
    rhs=feval(f_g, uo, xa);
    f(1:MM_NU, 2:MM_NX) = feval(f_f, uo(1:MM_NU, 2:MM_NX));
    fx(1:MM_NU, 2:MM_NX-1) = (f(1:MM_NU,3:MM_NX) - f(1:MM_NU,2:MM_NX-1)) ./ (ones(MM_NU,1) * (xa(3:MM_NX) - xa(2:MM_NX-1)));

    us(1:MM_NU, 3:MM_NX-1) = uo(1:MM_NU, 3:MM_NX-1) + dt*(rhs(1:MM_NU,3:MM_NX-1) - fx(1:MM_NU,3:MM_NX-1));
    us = feval(f_boundaries, to, xo, us);

    rhss=feval(f_g, us, xa);
    fs(1:MM_NU, 2:MM_NX) = feval(f_f, us(1:MM_NU, 2:MM_NX));
    fsx(1:MM_NU, 3:MM_NX) = (f(1:MM_NU,3:MM_NX) - f(1:MM_NU,2:MM_NX-1)) ./ (ones(MM_NU,1) * (xa(3:MM_NX) - xa(2:MM_NX-1)));

    un(1:MM_NU, 3:MM_NX-1) = (uo(1:MM_NU, 3:MM_NX-1) + us(1:MM_NU, 3:MM_NX-1)) ./ 2 + (dt/2)*(rhss(1:MM_NU,3:MM_NX-1) - fsx(1:MM_NU,3:MM_NX-1));
    un = feval(f_boundaries, to, xo, un);


case 3, % easy finite differences
    rhs=feval(f_g, uo, cellaverages(xo));
    f(1:MM_NU, 2:MM_NX) = feval(f_f, uo(1:MM_NU, 2:MM_NX));
    xa = cellaverages(xo);
    fx(1:MM_NU, 3:MM_NX-1) = (f(1:MM_NU,4:MM_NX) - f(1:MM_NU,3:MM_NX-1)) ./ (ones(MM_NU,1) * (xa(4:MM_NX) - xa(3:MM_NX-1)));
    un(1:MM_NU, 3:MM_NX-1) = uo(1:MM_NU, 3:MM_NX-1) + dt*(rhs(1:MM_NU,3:MM_NX-1) - fx(1:MM_NU,3:MM_NX-1));
    un = feval(f_boundaries, to, xo, un);
end
