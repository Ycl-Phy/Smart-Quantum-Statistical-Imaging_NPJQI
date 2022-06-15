clc;
clear;

load('data_orig.mat');
d=Interference;
dim=length(d);

fit2= @(x)fitres(x,d);

options = optimoptions('ga','ConstraintTolerance',1e-6,'PlotFcn', @gaplotbestf);
lb=[0,0,0,0,0,0,0];

ub=[16,16,16,16,16,16,16];
% 
x0=(lb+ub)/2;
% [xf,ff,flf,of] = fminunc(fit2,x0)
[x,fval]=ga(fit2,7,[],[],[],[],lb,ub,[],options)


bm11=circ(x(7),[dim,dim],[x(1),x(2)]);
bm21=circ(x(7),[dim,dim],[x(3),x(4)]);
bm31=circ(x(7),[dim,dim],[x(5),x(6)]);
bm_opti=2*bm11+2*bm21+1*bm31;

figure()
subplot(1,2,1)
imagesc(bm_opti')
subplot(1,2,2)
imagesc(Interference');
title('Original');