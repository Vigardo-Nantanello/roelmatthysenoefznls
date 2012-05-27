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
results = zeros(samples,steps);
x =linspace(0,1.5,samples);
figure;
hold on
for i = 1:samples,
    [tout,yout] = ode45(odepop,[0 20],x(i));
    h1=plot(tout,yout)
end
h2=plot(tout,ones(size(tout),1)*0.2,'k')
h3=plot(tout,ones(size(tout),1)*1,'r')
h3=plot(tout,ones(size(tout),1)*0,'r')
hold off
ylabel('x_0','Rotation',-270)
xlabel('time')
legend([h1 h2 h3],'Simulations','Unstable Equilibrium','Stable Equilibrium')
saveEps('../verslag/img/ex3/preyonly.eps',12,12)


%% 2 Analytic analysis (Jacobian plot)
points = 100;
b = linspace(-0.1,1.2,points);
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
saveEps('../verslag/img/ex3/eigvalues',12,8)
% Trace and determinant
figure;
hold on
plot(b,[-2*b.^2+1.2*b; b.*(1-b).*(b-0.2)])
plot(b,zeros(size(b),1),'k-')
axis([0.1 1.1 -0.5 0.2])
legend('trace','determinant','Location','SouthWest')
saveEps('../verslag/img/ex3/tracedeterminant.eps',12,8)
%% other stable points
jacobian = @(x,y) [-y+(x-0.2)*(1-x)+x(1-x)-x(x-0.2) -x; y x-b];
x = [0 0; 0.2 0; 1 0];

%% Trajectory of b
b=-0.1:0.01:1.1
figure;
hold on
plot(b,(b-0.2).*(1-b))
plot(b,ones(size(b))*0,'k')
line([0 0],[-10000 10000],'Color','k')
axis([-0.1 1.1 -0.2 0.2])
plot(0,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(0.2,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(1,0,'ro','Markersize',5,'MarkerFaceColor','r')
xlabel('b')
ylabel('(b-0.2)(1-b)')
saveEps('../verslag/img/ex3/btrajectory')

%% Separatrices - b=0.5

b=0.5;
out = minpreyb;
f = @(t,x) out{2}(t,x,b,0)
p0=[1/(5*(b-1/25)); 1];
x02=[0.2;0];
[tout yout]=ode45(f,[0 100],x02+0.01*p0)
[tout2 yout2]=ode45(f,[0 15],x02-0.01*p0)
figure;
hold all
h=area([-0.5 1.5],[1 1])
set(h,'Basevalue',-1)
set(h,'FaceColor',[1 1 1])
x1=[flipdim(yout2(:,1),1); linspace(0.2,1.5,100)'];
y1=[flipdim(yout2(:,2),1); linspace(0,0,100)'];
h=area(x1,y1)
set(h,'Basevalue',-1)
set(h,'FaceColor',[0.6 0.6 0.6])
x=[flipdim(yout2(:,1),1); yout(:,1)]; y=[flipdim(yout2(:,2),1); yout(:,2)]
plot(x,y)
line([-100 100],[0 0],'Color','k')
line([0 0],[-100 100],'Color','k')
plot(0,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(0.2,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(1,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(b,(b-0.2)*(1-b),'ro','Markersize',5,'MarkerFaceColor','r')
axis([-0.5 1.5 -1 1]);
xlabel('x')
ylabel('y')
legend('Region of attraction for the origin','Repulsion region')
saveEps('../verslag/img/ex3/separatrices1.eps',8,8)


%% Separatrices - b=0.65

b=0.65;
out = minpreyb;
f = @(t,x) out{2}(t,x,b,0)
p0=[1/(5*(b-1/25)); 1];
x02=[0.2;0];
[tout yout]=ode45(f,[0 100],x02+0.01*p0)
[tout2 yout2]=ode45(f,[0 15],x02-0.01*p0)
figure;
hold all
h=area([-0.5 1.5],[1 1])
set(h,'Basevalue',-1)
set(h,'FaceColor',[1 1 1])
x=[flipdim(yout2(:,1),1); yout(:,1)]; y=[flipdim(yout2(:,2),1); yout(:,2)]
h=area(x,y)
set(h,'Basevalue',-1)
set(h,'FaceColor',[0.8 0.8 0.8])
x1=[flipdim(yout2(:,1),1); linspace(0.2,1.5,100)'];
y1=[flipdim(yout2(:,2),1); linspace(0,0,100)'];
h=area(x1,y1)
set(h,'Basevalue',-1)
set(h,'FaceColor',[0.6 0.6 0.6])
x=[flipdim(yout2(:,1),1); yout(:,1)]; y=[flipdim(yout2(:,2),1); yout(:,2)]
plot(x,y)
line([-100 100],[0 0],'Color','k')
line([0 0],[-100 100],'Color','k')
plot(0,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(0.2,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(1,0,'ro','Markersize',5,'MarkerFaceColor','r')
plot(b,(b-0.2)*(1-b),'ro','Markersize',5,'MarkerFaceColor','r')
axis([-0.5 1.5 -1 1]);
xlabel('x')
ylabel('y')
legend('Region of attraction for the origin','Region of attraction for the spiral','Repulsion region')
saveEps('../verslag/img/ex3/separatrices2.eps',8,8)

%% Bifucation of

figure;hold on;
b=0.52;
out = minpreyb;
f = @(t,x) out{2}(t,x,b,0)
p0=[1/(5*(b-1/25)); 1];
x02=[0.2;0];
[tout yout]=ode45(f,[0:0.01:100],x02+0.01*p0)
plot(yout(:,1),yout(:,2),'k','Linewidth',1.2)
b=0.538195;
f = @(t,x) out{2}(t,x,b,0)
p0=[1/(5*(b-1/25)); 1];
x02=[0.2;0];
[tout yout]=ode45(f,[0:0.01:45],x02+0.01*p0)
plot(yout(:,1),yout(:,2),'k','Linewidth',1.2)
b=0.56;
f = @(t,x) out{2}(t,x,b,0)
p0=[1/(5*(b-1/25)); 1];
x02=[0.2;0];
[tout yout]=ode45(f,[0:0.01:100],x02+0.01*p0)
plot(yout(:,1),yout(:,2),'k','Linewidth',1.2)
line([-100 100],[0 0],'Color','k','Linewidth',1.2)
line([0 0],[-100 100],'Color','k','Linewidth',1.2)
plot(0.2,0,'ko','Markersize',6,'MarkerFaceColor','w')
plot(1,0,'ko','Markersize',6,'MarkerFaceColor','w')
axis([-0.1 1.1 -0.1 0.5])
axis off
saveEps('../verslag/img/ex3/homoclinicmanfold.eps',8,5)

%% Homoclinic bifurcation

figure;hold on;
out = minpreyb;
b=0.538195;
f = @(t,x) out{2}(t,x,b,0);
p0=[1/(5*(b-1/25)); 1];
x02=[0.2;0];
[tout yout]=ode45(f,[0:0.01:45],x02+0.01*p0);
plot(yout(:,1),yout(:,2),'k','Linewidth',1.2)
bs=[0.555 0.57 0.585];
for i=1:numel(bs)
    b=bs(i);
    out = preyb;
    f = @(t,x) out{2}(t,x,b,0);
    p0=[0.2+0.1;0.01];
    x02=[0.2;0];
    [tout yout]=ode45(f,[0:1:200000],p0);
    plot(yout(end-50:end,1),yout(end-50:end,2),'k','Linewidth',1.2)
end
line([-100 100],[0 0],'Color','k','Linewidth',1.2)
line([0 0],[-100 100],'Color','k','Linewidth',1.2)
plot(0.2,0,'ko','Markersize',6,'MarkerFaceColor','w')
plot(1,0,'ko','Markersize',6,'MarkerFaceColor','w')
axis([-0.1 1.1 -0.1 0.5])
axis off
saveEps('../verslag/img/ex3/homoclinicorbits.eps',8,5)

%% Plot orbits
load('ppdata')
figure(1);clf;hold all;
ppdata=ppdata2;
colors=((ppdata.x(2:end)-ppdata.x(1:end-1)).^2+(ppdata.y(2:end)-ppdata.y(1:end-1)).^2);
plot(colors)
colors=(colors-min(colors))./(max(colors)-min(colors));
colors1=colors;
figure(2);clf;hold all;
for i=1:numel(ppdata.x)-1,
    plot([ppdata.x(i) ppdata.x(i+1)],[ppdata.y(i) ppdata.y(i+1)],'Linewidth',2,'Color',[colors(i) 1-colors(i) 1-colors(i)])
    [colors(i) 1 1]
end
ppdata=ppdata3;
colors=((ppdata.x(2:end)-ppdata.x(1:end-1)).^2+(ppdata.y(2:end)-ppdata.y(1:end-1)).^2);
figure(1);
plot(colors)
axis([50 500 0 1.8*10^(-4)])
legend('Close to heteroclinic')
legend('Close to harmonic')
xlabel('time')
ylabel('speed')
saveEps('../verslag/img/ex3/speeds.eps',12,8)
colors=(colors-min(colors1))./(max(colors1)-min(colors1));
figure(2);
for i=1:numel(ppdata.x)-1,
    plot([ppdata.x(i) ppdata.x(i+1)],[ppdata.y(i) ppdata.y(i+1)],'Linewidth',2,'Color',[colors(i) 1-colors(i) 1-colors(i)])
    [colors(i) 1 1]
end
xlabel('x')
ylabel('y')
saveEps('../verslag/img/ex3/coloredorbits.eps',12,8)

