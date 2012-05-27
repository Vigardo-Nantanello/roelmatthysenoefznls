% Nonlinear Systems - 2012
% Example Script - Numerical Bifurcation analysis
%   Exercise: 3.2
%   System:
%             x' = x*(x - 0.2)*(1 - x) - x*y;
%             y' = x*y - b*y - d;
%
%             See also preyb.m in Systems folder
%
%!! Case:     b is used as a parameter, d is fixed
%             In this script d = 0;
%
%!! Goal:     Draw solution branches using b as a parameter
%
%!! Use:      This script is not complete !
%
%!! More details about MATCONT routines:
%   see CL MATCONT manual

% Version: April, 2012
% nico.scheerlinck@cs.kuleuven.be

clear all
close all
global cds

init;
opt=contset;
opt=contset(opt,'MaxNumPoints',500);
opt=contset(opt,'InitStepsize',0.01);
opt=contset(opt,'MinStepsize',0.001);
opt=contset(opt,'MaxStepsize',0.002);
opt=contset(opt,'Singularities',1);
opt=contset(opt,'Eigenvalues',1);

% fix parameter d here!
d = 0.01;
binit = 0.1;
out=preyb;
f = @(x) out{2}(0,x,0.1,d);
%% x=0.2
xstart = fsolve(f,[0.2;0]);

% Initialisation (0,0)
[x0,v0]          = init_EP_EP(@preyb,xstart,[binit;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);axis([-1 2 -1 2])
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);axis([-1 2 -0.5 0.5])
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);opt=contset(opt,'Backward',1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);

%% x=1
binit=1.5;
f = @(x) out{2}(0,x,binit,d);
xstart = fsolve(f,[1.5;1.5]);
opt=contset(opt,'Backward',0);
% Initialisation (0,0)
[x0,v0]          = init_EP_EP(@preyb,xstart,[binit;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);axis([-1 2 -1 2])
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);axis([-1 2 -0.5 0.5])
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);opt=contset(opt,'Backward',1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);

%% x=0.2 .4
binit=1;
f = @(x) out{2}(0,x,binit,d);
xstart = fsolve(f,[0.2;-0.04]);
opt=contset(opt,'Backward',0);
% Initialisation (0,0)
[x0,v0]          = init_EP_EP(@preyb,xstart,[binit;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);axis([-1 2 -1 2])
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);axis([-1 2 -0.5 0.5])
cpl(x1,v1,s1,[3 2]);
figure(3);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);
opt=contset(opt,'Backward',1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);
%% Continue at last BP
% Initialise continuation at a branch point
xbr = x1(1:2,s1(2).index);
pbr = x1(3,s1(2).index);
i   = s1(2).index;
opt=contset(opt,'Backward',1);
[x0,v0] = init_BP_EP(@preyb,xbr,[pbr;d],s1(2),0.01);
% Continuation from a branch point
[x1,v1,s1,h1,f1]=cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
figure(1);cpl(x1,v1,s1,[3 1]);
figure(2);cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);
opt=contset(opt,'Backward',0);
% Continuation from a branch point
[x1,v1,s1,h1,f1]=cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
figure(1);cpl(x1,v1,s1,[3 1]);
figure(2);cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);
%% Other branches
binit=0.12;
f = @(x) out{2}(0,x,binit,d);
xstart = fsolve(f,[0;-0.08]);
opt=contset(opt,'Backward',0);
% Initialisation (0,0)
[x0,v0]          = init_EP_EP(@preyb,xstart,[binit;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);axis([-1 2 -1 2])
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);axis([-1 2 -0.5 0.5])
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);opt=contset(opt,'Backward',1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);
%% Other branches
binit=-0.12;
f = @(x) out{2}(0,x,binit,d);
xstart = fsolve(f,[0;+0.08]);
opt=contset(opt,'Backward',0);
% Initialisation (0,0)
[x0,v0]          = init_EP_EP(@preyb,xstart,[binit;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);axis([-1 2 -1 2])
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);axis([-1 2 -0.5 0.5])
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);opt=contset(opt,'Backward',1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
% x,y versus b
figure(3);
cpl(x1,v1,s1,[3 2 1]);

%% Draw original solutions
figure(1)
line([-1.5 2],[0 0],'Linestyle','--','Color','k')
line([-1.5 2],[0.2 0.2],'Linestyle','--','Color','k')
line([-1.5 2],[1 1],'Linestyle','--','Color','k')
line([-1.5 2],[-1.5 2],'Linestyle','--','Color','k')
figure(2)
hold on
line([0 0],[-1.5 2],'Linestyle','--','Color','k')
line([-1.5 2],[0 0],'Linestyle','--','Color','k')
bs=-1.5:0.01:2;
plot(bs,(bs-0.2).*(1-bs),'Linestyle','--','Color','k')

%% Save figures
figure(1)
saveEps('../verslag/img/ex3/bifposx.eps',8,8)
figure(2)
saveEps('../verslag/img/ex3/bifposy.eps',8,8)

