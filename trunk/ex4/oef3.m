%% Phase plane

t=[-2:0.05:2]
c=chuah(t)
plot(t,chuah(t))


alpha = 9;
beta = 7/(0.7)^2;
Tend = 200;
x0=[0.5 0.5 0.5];
func = @(t,u) chua(u,alpha,beta);
[time,out] = ode45(func,[0 Tend],x0);
figure;
hold all
plot3(out(:,1),out(:,2),out(:,3));
grid on
legend('statespace chaos')
% 
% x0(1)=0.02;
% func = @(t,u) duffing(u,t,k,B);
% [time,out] = ode45(func,[0 Tend],x0);
% plot(out(:,1),out(:,2),'r')