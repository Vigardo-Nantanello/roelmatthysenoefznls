clear all

global cds

opt=contset;
opt=contset(opt,'MaxNumPoints',100);
opt=contset(opt,'Singularities',1);
opt=contset(opt,'Eigenvalues',1);

figure(1);clf;grid on
figure(2);clf;grid on;hold on

[x0,v0]    = init_EP_EP(@myfun1,0,-2,1);
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
figure(1);cpl(x1,v1,s1,[2 1]);

xbr = x1(1,s1(2).index);
pbr = x1(2,s1(2).index);
i   = s1(2).index;

figure(2);
plot(x1(2,1:i),x1(1,1:i),'b','linewidth',2);
plot(x1(2,i+1:end),x1(1,i+1:end),'b--','linewidth',2);
plot(pbr,xbr,'r*','linewidth',2);

[x0,v0]=init_BP_EP(@myfun1,xbr,pbr,s1(2),0.0001);
opt=contset(opt,'Backward',0);
[x1,v1,s1,h1,f1]=cont(@equilibrium,x0,[],opt);
figure(1);cpl(x1,v1,s1,[2 1]);

figure(2);
j = f1(find(f1));
n = length(j);
if sign(j(round(n/2))) == 1
    str='b--';
else
    str='b';
end
plot(x1(2,:),x1(1,:),str','linewidth',2);

opt=contset(opt,'Backward',1);
[x1,v1,s1,h1,f1]=cont(@equilibrium,x0,[],opt);
figure(1);cpl(x1,v1,s1,[2 1]);

figure(2);
j = f1(find(f1));
n = length(j);
if sign(j(round(n/2))) == 1
    str='b--';
else
    str='b';
end
plot(x1(2,:),x1(1,:),str','linewidth',2);

