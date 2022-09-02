function [e, x]=dots(a,b,teta,numb,num_dots)

%   [E] = DOTS(A,B,TETA,NUMB)  generate num_dots random points x= (x1,x2)
%   -1<= x1 <= 1, and -1 =< x2 <= 1 ;
%   and plots the random dot pattern surimposed on NUMB iterations of
%   its transformation by a rescaling A in the x coordinates,
%   B in the y coordinates and a rotation TETA.
%   The output E is the calculated eigenvalues of the transformation.

%   Copyright 2003
%   Centre for Nonlinear Dynamics in Physiology and Medicine

x=ones(2,num_dots)-2*rand(2,num_dots);
%R: transformation rotating the points with angle teta
R=[cos(teta)  -sin(teta);
    sin(teta)    cos(teta)];

%S: stretching of factor a in x1 and b in x2 direction
S=[a 0;
    0 b];

%rotate the randomly generated points numb of times
%numb=4;

for i=1:numb
    xnew=R*S*x;
    x=[x xnew];
end;

e=eig(R*S);
