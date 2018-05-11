function k = curvature(u,scheme)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% input:  
% u: the level set function  
% scheme: the parameter utilize to choose the Difference scheme.   
%      scheme = 1 compute curvature for u with central difference scheme,   
%      scheme = 2,compute curvature for u with alternative backward and foreward scheme.  
%  
% Author: HSW  
% Date  : 2014/4/8  
% Harbin institute of technology  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
switch scheme  
    case 1  
        [ux,uy] = gradient(u);  
        normDu = sqrt(ux.^2+uy.^2+1e-10);  
        Nx = ux./normDu;  
        Ny = uy./normDu;  
        [nxx,junk] = gradient(Nx);  
        [junk,nyy] = gradient(Ny);  
        k = nxx+nyy;  
    case 2  
        [f_fx,f_fy]=forward_gradient(u);  
        [f_bx,f_by]=backward_gradient(u);  
          
        mag1=sqrt(f_fx.^2+f_fy.^2+1e-10);  
        n1x=f_fx./mag1;  
        n1y=f_fy./mag1;  
          
        mag2=sqrt(f_bx.^2+f_fy.^2+1e-10);  
        n2x=f_bx./mag2;  
        n2y=f_fy./mag2;  
          
        mag3=sqrt(f_fx.^2+f_by.^2+1e-10);  
        n3x=f_fx./mag3;  
        n3y=f_by./mag3;  
          
        mag4=sqrt(f_bx.^2+f_by.^2+1e-10);  
        n4x=f_bx./mag4;  
        n4y=f_by./mag4;  
          
        nx=n1x+n2x+n3x+n4x;  
        ny=n1y+n2y+n3y+n4y;  
          
        magn=sqrt(nx.^2+ny.^2);  
        nx=nx./(magn+1e-10);  
        ny=ny./(magn+1e-10);  
          
        [nxx,nxy]=gradient(nx);  
        [nyx,nyy]=gradient(ny);  
        k=nxx+nyy;  
end  
  
function [bdy,bdx]=backward_gradient(f)  
% 向后差分  
  
[nr,nc]=size(f);  
bdx=zeros(nr,nc);  
bdy=zeros(nr,nc);  
  
bdx(2:nr,:)=f(2:nr,:)-f(1:nr-1,:);  
bdy(:,2:nc)=f(:,2:nc)-f(:,1:nc-1);  
  
function [fdy,fdx]=forward_gradient(f)  
% 向前差分  
  
[nr,nc]=size(f);  
fdx=zeros(nr,nc);  
fdy=zeros(nr,nc);  
  
a=f(2:nr,:)-f(1:nr-1,:);  
fdx(1:nr-1,:)=a;  
b=f(:,2:nc)-f(:,1:nc-1);  
fdy(:,1:nc-1)=b;  