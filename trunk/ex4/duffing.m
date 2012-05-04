function D = duffing(u,t,k,B)
D= ones(2,1);
D(1) =  u(2);
D(2) = B*cos(t)-k*u(2)-u(1)^3;