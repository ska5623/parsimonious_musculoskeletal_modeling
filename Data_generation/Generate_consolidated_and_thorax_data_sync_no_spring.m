P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2 2.2];
dt = 0.001;

for p3i = 1:1:length(P3all)
    mdl = 'sync_flier_modelling_non_d_no_spring';
    P3 = P3all(p3i);
    filestr = ['Consolidated_data_sync_no_stiff/sync_all_data_final_no_spring_' num2str(P3) '.mat'];
    load(filestr,'P2new');
    for p1i = 1:1:length(P1allfinal)
        P1 = P1allfinal(1,p1i);
        P2 = P2new(1,p1i);
        if p1i < 6
            Tt = 1000;
        else
            Tt = 500;
        end

        in(index) = Simulink.SimulationInput(mdl);
        in(index) = in(index).setVariable('dt',dt);
        in(index) = in(index).setVariable('P1',P1);
        in(index) = in(index).setVariable('P2',P2);
        in(index) = in(index).setVariable('Tt',Tt);
        in(index) = in(index).setVariable('P3',P3);

        index = index + 1;
    end
    outall = sim(in,'ShowProgress','off');

    index = 1;
    for p1i = 1:1:length(P1allfinal)
        out = outall(index);
        sync_flier_model_params_non_d_no_spring
        A = max(disp) - min(disp);
        filestr = ['Thorax_data_sync_no_spring/datasync_' num2str(P3) '_' num2str(p1i)  '.mat'];
        save(filestr,'disp','muscleforce_d','muscleforce_u','inertiaenergy','vel','workp','workn','accel','aerowork','posforcework','negforcework','posforce','negforce','P2');
        index = index + 1;
    end
end