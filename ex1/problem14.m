seq=zeros(1,1000000);
for i=1:1000000,
    n=i;
    while(n~=1)
        if(mod(n,2)==0)
            n=n/2;
        else
            n=3*n+1;
        end
        seq(i)=seq(i)+1;
    end
end
plot(seq)