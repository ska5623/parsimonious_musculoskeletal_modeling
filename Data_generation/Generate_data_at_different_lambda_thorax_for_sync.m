clear all;
Indices = [9 12 14 17 33];
MTall = [0 0.25 0.5 0.75 1];
P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];

%% simulations for thorax work loop map
P3all = [0.8 0.9 1 1.1 1.2];
MTall = [1 0.75 0.5 0.25 0];
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

for p3i = 1:1:5
    P3 = P3all(1,p3i);
    for p1i = 1:1:length(Indices)
        filestr = ['Consolidated_data_sync/sync_all_data_final_' num2str(P3) '.mat'];
        load(filestr);
        P1 = P1allfinal(Indices(p1i));
        P2 = P2new(Indices(p1i));
        for mti = 1:1:5
            MT = MTall(1,mti);
            ku = MT*0.5;
            kd = MT*0.5;
            kt = 1 - ku - kd;
            out = sim('sync_flier_modelling_non_d.slx',500);
            sync_flier_model_params_non_d
            max(disp) - min(disp)
            K1 = maxinertiaenergy/dampmaxwork;
            K2 = abs(workn/(workp + workn));
            filestr = ['Different_lambda_thorax_sync/datasync_thorax_' num2str(MT) '_' num2str(P3) '_' num2str(P1) '.mat'];
            save(filestr,'disp','muscleforce_d','muscleforce_u','K1','K2','vel','accel','dampmaxwork', 'maxdspringwork', 'maxinertiaenergy', 'workp', 'workn');
        end
    end
end

