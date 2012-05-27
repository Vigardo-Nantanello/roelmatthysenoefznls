function res = cpl2dnoline(x,v,s)
for i=2:size(s,1)-1
    if(strcmp(s(i).msg,'Neutral saddle'))
        s(i)=[];
    end
end
x=flipdim(x,1);
line(x(1,cat(1,s(2:end-1).index)),x(2,cat(1,s(2:end-1).index)),'linestyle','o','color','r','Markersize',4,'MarkerFaceColor','r');
d=axis;
if size(s,1)~=2
    skew = 0.03*[d(2)-d(1) d(4)-d(3)];
    for i=2:size(s,1)-1
        sloc=s(i);
        sloc.index
        x(1,sloc.index)
        x(2,sloc.index)
        text( x(1,sloc.index)+skew(1),x(2,sloc.index)+skew(2), [sloc.label]);
     %   line([x(1,sloc.index) x(1,sloc.index)+skew(1)],[x(2,sloc.index) x(2,sloc.index)+skew(2)])
    end
end
res =2;