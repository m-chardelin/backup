function [ebsdR] = rotationSections(ebsd, X, Y, Xref, Yref)

% use map option to define rotation SEM to Structural frame
rot = rotation('map',X,Xref,Y,Yref);
% rotate Euler angles in ebsd object

ebsdR = rotate(ebsd,rot,'keepXY');

end