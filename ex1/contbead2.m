% Nonlinear Systems - 2012
% Example Script - Numerical Continuation - Bead on a tilted wire
%   Exercise: 1.4.2

%   System:   Simplified equilibrium equation:
%             u' = -0.5*u^3 + r*u + h = 0
%             see myfunbead.m in Systems folder
%!! Case:     r is used as a parameter, h is fixed
%
%!! Goal:     Draw solution branches using r as parameter
%             for different values of h.
%!! How?      This script has been written based on a first analysis
%             of the problem using MAPLE (see file on TOLEDO)
%!! Use:      This script can be used to draw solution branches
%             for h = 0, h > 0, h < 0
%
%!! More details about MATCONT routines:
%   see CL MATCONT manual
%       Topic: Equilibrium continuation: p. 34-40

% Use: the code below has been tested for the following 3 case studies
%      1) h = -0.1 (fixed parameter) & r is the active parameter
%      2) h =  0   (fixed parameter) & r is the active parameter
%      3) h = +0.1 (fixed parameter) & r is the active parameter

%  Corresponding initial values for u can be found using:
%  >> roots([-0.5 0 r h])

% Version: March, 2012
% nico.scheerlinck@cs.kuleuven.be

clear all
close all
global cds

% ---------------------------------------------------------
% This is a first trial
% Adjust   'MaxNumPoints' if necessary

opt=contset;
opt=contset(opt,'MaxNumPoints',100);
opt=contset(opt,'Singularities',1);
opt=contset(opt,'Eigenvalues',1);
% ---------------------------------------------------------
r  = 0.0;    % initial value active parameter r
% ---------------------------------------------------------
h  = 0.0;    % fixed value ==> USER setting
% ---------------------------------------------------------
p0 = [r;h];
ap = 1;      % Note: index of continuation parameter = 1
% ---------------------------------------------------------
figure(1);clf;hold on
% Compute first solution branch
u0 = 2; % initial value for u
% Initialisation Step
[x0,v0] = init_EP_EP(@myfunbead,u0,p0,ap);
% Compute Backward
opt=contset(opt,'Backward',1);
[x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
cpl(x1,v1,s1,[2 1]);
% Compute remaining solution branch
sBP = s1(2);
u0 = x1(1,sBP.index); % initial value for u
% Initialisation Step
[x0,v0] = init_BP_EP(@myfunbead,u0,p0,sBP,0.01);
% Compute Forward
opt=contset(opt,'Backward',0);
[x2,v2,s2,h2,f2] = cont(@equilibrium,x0,v0,opt);
cpl(x2,v2,s2,[2 1]);

% Compute Backward
opt=contset(opt,'Backward',1);
[x3,v3,s3,h3,f3] = cont(@equilibrium,x0,v0,opt);
cpl(x3,v3,s3,[2 1]);
grid on
xlabel('r');ylabel('u')
title(['h = ' num2str(h)])

xall = [x1; x2; x3]; % forward and backward results
fall = [f1; f2; f3]; % eigenvalues jacobian
figure(3);clf;hold on
for j=1:3
    x=xall(2*j-1:2*j,:);
    f=fall(j,:);
    u = x(1,:);  % fixed points
    rplot = x(2,:);  % active parameter
    
    % Stability analysis plot
    % Goal: Visualisation of stable and unstable branches
    pos = find(sign(f) == 1);
    nul = find(sign(f) == 0);
    neg = find(sign(f) == -1);
    if ~isempty(pos)
        plot(rplot(pos),u(pos),'b--','linewidth',2,'MarkerFaceColor','r')
        
    end
    if ~isempty(nul)
        plot(rplot(nul),u(nul),'ko','linewidth',2,'MarkerFaceColor','k')
    end
    if ~isempty(neg)
        plot(rplot(neg),u(neg),'b-','linewidth',2,'MarkerFaceColor','b')
    end
end
axis([-2 2 -2 2])

cpl2dnoline(x1,v1,s1)
axis([-2 2 -2 2])
xlabel('r');ylabel('u')
grid on
hold off
saveEps('../verslag/img/ex1/bif142hnul.eps',6,6)