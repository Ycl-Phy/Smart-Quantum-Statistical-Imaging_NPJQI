function costf=fitres(x,d)

dim=length(d);
centrz=x(1:6);
%bmrad=floor(dim/4);

bm1=circ(x(7),[dim,dim],[x(1),x(2)]);
bm2=circ(x(7),[dim,dim],[x(3),x(4)]);
bm3=circ(x(7),[dim,dim],[x(5),x(6)]);
bm=2*bm1+2*bm2+1*bm3;

costf=sse(bm,d);

