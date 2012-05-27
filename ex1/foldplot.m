function foldplot(viewangle)
%% Plot the fold curve in 3d
rowsr=20;
rowsh=200;
rmin=-0.5;
rmax=1;
hmin=-1;
hmax=1;
rs=linspace(rmin,rmax,rowsr);
hs=linspace(hmin,hmax,rowsh);
currentrow=zeros(rowsr,rowsh,3);
figure(99);
hold on
for i=1:rowsr;
    r=rs(i);
    for j=1:rowsh;
        h=hs(j);
        currentrow(i,j,:)=sort(roots([-0.5 0 r h]));
        for k=1:3,
            if(~isreal(currentrow(i,j,k)))
                currentrow(i,j,k)=NaN;
            end
        end
    end
    cr=squeeze(currentrow(i,:,:));
    crb=cr;
    crb(isnan(cr))=[];
    crb=sort(crb);
    rplot=ones(1,numel(crb))*r;
    uplot=zeros(1,numel(crb));
    hplot=zeros(1,numel(crb));
    for i=1:numel(crb(:))
        m=crb(i);
        [i1,i2]=find(cr==m);
        uplot(i)=m;
        hplot(i)=hs(i1);
    end
    for i=1:3,
        plot3(rplot,hplot,uplot);
    end
end
axis tight
xlabel('r');ylabel('h');zlabel('u')
grid on
view(viewangle,25)
set(gca,'Box','off')
saveEps('../verslag/img/ex1/foldsurface.eps',8,8)