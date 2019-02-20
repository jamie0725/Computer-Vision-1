clear all
close all

thresholds = [5e-05,0.0005,0.005,0.05,0.5];
outliers_5 = [7236,2909,2369,1400,139];
outliers_25 = [2846,2312,1831,878,9];
figure
plot(thresholds, outliers_5 *100 ./ (512*512))
set(gca,'xscale','log')
xtick = get(gca, 'XTick');
xtick(1) = 0.00005;
set(gca, 'XTick', xtick)
ax = gca;
ax.XTickLabel=cellstr(num2str(ax.XTick'));
hold on
plot(thresholds, outliers_25 *100 ./ (512*512))
xlabel('Threshold')
ylabel('Outliers Percentage [%]')
legend('SphereGray5', 'SphereGray25')
hold off
saveas(ax, './results/thresholds.eps', 'epsc')