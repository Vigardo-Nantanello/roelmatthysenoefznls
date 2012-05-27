st = 0.05;
kkmax = 8000;
x = [0.5 0.5 0.5]';
figure;
lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode5)
xlabel('time')
ylabel('Lyapunov exponents','rot',90)
saveEps('../verslag/img/ex4/lyaplorenz.eps',12,8)
%%
% figure;
% lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode2)
% figure;
% lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode3)
% figure;
% lyap = lyapunov(@rhs_lorenz,st,kkmax,x, @ode4)
%%
figure;
lyapex=[0.9 0 -14.57];
st = 0.05;
kkmax = 8000;
hold all
sts=0.05:0.005:0.1;
for i=1:numel(sts)
    st=sts(i);
    lyap(i,:) = lyapunovb(@rhs_lorenz,st,kkmax*0.05/st,x, @ode5)-lyapex;
end
%% 
plot(sts,abs(lyap))
legend('Error \lambda_1','Error \lambda_2','Error \lambda_3')
xlabel('st')
ylabel('Absolute Error','rot',90)
saveEps('../verslag/img/ex4/lyapst.eps',8,8)

%%
figure;
clear lyap
lyapex=[0.9 0 -14.57];
st = 0.05;
kkmaxs = 2000:1000:10000;
hold all
st=0.05;
for i=1:numel(kkmaxs)
    kkmax=kkmaxs(i);
    lyap(i,:) = lyapunovb(@rhs_lorenz,st,kkmax*0.05/st,x, @ode5)-lyapex;
end

%% 
plot(kkmaxs,abs(lyap))
legend('Error \lambda_1','Error \lambda_2','Error \lambda_3')
xlabel('kkmax')
ylabel('Absolute error','rot',90)
saveEps('../verslag/img/ex4/lyapkkmax.eps',8,8)
