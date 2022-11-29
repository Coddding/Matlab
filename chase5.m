function y=chase5(a,b,c,d,e,f)
n=length(a);

for i=1:n-2
    a(i+1)=a(i+1)-b(i)/a(i)*c(i);
    a(i+2)=a(i+2)-d(i)/a(i)*e(i);
    b(i+1)=b(i+1)-d(i)/a(i)*c(i);
    c(i+1)=c(i+1)-b(i)/a(i)*e(i);
    f(i+1)=f(i+1)-b(i)/a(i)*f(i);
    f(i+2)=f(i+2)-d(i)/a(i)*f(i);
end
%i=n-1
a(n)=a(n)-b(n-1)/a(n-1)*c(n-1);
f(n)=f(n)-b(n-1)/a(n-1)*f(n-1);

y(n)=f(n)/a(n);
y(n-1)=(f(n-1)-y(n)*c(n-1))/a(n-1);
for i=n-2:-1:1
    y(i)=(f(i)-c(i)*y(i+1)-e(i)*y(i+2))/a(i);
end
