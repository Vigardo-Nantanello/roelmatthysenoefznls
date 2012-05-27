function D = chua(x,alpha,beta)
D=ones(3,1);
D(1)=alpha*(x(2)-chuah(x(1)));
D(2)=x(1)-x(2)+x(3);
D(3)=-beta*x(2);