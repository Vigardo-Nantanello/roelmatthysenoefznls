function out = preyb
out{1} = @init;
out{2} = @fun_eval;
out{3} = [];
out{4} = [];
out{5} = [];
out{6} = [];
out{7} = [];
out{8} = [];
out{9} = [];

function dzdt = fun_eval(t,z,b,d);
x = z(1);
y = z(2);

dxdt = x*(x - 0.2)*(1 - x) - x*y;
dydt = x*y - b*y - d;

dzdt = [dxdt;dydt];

% --------------------------------------------------------------------------
function [tspan,y0,options] = init
handles = feval(preyb);
y0=[0,0];
options = odeset('Jacobian',[],'JacobianP',[],'Hessians',[],'HessiansP',[]);
tspan = [0 10];

