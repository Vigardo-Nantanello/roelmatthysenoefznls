clear all
close all
k=1;
L_0=1;
x=-1:0.01:1
a=0.5;
figure(1);hold on
plot([0 0],[-2 2],'Color','k')
plot([-2 2],[0 0],'Color','k')
plot(sqrt(L_0^2-a^2),0,'ko','MarkerSize',4,'MarkerFaceColor','k')
plot(-sqrt(L_0^2-a^2),0,'ko','MarkerSize',4,'MarkerFaceColor','k')
plot(0,0,'ko','MarkerSize',4,'MarkerFaceColor','w')
plot(x,-k*x.*(1-L_0./(sqrt(x.^2+a^2))),'k')
axis([-1 1 -0.3 0.3])
axis off
saveEps('../verslag/img/ex1/stab1.eps',8,6)
a=1.5;
figure(2);hold on
plot([0 0],[-2 2],'k')
plot([-2 2],[0 0],'k')
plot(x,-k*x.*(1-L_0./(sqrt(x.^2+a^2))),'k')
plot(0,0,'ko','MarkerSize',4,'MarkerFaceColor','k')
axis([-1 1 -0.5 0.5])
axis off
saveEps('../verslag/img/ex1/stab2.eps',8,6)

%% Draw bifurcation diagram
k=1;
a=0.1;
L_0=-0.1:0.001:0.5;
figure(3);clf;hold on
plot([0 0],[-5 5],'k')
plot(L_0,real(sqrt(L_0.^2-a^2)),'k')
plot(L_0,-real(sqrt(L_0.^2-a^2)),'k')
plot([a 100],[0 0],'k--')
axis([-0.1 0.5 -0.5 0.5])
text(a,-0.1,'a')
text(0.4,-0.12,'L_0')
text(0.02,0.4,'x')
axis off
saveEps('../verslag/img/ex1/bif1.eps',8,6)

%% Simulate system
epsilons=[0 0.5 1 2];
x0s=[0.4 0 -0.4];
figure(1);clf;
hold on
for j=1:4
    colors=['r';'k';'c';'g';'c'];
    epsilon = epsilons(j);
    R=0.6463;
    f=@(t,x) [x(2); -1/epsilon*(x(2)+(1-R/(sqrt(1+x(1)^2)))*x(1))];
    fs=@(t,x) -(1-R/(sqrt(1+x(1)^2)))*x(1);
    tspan=[0 15];
    
    for i=1:numel(x0s)
        x0=[x0s(i);0];
        [tout yout]=ode45(f,tspan,x0)
        [touts youts]=ode45(fs,tspan,x0(1))
        plot(touts,youts,colors(i),'Linewidth',2)
        
        plot(tout,yout(:,1),colors(i))
        if(i==3)
            legend('First order','Full system')
        end
        
    end
    xlabel('time')
    ylabel('u','Rotation',90)
end
saveEps(['../verslag/img/ex1/epsilon'],12,8)
figure(2);clf;
hold on
for j=1:4
    colors=['r';'k';'c';'g';'c'];
    
    epsilon = epsilons(j);
    R=0.6463;
    f=@(t,x) [x(2); -1/epsilon*(x(2)+(1-R/(sqrt(1+x(1)^2)))*x(1))];
    fs=@(t,x) -(1-R/(sqrt(1+x(1)^2)))*x(1);
    tspan=[0 15];
    
    for i=1:numel(x0s)
        x0=[x0s(i);fs(0,x0s(i))];
        [tout yout]=ode45(f,tspan,x0)
        [touts youts]=ode45(fs,tspan,x0(1))
        plot(touts,youts,colors(i),'Linewidth',2)
        
        plot(tout,yout(:,1),colors(i))
        if(i==3)
            legend('First order','Full system')
        end
    end
    xlabel('time')
    ylabel('u','Rotation',90)
end
saveEps(['../verslag/img/ex1/epsilon2'],12,8)

%% Extra plots 1.3.2
u=-2:0.01:2
hs=[-0.15 0 0.15];
Rs=[0.9 1.2];
close all
r=Rs(2)-1;
hc=0.0465;
for j=1:2
    R=Rs(j);
    figure(j);hold on;
    
    for i=1:numel(hs)
        h=hs(i);
        f=@(u) u*R./(sqrt(1+u.^2)) - u + h;
        plot(u,f(u),'k--')
    end
    if(j==2)
        f=@(u) u*R./(sqrt(1+u.^2)) - u + hc;
            plot(u,f(u),'r--')

    end
    f=@(u) u*R./(sqrt(1+u.^2)) - u;
    plot(u,f(u),'k','Linewidth',2)
    axis([-1.5 1.5 -0.5 0.5])
    line([0 0],[-1 1],'Color','k')
    line([-2 2],[0 0],'Color','k')
    axis off
    saveEps(['../verslag/img/ex1/graphR' num2str(j)],8,6)
end

%%  h_c(r)
figure(3);clf; hold on
r=0:0.01:0.5;
hc = @(r) 2/3*r.*sqrt(2/3*r);
u=-100:0.01:100;
plot(r,hc(r),'k')
plot((1+u.^2).^(3/2)-1,-u.^3,'g')
plot(r,-hc(r),'k')
axis tight
axis([-0.1 0.5 -0.2 0.2])
grid on
xlabel('r')
ylabel('h_c(r)','Rotation',90)
legend('Approximate solution','Exact equations','Location','NorthWest')
saveEps('../verslag/img/ex1/simplebif.eps',10,8)
