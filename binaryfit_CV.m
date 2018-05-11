function [C1,C2]= binaryfit_CV(Img,H)   
%   input:   
%       Img: input image  
%       H: the Heaveside function  
%  
% Author: HSW  
% Date  : 2014/4/8  
% Harbin institute of technology  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
a= H.*Img;  
numer_1=sum(a(:));   
denom_1=sum(H(:));  
C1 = numer_1/denom_1;  
  
b=(1-H).*Img;  
numer_2=sum(b(:));  
c=1-H;  
denom_2=sum(c(:));  
C2 = numer_2/denom_2;  
end   