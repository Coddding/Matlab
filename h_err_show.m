clc,clear, close all;
h=[0.001,0.005,0.01,0.05,0.1];
forerr=[0.00023955,0.0012,0.0024,0.0125,0.0263];
referr=[0.000000096538,0.0000024098,0.0000096205,0.00023633,0.00091858];
k3err=[8.259e-11,1.036e-8,8.333e-8,1.081e-5,9.046e-5];
rk4err=[6.883e-15,4.319e-12,6.875e-11,4.27e-8,7.91e-7];
h=log(h);
forerr=log(forerr);
referr=log(referr);
k3err=log(k3err);
rk4err=log(rk4err);
xi=log(0.001):0.1:log(0.1);
yi=spline(h,forerr,xi);
zi=spline(h,referr,xi);
wi=spline(h,k3err,xi);
ui=spline(h,rk4err,xi);

figure
xlabel('log(h)'); ylabel('log(Error)');
fig1=plot(h,forerr,'or');
set(fig1,'markersize',12);
hold on
fig2=plot(xi,yi,'r');
set(fig2,'LineWidth',2,'markersize',2); set(gca,'FontSize',30);
hold on
fig3=plot(h,referr,'or');
set(fig3,'markersize',12);
hold on
fig4=plot(xi,zi,'b');
set(fig4,'LineWidth',2,'markersize',2); set(gca,'FontSize',30);
hold on
fig5=plot(h,k3err,'or');
set(fig5,'markersize',12); set(gca,'FontSize',30);
hold on
fig6=plot(xi,wi,'m');
set(fig6,'LineWidth',2,'markersize',2); set(gca,'FontSize',30);
hold on
fig7=plot(h,rk4err,'or');
set(fig7,'markersize',12); set(gca,'FontSize',30);
hold on
fig8=plot(xi,ui,'g');
set(fig8,'LineWidth',2,'markersize',2); set(gca,'FontSize',30);
legend([fig2 fig4 fig6 fig8],{'欧拉方法','改进欧拉方法','3阶Kutta方法','4阶经典RK方法'})