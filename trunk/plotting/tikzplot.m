function tikzplot(func,varargin)
% function tikzplot(f,xmin,xmax,axis,ymin,ymax)
n=100;
linespec='k';
linewidth=1.5;
numvarargs = length(varargin);
if numvarargs > 3
    error('myfuns:somefun2Alt:TooManyInputs', ...
        'requires at most 3 optional inputs');
end
optargs = {-1 1 true -1 1};
% now put these defaults into the valuesToUse cell array, 
% and overwrite the ones specified in varargin.
optargs(1:numvarargs) = varargin;
% or ...
% [optargs{1:numvarargs}] = varargin{:};

% Place optional args in memorable variable names
[xmin xmax axisbool ymin ymax] = optargs{:};
x = linspace(xmin,xmax,n);
f=func(x);
plot(x,f,linespec,'Linewidth',linewidth)
line([xmin xmax],[0 0],'Color',linespec,'Linewidth',linewidth)
line([0 0],[ymin ymax],'Color',linespec,'Linewidth',linewidth)
axis off