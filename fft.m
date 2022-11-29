clc,clear,close all;
% u=@(x) sin(x);
% du=@(x) cos(x);
u=@(x) sin(30*x)+cos(20*x);

N=1000;h=2*pi/N;
x=0:h:2*pi-h;x=x';
Vu=u(x);
Cu=fft(Vu);
Vk=[0:N/2-1 0 1-N/2:-1];
lk=1i*Vk';
dVu=ifft((lk.*Cu));
d2Vu=ifft((lk).^2.*Cu);
figure(1)
plot(x,dVu,'-',x,d2Vu,'-o')