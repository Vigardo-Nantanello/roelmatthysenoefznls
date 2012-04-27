function out = myfun1
out{1} = @init;
out{2} = @fun_eval;
out{3} = @jacobian;
out{4} = [];
out{5} = [];
out{6} = [];
out{7} = [];
out{8} = [];
out{9} = [];

% -------------------------------------------------------------------------
function dydt = fun_eval(t,x,r)
dydt = r*x - (x/(1+x^2));

% -------------------------------------------------------------------------
function [tspan,y0,options] = init
y0=[0,0];

options = odeset;
handles = feval(myfun1);
tspan = [0 10];

% -------------------------------------------------------------------------
function jac = jacobian(t,x,r)

jac = r - ((1 - x^2)/(1+x^2)^2);