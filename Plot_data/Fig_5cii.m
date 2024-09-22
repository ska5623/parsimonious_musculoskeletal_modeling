P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
MTall = [0 0.25 0.5 0.75 1];

%% active force phase
load('hummingbird.mat')
load('hawkmoth.mat')

P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2.0 2.2];
P1all_async = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
Phaseall = zeros(length(P1allfinal), length(P3all));

for p1i = 1:1:length(P1allfinal)   
        for p3i = 1:1:length(P3all)
               filestr = ['Thorax data sync/datasync_thorax_1_' num2str(P3all(p3i)) '_' num2str(p1i) '.mat'];
               clear posforce disp;
               load(filestr,'posforce','disp');
               X = posforce> 0;
               K = strfind(X',[0 1]);
               K = min(K);
               L = length(disp);
               [~,K2] = min(disp);
               phase = 1 - K/K2;
               Phaseall(p1i,p3i) = phase/2;
        end
end


C = copper(6);
C2 = turbo(9);
indicesp1 = 1:1:length(P1allfinal);

figure(1)
surf(1./P1allfinal(1,indicesp1), P3all, Phaseall(indicesp1,:)','edgecolor','none','facecolor','interp');
colormap(parula(50));
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
cb = colorbar;
set(cb,'TickLength',[0 0.01]);
set(cb,'Box','off');
set(gca, 'XScale', 'log');
set(gca,'XTick',[], 'YTick', []);
grid off


figure(2)
xlabel('P1');
ylabel('P3');
load('frequencies_RE.mat');
h(1) = plot(1./repelem(P1_hawkmoth,3),F(1).f,'-o','color',C2(1,:),'MarkerFaceColor',C2(1,:));
hold on;
set(gca, 'XScale', 'log');
h(2) = plot(1./P1_hummingbird,F(2).f,'-o','color',C2(2,:),'MarkerFaceColor',C2(2,:));
legend(h,'hawkmoth','hummingbird');
title('active_time');
xlim(XL);
ylim(YL);
