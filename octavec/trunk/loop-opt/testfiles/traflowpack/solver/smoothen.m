function w = smoothen(w)
global MM_NX;

% 3-point smoother
w(3:MM_NX-1) = (w(2:MM_NX-2) + 2*w(3:MM_NX-1) + w(4:MM_NX))/4;
