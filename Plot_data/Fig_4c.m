clear all;
P1allfinal = [0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20 32];
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2.0 2.2];
Achange_all = [0.6 0.8 1.0 1.2 1.4];

indicesp1 = [7:31 34:36];
P2all_sync = zeros(length(P3all),length(P1allfinal));
P1all_async = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
filestr = ['Consolidated_data_async\async_all_data_final_' num2str(0.5) '.mat'];
load(filestr);
P2all_async = P2new;

load('bumblebee.mat')

figure(12)
load('async_emergent_tp.mat');
hold on;
plot(1./P1all_async, 1./P2all_async,'color',[1 0 1],'linewidth',2);
xlabel('P1');

load('bumblebee.mat')
C2 = turbo(9);
clear h;
%hawkmoth_del = [1.4 1.03 1.33]./P2_hawkmoth;
h(1) = plot(1./P1_bumblebee(1,1),1./P2_bumblebee,'-o','color',C2(9,:),'MarkerFaceColor',C2(9,:));
legend(h,'bumblebee');
title(['amp_mod_async']);
set(gca, 'XScale', 'log');
% xlim(XL);
% ylim(YL);
saveas(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\Gain_async.pdf');
