clear;clc;close all;
load('x.mat');
load('y.mat');
load('z.mat');
[xa,ya]=meshgrid(x,y);
x1=0:10:5600;
y1=4800:-10:0;
[xi,yi]=meshgrid(x1,y1);
zi=interp2(xa,ya,z,xi,yi,'spline');
meshz(xi,yi,zi)
hold on
plot3(4000,2000,950,'.')
plot3(0,800,650,'.')
plot3([0,4000,2000],[800,2000,4000],[650,950,1320])
text(4000,2000,950,"居民点")
text(0,800,650,"山脚")
text(2000,4000,1320,"矿区")
figure;
contour(xi,yi,zi,'ShowText','on')
hold on
text(0,800,"山脚")
text(4000,2000,"居民点")
text(2000,4000,"矿区")
plot([0,4000,2000],[800,2000,4000],'r')

plot([2400,4800],[2400,0],'b')      %河流最深处
river_x=2400:10:4800;       %河流
river_w=((river_x-2400)./2).^(3/4)+5;
river_y1=(-river_x+4800)-river_w./sqrt(2);
river_y2=(-river_x+4800)+river_w./sqrt(2);
plot(river_x,river_y1)
plot(river_x,river_y2)
%figure;
%起点到居民点路径
%起点到居民点坡度
% podu=zeros(1,400);
% for i=1:400
%     podu(1,i)=(route_zi(i+1)-route_zi(i))/10;
% end
% podu_x=0:10:3990;
% plot(podu_x,podu(1,:))
% hold on
% plot([0 3990],[0.125,0.125])
% plot([0 3990],[-0.125,-0.125]) 
% figure
% %
% podu_x2=2000:10:3990;
% podu2=zeros(1,200);
% for i=1:200
%     podu2(1,i)=(route_z2(i+1)-route_z2(i))/(10*sqrt(2));
% end
% plot(podu_x2,podu2(1,:))
% hold on
% plot([2000 3990],[0.125,0.125])
% plot([2000 3990],[-0.125,-0.125]) 

x0=4000;y0=2000;
z_num1=sub2ind(size(zi),480-y0/10+1,x0/10+1);
z0=zi(z_num1);
xji=zeros(1,201);yji=zeros(1,201);
xji(1,1)=x0;yji(1,1)=y0;
s=2;
price=0;
price2=0;
while 1
    y_test=(fix(y0/10)+1)*10;
    x_test=((2000-x0)/(4000-y0))*y_test+x0-y0*((2000-x0)/(4000-y0));
    z_testnum1=sub2ind(size(zi),480-y_test/10+1,fix(x_test/10)+1);
    z_test1=zi(z_testnum1);
    z_testnum2=sub2ind(size(zi),480-y_test/10+1,fix(x_test/10)+2);
    z_test2=zi(z_testnum2);
    z_test=((x_test-fix(x_test/10)*10)/10)*(z_test2-z_test1)+z_test1;
    a_test=(z_test-z0)/sqrt((x_test-x0)^2+(y_test-y0)^2);
    if(abs(a_test)>0.125)
        n=1;
        a_testcaip=a_test;
        plus=0;minus=0;
        while 1
            x_testcaip=x_test+n;
            z_testcaipnum1=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaip/10)+1);
            z_testcaip1=zi(z_testcaipnum1);
            z_testcaipnum2=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaip/10)+2);
            z_testcaip2=zi(z_testcaipnum2);
            z_testcaip=((x_testcaip-fix(x_testcaip/10)*10)/10)*(z_testcaip2-z_testcaip1)+z_testcaip1;
            a_testcaip=(z_testcaip-z0)/sqrt((x_testcaip-x0)^2+(y_test-y0)^2);
            n=n+1;
            if(n>300)                %设定最多可以偏离的x值
                plus=Inf;
                break;
            end
            if(abs(a_testcaip)<=0.125)
                break;
            end
        end
        if(plus<Inf)
            plus=abs((10/(x_test-x0)-atan(10/(x_testcaip-x0))));
        end
        qianyige_n=n;
        n=1;
        while 1
            x_testcaim=x_test-n;
            z_testcaimnum1=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaim/10)+1);
            z_testcaim1=zi(z_testcaimnum1);
            z_testcaimnum2=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaim/10)+2);
            z_testcaim2=zi(z_testcaimnum2);
            z_testcaim=((x_testcaim-fix(x_testcaim/10)*10)/10)*(z_testcaim2-z_testcaim1)+z_testcaim1;
            a_testcaim=(z_testcaim-z0)/sqrt((x_testcaim-x0)^2+(y_test-y0)^2);
            n=n+1;
            if(n>300)
                minus=Inf;
                break;
            end
            if(abs(a_testcaim)<=0.125)
                break;
            end
         end
         if(minus<Inf)
            minus=abs((10/(x_test-x0)-atan(10/(x_testcaim-x0))));
         end
         if(minus<plus)
             x_testcaiz=x_testcaim;
             z_testcaiz=z_testcaim;
             a_testcaiz=a_testcaim;
         else
             x_testcaiz=x_testcaip;
             z_testcaiz=z_testcaip;
             a_testcaiz=a_testcaip;
         end
    else
        x_testcaiz=x_test;
        z_testcaiz=z_test;
        a_testcaiz=a_test;
    end
    fprintf("解为%d %d 海拔%d 坡度%d +的n值%d -的n值%d\n",x_testcaiz,y_test,z_testcaiz,a_testcaiz,qianyige_n,n)
    changdu=sqrt((x_testcaiz-x0)^2+(y_test-y0)^2+(z_testcaiz-z0)^2);
    price=price+changdu*300;
    xji(1,s)=x_testcaiz;
    yji(1,s)=y_test;
    x0=x_testcaiz;
    y0=y_test;
    z0=z_testcaiz;
    s=s+1;
    if(s==110)
        price2=price;
    end
    if(y0==4000)
        break;
    end
end
price_ctom=price;
plot(xji,yji,'linewidth',1.5);
fprintf("总价格为%d\n",price_ctom)

zchangdu=0;
x0=0;y0=800;
z_num1=sub2ind(size(zi),480-y0/10+1,x0/10+1);
z0=zi(z_num1);
xji=zeros(1,303);yji=zeros(1,303);
xji(1,1)=x0;yji(1,1)=y0;
s=2;
price=0;
while 1
    x_test=(fix(x0/10)+1)*10;
    y_test=((2000-y0)/(4000-x0))*(x_test-x0)+y0;
    z_testnum1=sub2ind(size(zi),480-fix(y_test/10)+1,x_test/10+1);
    z_test1=zi(z_testnum1);
    z_testnum2=sub2ind(size(zi),480-fix(y_test/10),x_test/10+1);
    z_test2=zi(z_testnum2); %
    z_test=((y_test-fix(y_test/10)*10)/10)*(z_test2-z_test1)+z_test1;
    a_test=(z_test-z0)/sqrt((x_test-x0)^2+(y_test-y0)^2);
    if(abs(a_test)>0.125)
        n=1;
        a_testcaip=a_test;
        plus=0;minus=0;
        while 1
            y_testcaip=y_test+n;
            z_testcaipnum1=sub2ind(size(zi),480-fix(y_testcaip/10)+1,x_test/10+1);
            z_testcaip1=zi(z_testcaipnum1);
            z_testcaipnum2=sub2ind(size(zi),480-fix(y_testcaip/10),x_test/10+1);
            z_testcaip2=zi(z_testcaipnum2);
            z_testcaip=((y_testcaip-fix(y_testcaip/10)*10)/10)*(z_testcaip2-z_testcaip1)+z_testcaip1;
            a_testcaip=(z_testcaip-z0)/sqrt((x_test-x0)^2+(y_testcaip-y0)^2);
            n=n+1;
            if(n>500)                %设定最多可以偏离的x值（300的话路径会很奇怪，只能500了）
                plus=Inf;
                break;
            end
            if(abs(a_testcaip)<=0.125)
                break;
            end
        end
        if(plus<Inf)
            plus=abs((y_test-y0)/10-atan((y_testcaip-y0)/10));
        end
        qianyige_n=n;
        n=1;
        while 1
            y_testcaim=y_test-n;
            z_testcaimnum1=sub2ind(size(zi),480-fix(y_testcaim/10)+1,x_test/10+1);
            z_testcaim1=zi(z_testcaimnum1);
            z_testcaimnum2=sub2ind(size(zi),480-fix(y_testcaim/10),x_test/10+1);
            z_testcaim2=zi(z_testcaimnum2);
            z_testcaim=((y_testcaim-fix(y_testcaim/10)*10)/10)*(z_testcaim2-z_testcaim1)+z_testcaim1;
            a_testcaim=(z_testcaim-z0)/sqrt((x_test-x0)^2+(y_testcaim-y0)^2);
            n=n+1;
            if(n>500)
                minus=Inf;
                break;
            end
            if(abs(a_testcaim)<=0.125)
                break;
            end
         end
         if(minus<Inf)
            minus=abs((y_test-y0)/10-atan((y_testcaim-y0)/10));
         end
         if(minus<plus)
             y_testcaiz=y_testcaim;
             z_testcaiz=z_testcaim;
             a_testcaiz=a_testcaim;
         else
             y_testcaiz=y_testcaip;
             z_testcaiz=z_testcaip;
             a_testcaiz=a_testcaip;
         end
    else
        y_testcaiz=y_test;
        z_testcaiz=z_test;
        a_testcaiz=a_test;
    end
    fprintf("解为%d %d 海拔%d 坡度%d +的n值%d -的n值%d\n",x_test,y_testcaiz,z_testcaiz,a_testcaiz,qianyige_n,n)
    changdu=sqrt((x_test-x0)^2+(y_testcaiz-y0)^2+(z_testcaiz-z0)^2);
    zchangdu=zchangdu+changdu;
    price=price+changdu*300;
    xji(1,s)=x_test;
    yji(1,s)=y_testcaiz;
    x0=x_test;
    y0=y_testcaiz;
    z0=z_testcaiz;
    s=s+1;
    w=((x0-2400)./2).^(3/4)+5;
    if(y0>=(((-x0+4800)-((x0-2400)/2)^(3/4)+5)/sqrt(2)))
    %if(x0==4000)
        break;
    end
end
xji(1,303)=3015.7;yji(1,303)=1730;
plot(xji,yji,'linewidth',1.5)
price_stob=price;
river_y1=(-river_x+4800)-river_w./sqrt(2);
river_w=((river_x-2400)./2).^(3/4)+5;

%尝试加入隧道
mm=sub2ind(size(zi),480-291+1,440);
mm2=zi(mm);
tunnel_length=0;
while 1
    tunnel_length=tunnel_length+10;
    z_tunnelm=sub2ind(size(zi),480-(tunnel_length/10+291)+1,440);
    z_tunnel=zi(z_tunnelm);
    if(mm2+0.1*tunnel_length>=z_tunnel)
        break;
    end
end
x0=4400;y0=2910+tunnel_length;
%plot([4400 4400],[2910 y0],'linewidth',1.5)
z_num1=sub2ind(size(zi),480-y0/10+1,x0/10+1);
z0=zi(z_num1);
xji=zeros(1,55);yji=zeros(1,55);
xji(1,1)=x0;yji(1,1)=y0;
s=2;
price=0;
price_2=0;
while 1
    y_test=(fix(y0/10)+1)*10;
    x_test=((2000-x0)/(4000-y0))*y_test+x0-y0*((2000-x0)/(4000-y0));
    z_testnum1=sub2ind(size(zi),480-y_test/10+1,fix(x_test/10)+1);
    z_test1=zi(z_testnum1);
    z_testnum2=sub2ind(size(zi),480-y_test/10+1,fix(x_test/10)+2);
    z_test2=zi(z_testnum2);
    z_test=((x_test-fix(x_test/10)*10)/10)*(z_test2-z_test1)+z_test1;
    a_test=(z_test-z0)/sqrt((x_test-x0)^2+(y_test-y0)^2);
    if(abs(a_test)>0.125)
        n=1;
        a_testcaip=a_test;
        plus=0;minus=0;
        while 1
            x_testcaip=x_test+n;
            z_testcaipnum1=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaip/10)+1);
            z_testcaip1=zi(z_testcaipnum1);
            z_testcaipnum2=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaip/10)+2);
            z_testcaip2=zi(z_testcaipnum2);
            z_testcaip=((x_testcaip-fix(x_testcaip/10)*10)/10)*(z_testcaip2-z_testcaip1)+z_testcaip1;
            a_testcaip=(z_testcaip-z0)/sqrt((x_testcaip-x0)^2+(y_test-y0)^2);
            n=n+1;
            if(n>300)                %设定最多可以偏离的x值
                plus=Inf;
                break;
            end
            if(abs(a_testcaip)<=0.125)
                break;
            end
        end
        if(plus<Inf)
            plus=abs((10/(x_test-x0)-atan(10/(x_testcaip-x0))));
        end
        qianyige_n=n;
        n=1;
        while 1
            x_testcaim=x_test-n;
            z_testcaimnum1=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaim/10)+1);
            z_testcaim1=zi(z_testcaimnum1);
            z_testcaimnum2=sub2ind(size(zi),480-y_test/10+1,fix(x_testcaim/10)+2);
            z_testcaim2=zi(z_testcaimnum2);
            z_testcaim=((x_testcaim-fix(x_testcaim/10)*10)/10)*(z_testcaim2-z_testcaim1)+z_testcaim1;
            a_testcaim=(z_testcaim-z0)/sqrt((x_testcaim-x0)^2+(y_test-y0)^2);
            n=n+1;
            if(n>300)
                minus=Inf;
                break;
            end
            if(abs(a_testcaim)<=0.125)
                break;
            end
         end
         if(minus<Inf)
            minus=abs((10/(x_test-x0)-atan(10/(x_testcaim-x0))));
         end
         if(minus<plus)
             x_testcaiz=x_testcaim;
             z_testcaiz=z_testcaim;
             a_testcaiz=a_testcaim;
         else
             x_testcaiz=x_testcaip;
             z_testcaiz=z_testcaip;
             a_testcaiz=a_testcaip;
         end
    else
        x_testcaiz=x_test;
        z_testcaiz=z_test;
        a_testcaiz=a_test;
    end
    fprintf("解为%d %d 海拔%d 坡度%d +的n值%d -的n值%d\n",x_testcaiz,y_test,z_testcaiz,a_testcaiz,qianyige_n,n)
    changdu=sqrt((x_testcaiz-x0)^2+(y_test-y0)^2+(z_testcaiz-z0)^2);
    price=price+changdu*300;
    xji(1,s)=x_testcaiz;
    yji(1,s)=y_test;
    x0=x_testcaiz;
    y0=y_test;
    z0=z_testcaiz;
    s=s+1;
    if(y0==4000)
        break;
    end
end

%plot(xji,yji,'linewidth',1.5)
fprintf("隧道长度%d\n",tunnel_length)
fprintf("隧道口到矿区价格为%d\n",price)
price3=price2+3000*tunnel_length+price;
fprintf("居民点到矿区价格为%d\n",price3)
%4次实验下不考虑隧道

bridge_y=0;bridge_x=0;
z_testnum1=sub2ind(size(zi),480-(1730+bridge_y)/10+1,fix((bridge_x+3015.7)/10)+1);
z_test1=zi(z_testnum1);
z_testnum2=sub2ind(size(zi),480-(1730+bridge_y)/10+1,fix((bridge_x+3015.7)/10)+2);
z_test2=zi(z_testnum2);
bridgestart_z=(((bridge_x+3015.7)-fix((bridge_x+3015.7)/10)*10)/10)*(z_test2-z_test1)+z_test1;
while 1
    bridge_y=bridge_y+10;
    bridge_x=bridge_x+10;
    z_testnum1=sub2ind(size(zi),480-(1730+bridge_y)/10+1,fix((bridge_x+3015.7)/10)+1);
    z_test1=zi(z_testnum1);
    z_testnum2=sub2ind(size(zi),480-(1730+bridge_y)/10+1,fix((bridge_x+3015.7)/10)+2);
    z_test2=zi(z_testnum2);
    z_test=(((bridge_x+3015.7)-fix((bridge_x+3015.7)/10)*10)/10)*(z_test2-z_test1)+z_test1;
    if(z_test>=bridgestart_z)
        break;
    end
end
price_b=(bridge_x*sqrt(2))*2000;

x0=3015.7+bridge_x;y0=1730+bridge_y;
plot([3015.7 x0],[1730 y0],'linewidth',1.5)
z0=z_test;
xji=zeros(1,88);yji=zeros(1,88);
xji(1,1)=x0;yji(1,1)=y0;
s=2;
price=0;
while 1
    x_test=(fix(x0/10)+1)*10;
    y_test=((2000-y0)/(4000-x0))*(x_test-x0)+y0;
    z_testnum1=sub2ind(size(zi),480-fix(y_test/10)+1,x_test/10+1);
    z_test1=zi(z_testnum1);
    z_testnum2=sub2ind(size(zi),480-fix(y_test/10),x_test/10+1);
    z_test2=zi(z_testnum2); %
    z_test=((y_test-fix(y_test/10)*10)/10)*(z_test2-z_test1)+z_test1;
    a_test=(z_test-z0)/sqrt((x_test-x0)^2+(y_test-y0)^2);
    if(abs(a_test)>0.125)
        n=1;
        a_testcaip=a_test;
        plus=0;minus=0;
        while 1
            y_testcaip=y_test+n;
            z_testcaipnum1=sub2ind(size(zi),480-fix(y_testcaip/10)+1,x_test/10+1);
            z_testcaip1=zi(z_testcaipnum1);
            z_testcaipnum2=sub2ind(size(zi),480-fix(y_testcaip/10),x_test/10+1);
            z_testcaip2=zi(z_testcaipnum2);
            z_testcaip=((y_testcaip-fix(y_testcaip/10)*10)/10)*(z_testcaip2-z_testcaip1)+z_testcaip1;
            a_testcaip=(z_testcaip-z0)/sqrt((x_test-x0)^2+(y_testcaip-y0)^2);
            n=n+1;
            if(n>500)                %设定最多可以偏离的x值（300的话路径会很奇怪，只能500了）
                plus=Inf;
                break;
            end
            if(abs(a_testcaip)<=0.125)
                break;
            end
        end
        if(plus<Inf)
            plus=abs((y_test-y0)/10-atan((y_testcaip-y0)/10));
        end
        qianyige_n=n;
        n=1;
        while 1
            y_testcaim=y_test-n;
            z_testcaimnum1=sub2ind(size(zi),480-fix(y_testcaim/10)+1,x_test/10+1);
            z_testcaim1=zi(z_testcaimnum1);
            z_testcaimnum2=sub2ind(size(zi),480-fix(y_testcaim/10),x_test/10+1);
            z_testcaim2=zi(z_testcaimnum2);
            z_testcaim=((y_testcaim-fix(y_testcaim/10)*10)/10)*(z_testcaim2-z_testcaim1)+z_testcaim1;
            a_testcaim=(z_testcaim-z0)/sqrt((x_test-x0)^2+(y_testcaim-y0)^2);
            n=n+1;
            if(n>500)
                minus=Inf;
                break;
            end
            if(abs(a_testcaim)<=0.125)
                break;
            end
         end
         if(minus<Inf)
            minus=abs((y_test-y0)/10-atan((y_testcaim-y0)/10));
         end
         if(minus<plus)
             y_testcaiz=y_testcaim;
             z_testcaiz=z_testcaim;
             a_testcaiz=a_testcaim;
         else
             y_testcaiz=y_testcaip;
             z_testcaiz=z_testcaip;
             a_testcaiz=a_testcaip;
         end
    else
        y_testcaiz=y_test;
        z_testcaiz=z_test;
        a_testcaiz=a_test;
    end
    fprintf("解为%d %d 海拔%d 坡度%d +的n值%d -的n值%d\n",x_test,y_testcaiz,z_testcaiz,a_testcaiz,qianyige_n,n)
    changdu=sqrt((x_test-x0)^2+(y_testcaiz-y0)^2+(z_testcaiz-z0)^2);
    zchangdu=zchangdu+changdu;
    price=price+changdu*300;
    xji(1,s)=x_test;
    yji(1,s)=y_testcaiz;
    x0=x_test;
    y0=y_testcaiz;
    z0=z_testcaiz;
    s=s+1;
    w=((x0-2400)./2).^(3/4)+5;
    %if(y0>=(((-x0+4800)-((x0-2400)/2)^(3/4)+5)/sqrt(2)))
    if(x0==4000)
        break;
    end
end
price_btoc=price;
fprintf("桥梁价格为%d\n",price_b);
plot(xji,yji,'linewidth',1.5)
price_stoc=price_stob+price_btoc+price_b;
fprintf("起点到居民点价格为%d\n",price_stoc);
fprintf("居民点到矿区价格为%d\n",price_ctom);
price_stom=price_ctom+price_stoc;
fprintf("总价格为%d\n",price_stom);