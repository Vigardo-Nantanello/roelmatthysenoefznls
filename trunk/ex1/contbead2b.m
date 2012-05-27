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
global cds
close all

% ---------------------------------------------------------
% This is a first trial
% Adjust   'MaxNumPoints' if necessary

opt=contset;
opt=contset(opt,'MaxNumPoints',100);%100 OK
opt=contset(opt,'Singularities',1);
opt=contset(opt,'Eigenvalues',1);
opt=contset(opt,'MinStepSize',10^(-5))%grens op 0.02
opt=contset(opt,'MaxStepSize',0.1)%grens op 0.2
opt=contset(opt,'MaxNewtonIters',3)%geen probleem
opt=contset(opt,'MaxTestIters',3)%Op3 geen detectie speciale punten meer
% ---------------------------------------------------------
r  = 1;    % initial value active parameter r
hs=[-0.0025 -0.0005];
for i=1:2
    h=hs(i);
    % ---------------------------------------------------------
    p0 = [r;h];
    ap = 1;      % Note: index of continuation parameter = 1
    % ---------------------------------------------------------
    figure(i);clf;hold on
    % Compute lower solution branch
    u0 = min(roots([-0.5 0 r h])); % initial value for u
    % Initialisation Step
    [x0,v0] = init_EP_EP(@myfunbead,u0,p0,ap);
    % Compute Forward then Backward
    opt=contset(opt,'Backward',0);
    [x1,v1,s1,h1,f1] = cont(@equilibrium,x0,v0,opt);
    cpl(x1,v1,s1,[2 1]);
    opt=contset(opt,'Backward',1);
    [x2,v2,s2,h2,f2] = cont(@equilibrium,x0,v0,opt);
    cpl(x2,v2,s2,[2 1]);
    figure(i);hold on
    % Compute Upper solution branch
    u0 = max(roots([-0.5 0 r h])); % initial value for u
    % Initialisation Step
    [x0,v0] = init_EP_EP(@myfunbead,u0,p0,ap);
    % Compute Forward then Backward
    opt=contset(opt,'Backward',0);
    [x3,v3,s3,h3,f3] = cont(@equilibrium,x0,v0,opt);
    cpl(x3,v3,s3,[2 1]);
    opt=contset(opt,'Backward',1);
    [x4,v4,s4,h4,f4] = cont(@equilibrium,x0,v0,opt);
    cpl(x4,v4,s4,[2 1]);
    
    
    
%     % POST PROCESSING AREA
%     xall = [x1; x2; x3; x4]; % forward and backward results
%     fall = [f1; f2; f3; f4]; % eigenvalues jacobian
%     for j=1:4
%         x=xall(2*j-1:2*j,:);
%         f=fall(j,:);
%         u = x(1,:);  % fixed points
%         rplot = x(2,:);  % active parameter
%         
%         % Stability analysis plot
%         % Goal: Visualisation of stable and unstable branches
%         figure(i+2);hold on
%         pos = find(sign(f) == 1);
%         nul = find(sign(f) == 0);
%         neg = find(sign(f) == -1);
%         if ~isempty(pos)
%             plot(rplot(pos),u(pos),'b--','linewidth',2,'MarkerFaceColor','r')
%             
%         end
%         if ~isempty(nul)
%             plot(rplot(nul),u(nul),'ko','linewidth',2,'MarkerFaceColor','k')
%         end
%         if ~isempty(neg)
%             plot(rplot(neg),u(neg),'b-','linewidth',2,'MarkerFaceColor','b')
%         end
%     end
%         axis([-2 2 -2 2])
%     if(i==2)
%         cpl2dnoline(x1,v1,s1)
%     end
%     if(i==1)
%         cpl2dnoline(x4,v4,s4)
%     end
%     axis([-2 2 -2 2])
%     xlabel('r');ylabel('u')
%     grid on
%     hold off
% %     saveEps(['../verslag/img/ex1/bif142h' num2str(i) '.eps'],6,6)
end

