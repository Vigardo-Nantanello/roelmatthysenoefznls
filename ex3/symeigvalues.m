b=sym('b','real')
%% 0,0
disp('0,0')
J=[-0.2 0; 0 -b];
[V,D]=eig(J)
D=diag(D);
trace=sum(D)
determinant = J(1,1)*J(2,2)-J(2)*J(3)

%% 0.2,0

disp('0.2,0')
J=[0.16 -0.2; 0 0.2-b];
[V,D]=eig(J)
D=diag(D);
trace=sum(D)
determinant = J(1,1)*J(2,2)-J(2)*J(3)
%% 1,0

disp('1,0')
J=[-0.8 0; -1 1-b];
[V,D]=eig(J)
D=diag(D);
trace=sum(D)
determinant = J(1,1)*J(2,2)-J(2)*J(3)

