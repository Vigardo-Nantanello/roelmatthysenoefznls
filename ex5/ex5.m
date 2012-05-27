% Eerste waarden 
A=4.5;
B=7;
Du=1;
Dv=8;

nu=sqrt(Du/Dv)
(sqrt(A^2+1)-1)/A
(1+A*nu)^2
as = 0:0.01:9;
bh=1+as.^2;
bt=(1+nu.*as).^2;
figure;
hold on
plot(as,bh,'b--')
plot(as,bt,'r--')
hold off

%% 
A=sym('A')
B=sym('B')
eig([B-1 A^2; -B -A^2])