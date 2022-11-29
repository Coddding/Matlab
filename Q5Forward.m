clc,clear,close all;
h=0.001;n=1/h;
yn=zeros(n+1,1);yn(1)=1;
xn=h*(1:n+1)-h;xn=xn';
for i =1:n
    yn(i+1)=yn(i)-h*2*xn(i)*yn(i)^2;
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