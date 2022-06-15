clc;
clear;
close all;
load('data_orig.mat');
d=Interference;

dim=20*length(d);
bmrad=floor(dim/4);
centrz=[floor(dim/4+2/16*dim),floor(dim/4);floor(dim/4*3-2/16*dim),floor(dim/4);floor(dim/2),floor(dim/2-3/16*dim)];

bm1=circ(bmrad,[dim,dim],centrz(1,:));
bm2=circ(bmrad,[dim,dim],centrz(2,:));
bm3=circ(bmrad,[dim,dim],centrz(3,:));
bm=2*bm1+2*bm2+1*bm3;

% costf=sse(bm,d);
% msg=sprintf("Sum-squared error is:%d",costf);
% disp(msg)
save('result.mat','bm')
figure
imagesc(bm')
colorbar

figure
imagesc(d)
colormap hot
axis square
colorbar


% d(d==1)=10;
% d(d==3)=10;
% d(d==5)=10;
% d(d<10)=0;
% %d=d./max(d(:));
% 
% a1=load('PhotCount_size_16AnotherTh.txt');
% b=sum(a1,2);
% c=reshape(b,[16,16]);
% c=c./max(c(:));

%cbw=imbinarize(c);
%imagesc(cbw)
%cost function to perform optimization
%fun=@

% mat=zeros(16,16);
% sigma=25;
% center=[6,8];
% mat=gauss2d(mat, sigma, center);




