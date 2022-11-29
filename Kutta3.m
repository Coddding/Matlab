clc,clear,close all;
h=0.05;n=1/h;
yn=zeros(n+1,1);yn(1)=1;
xn=h*(1:n+1)-h;xn=xn';
f= @(x,y)(-2)*x*y^2;
for i =1:n
    k1=f(xn(i),yn(i));
    k2=f(xn(i)+h/2,yn(i)+h*k1/2);
    k3=f(xn(i)+h,yn(i)-h*k1+2*h*k2);
    yn(i+1)=yn(i)+h/6*(k1+4*k2+k3);
end
y=@(x) 1./(1+x.^2);
tru=zeros(n+1,1);
for i=1:n+1
    tru(i)=y(xn(i));
end
err=abs(yn-tru);
maxerr=max(err);
h
yn(n+1)
tru(n+1)
err(n+1)
maxerr