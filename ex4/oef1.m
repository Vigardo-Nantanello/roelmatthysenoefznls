st = 0.01;
kkmax = 10000;
x = [0.5 0.5 0.5]';
lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode1)
lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode2)
lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode3)
lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode4)
lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode5)