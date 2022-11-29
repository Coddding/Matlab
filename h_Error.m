clc,clear,close all;
h=[0.001,0.005,0.01,0.05,0.1];
forerr=[0.00023955,0.0012,0.0024,0.0125,0.0263];
referr=[0.000000096538,0.0000024098,0.0000096205,0.00023633,0.00091858];
h=log(h);
forerr=log(forerr);
referr=log(referr);
xi=log(0.001):0.1:log(0.1);
yi=spline(h,forerr,xi);
zi=spline(h,referr,xi);

figure
fig1=plot(h,forerr,'or');
set(fig1,'markersize',12);
hold on
fig2=plot(xi,yi,'r');
set(fig2,'LineWidth',2,'markersize',2); set(gca,'FontSize',30);
hold on
fig3=plot(h,referr,'ob');
set(fig3,'markersize',12);
hold on
fig4=plot(xi,zi,'b');
set(fig4,'LineWidth',2,'markersize',2); set(gca,'FontSize',30);
xlabel('log(h)'); ylabel('log(Error)');
legend([fig2 fig4],{'欧拉方法','改进欧拉方法'})