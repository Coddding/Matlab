clc,clear,close all;
A=[31 -13 0 0 0 -10 0 0 0;
   -13 35 -9 0 -11 0 0 0 0;
   0 -9 31 -10 0 0 0 0 0;
   0 0 -10 79 -30 0 0 0 -9;
   0 0 0 -30 57 -7 0 -5 0;
   0 0 0 0 -7 47 -30 0 0;
   0 0 0 0 0 -30 41 0 0 ;
   0 0 0 0 -5 0 0 27 -2;
   0 0 0 -9 0 0 0 -2 29];
b=[-15; 27; -23; 0; -20; 12; -7; 7; 10];
n=length(b);
w=1;
epsilon=5e-6;
x=zeros(n,1);
temp=0;
sum=0;
count=0;
t=zeros(n,1);

for i = 1:n
    for j = 1:n
        for k = 1:n
            temp=A(j,k)*x(k);
            if k==j
                temp=0;
            end
            sum=sum+temp;
        end
        x(j)=(1-w)*x(j)+w*(b(j)-sum)/A(j,j);
        sum=0;
    end

    if (norm(x-t,"inf")<=epsilon)
        return;
    end
    t=x;

    

end

x