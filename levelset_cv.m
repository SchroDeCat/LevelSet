function  [image, CInside, COutside] = levelset_cv(input_image)
%% Description
% Author: HSW
% Date��2015/4/12
% HARBIN INSTITUTE OF TECHNOLOGY
% demo ����,��Ҫ�޸�
ii = 1;
% %Add path
% addpath(genpath('./Image'));
% addpath(genpath('./CV solver'));
% % save result path
% SaveFilePath = './Results/';

%% Read Image
c0 = 2;
imgID = 6;
Img = input_image;
% Img = imread('test 3.jpg');
disp('processing')
Temp = Img;
if ndims(Img) == 3
    Img = rgb2gray(Img);
end
Img = double(Img);

%% parameters
imsize = size(Img);
iterNum = 500;      % the total number of the iteration
lambda1 = 1;        % the weight parameter of the globe term which is inside the level set
lambda2 = 1;        % the weight parameter of the globe term which is ouside the level set
mu = 0.03 * imsize(1) * imsize(2);     % the weight parameter of the length term , default = 0.002*255*255
nu = 0.0001 * imsize(1) * imsize(2);   % the weight parameter of the area term, default = 0
pu = 1.0;           % the weight parameter of the penalizing term
timestep = 0.1;     % the time step of the level set function evolution
epsilon = 1.0;      % the parameter of the Heaviside function and the Dirac delta function


%% Initial phi is the level set function
switch imgID
    case 1
        phi= ones(size(Img(:,:,1))).*c0;
        a=43;b=51;c=20;d=28;
        phi(a:b,c:d) = -c0;
        figure;
        imshow(Temp);colormap;
        hold on;
        [c,h] = contour(phi, 0, 'r');
        hold off;
    case 2
        [m,n] = size(Img(:,:,1));
        a=m/2; b=n/2; r=min(m,n)/4;%set the radius
        phi= ones(m,n).*c0;
        phi(a-r:a+r,b-r:b+r) = -c0;
        imshow(Temp);colormap;
        hold on;
        [c,h] = contour(phi, 0, 'r');
        hold off;
    case 3
        figure;
        imshow(Temp);colormap;
        text(6,6,'Left click to get points, right click to get end point','FontSize',12,'Color', 'g');
        BW=roipoly;     %BW is mask
        phi=c0*2*(0.5-BW);
        hold on;
        [c,h] = contour(phi,[0 0],'r');
        hold off;
    case 4
        %figure;imagesc(Img,[0,255]);colormap(gray);hold on; axis off; axis equal;
        figure;
        imshow(Temp);colormap;
        [x,y] = ginput(9);%set nine centre points of nine initial level set function
        [m,n] = size(Img);
        r = min(m,n)/6;   %we need to set the radius
        phi= ones(m,n).*c0;
        for iter = 1:length(x)
            phi(x(iter)-r:x(iter)+r,y(iter)-r:y(iter)+r) = -c0;%initial zero level set is square
        end% iter
        hold on;
        [c,h] = contour(phi,[0 0],'r');
        hold off;
    case 5
        %figure;imagesc(Img,[0,255]);colormap(gray);hold on; axis off; axis equal;
        figure;
        imshow(Temp);colormap;
        rNum = 1;% the cicle number in a row
        cNum = 1;% the cicle number in a colcumn
        [m,n] = size(Img);
        phi= ones(m,n).*c0;
        r = min(m/(2*rNum),n/(2*cNum))/2;
        for i = 1:rNum
            for j = 1:cNum
                px = (2*i-1)*(m/(2*rNum));
                py = (2*j-1)*(n/(2*cNum));%(px,py) is the centre of the initial zero level set cicle
                for x = 1:m
                    for y = 1:n
                        d = (x-px)^2 + (y - py)^2;
                        if d < r^2
                            phi(x,y) = -c0;
                        end%if
                    end%y
                end%x
            end%for j
        end%for i
        hold on;
        [c,h] = contour(phi,[0 0],'r');
        hold off;
    case 6
        % 产生随机位置
%         figure;
%         imshow(Temp);colormap;
        rand('seed',0);
        boardsize = 20; % 距离边界的位置
        iscircle = 1;   % 产生圆形,否则产生矩形
        r = 10;         % 产生圆形时为半径，产生矩形时为(1/2)*边长
        if r > boardsize
            r = boardsize;
        end
        possiblex = (boardsize + 1): (size(Img,1) - boardsize);
        possibley = (boardsize + 1): (size(Img,2) - boardsize);
        labelx = randperm(length(possiblex));
        labely = randperm(length(possibley));
        centrex = possiblex(labelx(1));
        centrey = possibley(labely(1));
        [m,n] = size(Img);
        phi= -ones(m,n).*c0;
        if iscircle == 1
            % 产生圆形
            for x = 1:size(Img,1)
                for y = 1:size(Img,2)
                    d = (x - centrex)^2 + (y - centrey)^2;
                    if d <= r^2
                        phi(x,y) = c0;
                    end
                end
            end
        else% 产生矩形
            for x = 1:size(Img,1)
                for y = 1:size(Img,2)
                    phi(centrex-r:centrex+r,centrey - r:centrey + r) = c0;
                end
            end
        end
%         hold on;
%         [c,h] = contour(phi,[0 0],'r');
%         hold off;
    case 7
        % 用鼠标获取中心位置
        figure;
        imshow(Temp);colormap;
        text('Press the Enter Button to end');
        [centrex,centrey] = ginput; % 按回车键结束
        if length(centrex) > 1
            centrex = centrex(1);
            centrey = centrey(1);
        end
        boardsize = 20; %距离边界的位置
        iscircle = 1; % 产生圆形,否则产生矩形
        r = 10; %产生圆形时为半径，产生矩形时为(1/2)*边长
        if r > boardsize
            r = boardsize;
        end
        [m,n] = size(Img);
        phi= -ones(m,n).*c0;
        if iscircle == 1
            % 产生圆形
            for x = 1:size(Img,1)
                for y = 1:size(Img,2)
                    d = (x - centrex)^2 + (y - centrey)^2;
                    if d <= r^2
                        phi(x,y) = c0;
                    end
                end
            end
        else% 产生矩形
            for x = 1:size(Img,1)
                for y = 1:size(Img,2)
                    phi(centrex-r:centrex+r,centrey - r:centrey + r) = c0;
                end
            end
        end
        hold on;
        [c,h] = contour(phi,[0 0],'r');
        hold off;
end%switch imgID


%% all model's initial level set is same
phi_CV        = phi;
phi_start     = phi;

% imshow(Temp); colormap;

%% start the level set evolution
%CV Model
time = cputime;
for iter = 1:iterNum
    numIter = 1;
    % level set evolution.
    [phi_CV, c1, c2] = EVOL_CV(phi_CV, Img, lambda1, lambda2, mu, nu, pu, timestep, epsilon, numIter);
%     if mod(iter, 10) == 0
%        contour(phi_CV, [0,0], 'y');
%     end
end
totaltime_CV = cputime - time;


%% Display Results
% figure;
% imshow(Temp);
% hold on;
% contour(phi_start,[0,0],'r','linewidth',1);
% title('Initial Level set');
%
% figure;
% imshow(Temp);
% hold on;
% contour(phi_CV, [0,0], 'r', 'linewidth', 1);
% title('Results of CV model');
CInside = c1;
COutside = c2;
image = phi_CV > 0;

end
