%三对角矩阵追赶法
function x=Chase(a,b,c,f)
n=length(f);
bt=zeros(1,n);y=zeros(1,n);x=zeros(1,n);
bt(1)=a(1);y(1)=f(1);
for i=2:n
    bt(i)=a(i)-b(i-1)./bt(i-1).*c(i-1);
    y(i)=f(i)-b(i-1)./bt(i-1).*y(i-1);
end
x(n)=y(n)./bt(n);
for i=n-1:-1:1
    x(i)=(y(i)-c(i).*x(i+1))./bt(i);
end


