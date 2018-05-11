function h = Heaviside(phi,epsilon)  
% compute the Heaveside function  
% input：  
%       phi : the level set function  
%       epsilon: the parameter of Dirac Delta function  
%  
% Author: HSW  
% Date  : 2014/4/8  
% Harbin institute of technology  
  
h=0.5*(1+(2/pi)*atan(phi./epsilon)); 