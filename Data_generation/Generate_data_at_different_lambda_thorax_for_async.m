P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
t0 = 0.5;
P1all = [2 4 6 14 31];
ylimall_min = [-0.2 0 0 0 -0.5];
ylimall_max = [1.2 1.2 1.6 2.5 4.5];
MTall = [0 0.25 0.5 0.75 1];
P3 = 1;
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

if kt < 0
    fddf
end
for p1i = 1:1:5
    filestr = ['Consolidated_data_async/async_all_data_final_' num2str(t0) '.mat'];
    load(filestr);
    P1 = P1allnew(P1all(p1i));
    P2 = P2new(P1all(p1i));

    for mti = 1:1:5
        MT = MTall(1,mti);
        ku = MT*0.5;
        kd = MT*0.5;
        kt = 1 - ku - kd;
        out = sim('async_flier_modelling_non_d.slx',500);
        async_flier_model_params_non_d
        K1 = maxinertiaenergy/dampmaxwork;
        K2 = abs(workn/(workp + workn));
        filestr = ['Different_lambda_thorax_async/dataasync_thorax_' num2str(MT) '_' num2str(P1all(p1i)) '.mat'];
        save(filestr,'disp','muscleforce_d','muscleforce_u','K1','K2');
    end
end