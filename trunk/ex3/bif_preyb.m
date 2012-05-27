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
opt=contset(opt,'MaxStepsize',0.005);
opt=contset(opt,'Singularities',1);
opt=contset(opt,'Eigenvalues',1);

% fix parameter d here!
d = 0;


%% 0,0

% Initialisation (0,0)
[x0,v0]          = init_EP_EP(@preyb,[0;0],[0.1;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
figure(3);
opt=contset(opt,'Backward',1)
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
figure(3);

%% 1,0
opt=contset(opt,'Backward',0)
% Initialisation (1,0)
[x0,v0]          = init_EP_EP(@preyb,[1;0],[0.1;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);

% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
figure(3);

% Initialisation
[x0,v0]          = init_EP_EP(@preyb,[0.2;0],[0.1;d],1);
% First continuation
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
s4=s1
% Draw solution branch:
% x versus b
figure(1);
cpl(x1,v1,s1,[3 1]);
% y versus b
figure(2);
cpl(x1,v1,s1,[3 2]);
figure(3);
%% Branch point
% Initialise continuation at a branch point
xbr = x1(1:2,s1(2).index);
pbr = x1(3,s1(2).index);
i   = s1(2).index;
opt=contset(opt,'Backward',1);
[x0,v0] = init_BP_EP(@preyb,xbr,[pbr;0],s1(2),0.01);
% Continuation from a branch point
[x1,v1,s1,h1,f1]=cont(@equilibrium,x0,[],opt);
% Draw solution branch:
figure(1);cpl(x1,v1,s1,[3 1]);
axis([0.1 1.5 -0.1 1.5])
figure(2);cpl(x1,v1,s1,[3 2]);
axis([0.1 1.5 -0.7 0.5])
opt=contset(opt,'Backward',0);

% Continuation from a branch point
[x1,v1,s1,h1,f1]=cont(@equilibrium,x0,[],opt);
% Draw solution branch:
figure(1);cpl(x1,v1,s1,[3 1]);
axis([0.1 1.5 -0.1 1.5])
saveEps('../verslag/img/ex3/bifx.eps',8,8)
figure(2);cpl(x1,v1,s1,[3 2]);
axis([0.1 1.5 -0.7 0.5])
saveEps('../verslag/img/ex3/bify.eps',8,8)
%% LIMIT CYCLES
% Initialise continuation at a HOPF POINT
figure;
xbr = x1(1:2,s1(2).index)
pbr = x1(3,s1(2).index)
i   = s1(2).index;
[xh,vh]=init_H_LC(@preyb,xbr,[pbr d],1,0.001,20,4)
opt = contset
opt = contset(opt,'MaxNumPoints',200);
opt = contset(opt,'Multipliers',1);
opt = contset(opt,'Adapt',1);
[xlc,vlc,slc,hlc,flc]=cont(@limitcycle,xh,vh,opt);
plotcycle(xlc,vlc,slc,[size(xlc,1) 1 2]);
set(gca,'Box','off')
grid on
xlabel('x')
zlabel('y')
ylabel('b')
saveEps('../verslag/img/ex3/3dlimitcycles.eps',8,8)