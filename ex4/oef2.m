close all
clc

%% Phase plane

B = 11;
k = 0.15;
Tbegin=75;
Tend = 100;
x0=[0 0];
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
x0(1)=0.02;
func = @(t,u) duffing(u,t,k,B);
[time2,out2] = ode45(func,[0 Tend],x0);
figure(99)
plot(out(1:end,1),out(1:end,2))
xlabel('x')
ylabel('y')
saveEps('../verslag/img/ex4/duffingexample.eps',8,8)
figure(1);clf;
hold on
for i=1:6
    
    subplot(3,2,i);hold on;
    title(['interval ' num2str(i)])
    x=length(find(time<=Tbegin+i*(Tend-Tbegin)/6))
    xb=length(find(time<=Tbegin+(i-1)*(Tend-Tbegin)/6))
    
    plot(out(xb:x,1),out(xb:x,2))
    x2=length(find(time2<=Tbegin+i*(Tend-Tbegin)/6))
    x2b=length(find(time2<=Tbegin+(i-1)*(Tend-Tbegin)/6))
    
    plot(out2(x2b:x2,1),out2(x2b:x2,2),'r')

    plot(out2(x2,1),out2(x2,2),'ko','Markersize',4,'MarkerFaceColor','r')
    plot(out(x,1),out(x,2),'ko','Markersize',4,'MarkerFaceColor','b')
    xlabel('x')
    ylabel('dx/dt','rot',90)
    axis([-4 4 -10 10])
end
saveEps('../verslag/img/ex4/duffingchaoticposition.eps',18,16)
%% Time
figure(2);clf;
hold all
x=length(find(time<=75));
x2=length(find(time2<=75))
plot(time(x:end),out(x:end,1))
plot(time2(x2:end),out2(x2:end,1),'r')
axis tight
xlabel('time')
ylabel('x')
saveEps('../verslag/img/ex4/duffingchaotictimea.eps',16,6)

figure(3);clf;
hold all
plot(time(x:end),out(x:end,2))
plot(time2(x2:end),out2(x2:end,2),'r')
xlabel('time')
ylabel('dxdt')
axis tight
saveEps('../verslag/img/ex4/duffingchaotictimeb.eps',16,6)

%% Phase plane subharmonic
% 9 0.4
B = 5;
k = 0.1;
Tbegin=0;
Tend = 75;
x0=[0 0];
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
x0(1)=0.2;
func = @(t,u) duffing(u,t,k,B);
[time2,out2] = ode45(func,[0 Tend],x0);
figure(99)
plot(out(1:end,1),out(1:end,2))
xlabel('x')
ylabel('y')
% saveEps('../verslag/img/ex4/duffingexample.eps',8,8)
figure(1);clf;
hold on
for i=1:6
    
    subplot(3,2,i);hold on;
    title(['interval ' num2str(i)])
    x=length(find(time<=Tbegin+i*(Tend-Tbegin)/6))
    xb=length(find(time<=Tbegin+(i-1)*(Tend-Tbegin)/6))
    
    plot(out(xb:x,1),out(xb:x,2))
    x2=length(find(time2<=Tbegin+i*(Tend-Tbegin)/6))
    x2b=length(find(time2<=Tbegin+(i-1)*(Tend-Tbegin)/6))
    
    plot(out2(x2b:x2,1),out2(x2b:x2,2),'r')

    plot(out2(x2,1),out2(x2,2),'ko','Markersize',4,'MarkerFaceColor','r')
    plot(out(x,1),out(x,2),'ko','Markersize',4,'MarkerFaceColor','b')
    xlabel('x')
    ylabel('dx/dt','rot',90)
    axis([-4 4 -10 10])
end
% saveEps('../verslag/img/ex4/duffingchaoticposition.eps',18,16)
%% Time
figure(2);clf;
hold all
x=length(find(time<=Tbegin));
x2=length(find(time2<=Tbegin))
plot(time(x:end),out(x:end,1))
plot(time2(x2:end),out2(x2:end,1),'r')
axis tight
xlabel('time')
ylabel('x')
saveEps('../verslag/img/ex4/duffingsubharmonictimea.eps',16,6)

figure(3);clf;
hold all
plot(time(x:end),out(x:end,2))
plot(time2(x2:end),out2(x2:end,2),'r')
xlabel('time')
ylabel('dxdt')
axis tight
saveEps('../verslag/img/ex4/duffingsubharmonictimeb.eps',16,6)
