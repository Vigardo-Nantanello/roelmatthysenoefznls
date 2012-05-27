close all

%% Calling the nonlinear model
out = aeronlin;

% Model parameters
A1 = 0.04695;
Vc = 2/A1;

mtime=300;
tspan = [0 mtime];
sub = 16;


% Axis options
aw = [-3.6 3.6 -36 36];
xw = aw(2)-aw(1);
yw = aw(4)-aw(3);
% Generating phase portrait
y0=[2 2];
f = @(t,x) out{2}(t,x,ratio(t,mtime))
[tout yout] = ode45(f,tspan,y0);
figure;
l=round(linspace(1,numel(tout),sub));
for i=1:sub
    subplot(4,4,i)
    hold on
    index = find(tout < mtime/(sub)*i & tout > mtime/sub*(i-1));
    plot(yout(index,1),yout(index,2),'k')
    plot(yout(index(1),1),yout(index(1),2),'ro','Markersize',2,'MarkerFaceColor','r')
%     plot(yout(index(end),1),yout(index(end),2),'ro','Markersize',2,'MarkerFaceColor','r')
    plot(yout(index(end-80:end),1),yout(index(end-80:end),2),'g')
    h = title(['V/V_C = ' num2str(ratio(tout(index(floor(length(index)/2))),mtime))]);
    axis(aw)
    axis square
    axis off
end
saveEps('../verslag/img/ex2/27.eps',18,18)
figure;
subplot(2,1,1)
plot(tout,yout)
xlabel('time')
ylabel('ydot and y','rot',90)
subplot(2,1,2)
plot(tout,ratio(tout,mtime))
xlabel('time')
ylabel('V/Vc','rot',90)

saveEps('../verslag/img/ex2/27b.eps',16,12)
