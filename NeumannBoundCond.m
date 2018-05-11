function g = NeumannBoundCond(f)  
%  Make f satisfy Neumann boundary condition  
% Author: HSW  
% Date  : 2014/4/8  
% Harbin institute of technology  
  
[nrow,ncol] = size(f);  
g = f;  
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);    
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);            
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);