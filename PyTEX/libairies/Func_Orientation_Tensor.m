%
% Func_Orientation_Tensor.m
%
% Function defining a weighted symmetric orientation tensor from
% vectors of crystal directions in (pole figure) sample co-ordinates
%
% By Florian Bachmann and David Mainprice
%
% Last revised 27/10/2014
%
% Orientation Tensor for axial data is calculated using very efficient
% numerical method of Bachmann et al. (2010) using the multiplication
% of the column vector by a row vector of the scatter data (equation 12)
% to form the covariance matrix known as the Orientation Tensor.
%
% Bachmann,F., Hielscher,R., Jupp,P.E., Pantleon,W., Schaeben,H., Wegert,E.
% (2010) Inferential statistics of electron backscatter diffraction data
% from within individual crystalline grains.
% Journal of Applied Crystallography, 43, 1338-1355.
%
% Input
%
% v - @vector3d (vectors of crystal directions in sample co-ordinates)
%
% typically generated by the MTEX statments
% Get orientations (o) from ebsd object
% o = get(ebsd('Forsterite'),'orientations')
% Generate vectors (v) of crystal directions (hkl or uvw) e.g. (100)
% in sample co-ordinates as MTEX vector3d 
% v = o * Miller(1,0,0);
% get Orientation tensor (OT), eigen-values and vectors
% [OT,value,vec1,vec2,vec3] = Func_Oriention_Matrix(v)
%
% Output
%
%  OT(3,3) - 3 by 3 weighted symmetric orientation tensor
%  value(3) - vector of 3 eigen-values in descending order of magnitude
%   vec1(3) - 
%   vec2(3) - eigen-vectors
%   vec3(3) -
%
% Notes
%
% vec1,vec2,vec3 -  you may need to be converted to 
% MTEX vector3d for plotting
% using the convert to specimen co-ordinates vector3d
% E1 = vector3d(vec1(1),vec1(2),vec1(3));
% E2 = vector3d(vec2(1),vec2(2),vec2(3));
% E3 = vector3d(vec3(1),vec3(2),vec3(3));
% label using
% plot Eigen-vectors
% annotate([E1,E2,E3],'label',{'E1','E2','E3'},...
%  'BackgroundColor','w');
%
%***********************************************************************
% Use of function
% [OT,value,vec1,vec2,vec3] = Func_Oriention_Matrix(v)
%
function [OT,value,vec1,vec2,vec3] = Func_Orientation_Tensor_MTEX4(v)
%
% Florian's covariance matrix method (330.3 times faster than for loops !)
% Set up a covariance matrix
[x,y,z] = double(v);
% OT = weighted multipication of the column vector by a row vector
% of the scatter data
OT = 1./numel(x)*[x,y,z]'*[x,y,z];
%*********************************************************
% Eigen-values and -vectors of OT matrix
%*********************************************************
[Vec,Diagonal] = eig(OT);
% Eigen-values : conversion diagonal matrix to vector
value = diag(Diagonal);
% normalize to value(1)+value(2)+value(3) = 1
NORM=value(1)+value(2)+value(3);
value(1) = value(1)/NORM;
value(2) = value(2)/NORM;
value(3) = value(3)/NORM;
% Sort Eigen-values in descending order
[value,index] = sort(value,'descend');
% Sort Eigen-vectors
vec1(1:3) = Vec(:,index(1));
vec2(1:3) = Vec(:,index(2));
vec3(1:3) = Vec(:,index(3));
%
% End of function
%
