clear all
close all
clc


%% 0. Tekenen van afgeleide
pop = @(x) x.*(x-0.2).*(1-x);
x= linspace(0,1.5,100);
figure;
hold on
plot(x,pop(x))
plot(x,zeros(size(x),1),'r')
hold off


        
%% 1.b Numerical Simulation ode45
odepop = @(t,x) x.*(x-0.2).*(1-x);

steps = 200;
samples = 50;
results = zeros(samples,steps)
x =linspace(0,1.5,samples);
figure;
hold on
for i = 1:samples,
    [tout,yout] = ode45(odepop,[0 20],x(i));
    plot(tout,yout)
end
plot(tout,ones(size(tout),1)*0.2,'k')
plot(tout,ones(size(tout),1)*1,'r')
hold off

%% 2 Analytic analysis (Jacobian plot)
points = 100;
b = linspace(0,1,points);
rval = zeros(4,points);
for i=1:points
    r=roots([1 -b(i)*(1.2-2*b(i)) b(i)*(1-b(i))*(b(i)-0.2)]);
    rval(1:2,i) = real(r);
    rval(3:4,i) = imag(r);
end
figure;
hold on
plot(b,rval)
plot(b,zeros(size(b),1),'k-')
legend('real \lambda_1','real \lambda_2','imag \lambda_1','imag \lambda_2','Location','SouthEast')
    
%% other stable points
jacobian = @(x,y) [-y+(x-0.2)*(1-x)+x(1-x)-x(x-0.2) -x; y x-b];
x = [0 0; 0.2 0; 1 0];
        