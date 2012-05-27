function f=ratio(x,reltime)
x=(x/reltime)*16;
f=zeros(size(x));
i1=find(x<8);
i2=find(x>8);
f(i1)=0.6+floor(x(i1))*0.2;
f(i2)=2-floor(x(i2)-9)*0.2;
    
