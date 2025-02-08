clear all;
P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2.0 2.2];
Achange_all = [0.6 0.8 1.0 1.2 1.4];

P2all_sync = zeros(length(P3all),length(P1allfinal));
P1all_async = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
filestr = ['Consolidated_data_async\async_all_data_final_' num2str(0.5) '.mat'];
lload(filestr);
P2all_async = P2new;

figure(1)
plot(1./P1all_async, 1./P2all_async,'color',[1 0 1],'linewidth',2);
xlabel('P1');
title(['amp_mod_async']);
set(gca, 'XScale', 'log');
