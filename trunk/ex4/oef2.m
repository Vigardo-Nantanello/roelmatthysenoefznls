close all
clc

%% Phase plane

B = 11;
k = 0.15;
Tend = 200;
x0=[0 0];
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
figure;
hold all
plot(out(:,1),out(:,2))
legend('statespace chaos')

x0(1)=0.02;
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
plot(out(:,1),out(:,2),'r')

%% Time

x0=[0 0];
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
figure;
hold all
plot(time,out(:,1))
legend('statespace chaos')

x0(1)=0.02;
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
plot(time,out(:,1),'r')

%% Phase plane subharmonic

B = 9;
k = 0.4;
Tend = 2000;
x0=[0 0];
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
figure;
hold all
plot(out(:,1),out(:,2))
legend('statespace chaos')

x0(1)=0.02;
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
plot(out(:,1),out(:,2),'r')

%% Time subharmonic

x0=[0 0];
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
figure;
hold all
plot(time,out(:,1))
legend('statespace chaos')

x0(1)=0.02;
func = @(t,u) duffing(u,t,k,B);
[time,out] = ode45(func,[0 Tend],x0);
plot(time,out(:,1),'r')
