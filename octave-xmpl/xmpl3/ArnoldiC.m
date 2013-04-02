function [V,H,f] = ArnoldiC(A,k,v);
%
%   Input:  A -- an n by n matrix
%           k -- a positive integer (k << n assumed)
%           v -- an n  vector (v .ne. 0 assumed)
%
%   Output: V -- an n by k orthogonal matrix
%           H -- a k by k upper Hessenberg matrix
%           f -- an n vector
%
% 
%           with   AV = VH + fe_k'
%
%           assures V'V = I_k with  DGKS correction
%
%
%   D.C. Sorensen
%   10 Feb 00
%
    n = length(v);
    H = zeros(k);
    V = zeros(n,k);

    v = v/norm(v);
    w = A*v;
    alpha = v'*w;
    

    f = w - v*alpha;
        c = v'*f;
        f = f - v*c;
        alpha = alpha + c;

    V(:,1) = v; H(1,1) = alpha;
        

    for j = 2:k,
       
        beta = norm(f);
        v = f/beta;
        
        H(j,j-1) = beta; 
        V(:,j)   = v;

        w = A*v;
        h = V(:,1:j)'*w;
        f = w - V(:,1:j)*h;
            c = V(:,1:j)'*f;
            f = f - V(:,1:j)*c;
            h = h + c;

        H(1:j,j) = h;

    end 
        
