clear all;
Indices = [9 12 14 17 33];
MTall = [0 0.25 0.5 0.75 1];
P1allfinal = [0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20 32];
P3all = [1.2 1.1 1.0 0.9 0.8];
ylimall_min = [-0.2 -0.2 0 0 -2];
ylimall_max = [1.6 1.6 2 3.5 12];
F_max = zeros(5,5);
MT = 0;  %% 1 for ai and 0 for aii

for p3i = 1:1:5
    P3 = P3all(1,p3i);
    filestr = ['Consolidated_data_sync/sync_all_data_final_' num2str(P3) '.mat'];
    load(filestr);
    for p1i = 1:1:5
        P1 = P1allfinal(Indices(p1i));
        filestr = ['Different_lambda_stiff_sync/datasync_thorax_' num2str(MT) '_' num2str(P3) '_' num2str(P1) '.mat'];
        load(filestr);
        subplot(5,5,(6-p1i) + (p3i-1)*5);
        h1 = plot(disp*180/pi,-muscleforce_u,'linewidth',2);
        hold on;
        h2 = plot(disp*180/pi,muscleforce_d,'linewidth',2);
        set(h1,'LineWidth',2);
        set(h2,'LineWidth',2);
        % ylimall = [min(muscleforce_d) max(muscleforce_d)];
        set(gca,'xtick',[])
        set(gca,'ytick',[])
        ylim([0 max(muscleforce_d)]);
        xlim([min(disp*180/pi) max(disp*180/pi)]);
        F_max(p3i,p1i) = max(muscleforce_d);
        F_min(p3i,p1i) = min(muscleforce_d);
        P2_all(p3i,p1i) = P2new(1,Indices(1,p1i));
    end
end


