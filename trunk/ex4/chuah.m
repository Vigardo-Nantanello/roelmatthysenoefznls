function H = chuah(x)
a=-0.8/0.7+1;
b=-.5/0.7+1;
H=zeros(length(x),1);
for i=1:length(x)
    if(x(i)>1)
        H(i)=b*x(i)+a-b;
    end
    if(abs(x(i))<=1)
        H(i)=a*x(i);
    end
    if(x(i)<-1)
        H(i)=b*x(i)-a+b;
    end
end