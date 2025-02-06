P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P3all = [0.4 0.5 0.6 0.7 0.8 0.85 0.9 0.95 1 1.05 1.1 1.2 1.4 1.6 1.8 2 2.2];
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

for p3i = 1:1:length(P3all)
    P3 = P3all(p3i);
    mdl = 'sync_flier_modelling_non_d';
    filestr = ['Consolidated_data_sync/sync_all_data_final_' num2str(P3) '.mat'];
    load(filestr,'P2new');
    index = 1;
    for p1i = 1:1:length(P1allfinal)
        P1 = P1allfinal(1,p1i);
        P2 = P2new(1,p1i);
        if p1i < 6
            Tt = 1000;
        else
            Tt = 500;
        end

        in(index) = Simulink.SimulationInput(mdl);
        in(index) = in(index).setVariable('xu_min',xu_min);
        in(index) = in(index).setVariable('xd_max',xd_max);
        in(index) = in(index).setVariable('xt',xt);
        in(index) = in(index).setVariable('dt',dt);
        in(index) = in(index).setVariable('ku',ku);
        in(index) = in(index).setVariable('kd',kd);
        in(index) = in(index).setVariable('kt',kt);
        in(index) = in(index).setVariable('P1',P1);
        in(index) = in(index).setVariable('P2',P2);
        in(index) = in(index).setVariable('Tt',Tt);
        in(index) = in(index).setVariable('P3',P3);
        index = index + 1;
    end
    %outall = sim(in,'ShowProgress','off');
    outall(1:8) = parsim(in(1:8),'ShowProgress','off');
    outall(9:16) = parsim(in(9:16),'ShowProgress','off');
    outall(17:24) = parsim(in(17:24),'ShowProgress','off');
    outall(25:27) = parsim(in(25:27),'ShowProgress','off');
    % outall(33:length(P1allfinal)) = parsim(in(33:length(P1allfinal)),'ShowProgress','off');
    index = 1;
    for p1i = 1:1:length(P1allfinal)
        out = outall(index);
        sync_flier_model_params_non_d
        A = max(disp) - min(disp);
        tspringwork = -tspringwork - min(-tspringwork);
        uspringwork = -uspringwork - min(-uspringwork);
        dspringwork = -dspringwork - min(-dspringwork);
        filestr = ['Data_sync/datasync_thorax_1_' num2str(P3) '_' num2str(p1i)  '.mat'];
        save(filestr,'disp','muscleforce_d','muscleforce_u','inertiaenergy','vel','workp','workn','accel','aerowork','tspringwork','uspringwork','dspringwork','posforcework','negforcework','posforce','negforce','P2');
        index = index + 1;
    end
end
