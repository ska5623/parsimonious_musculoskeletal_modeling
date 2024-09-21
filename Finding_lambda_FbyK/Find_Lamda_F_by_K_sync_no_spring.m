P1allfinal = [0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20 32];
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2 2.2];
limitsall = zeros(4,length(P1allfinal));
limitsall(1,1:10) = 0.1;
limitsall(1,11:20) = 0.2;
limitsall(1,21:30) = 0.4;
limitsall(1,31:length(P1allfinal)) = 1;
limitsall(2,1:10) = 0.05;
limitsall(2,11:20) = 0.1;
limitsall(2,21:30) = 0.2;
limitsall(2,31:length(P1allfinal)) = 0.5;
limitsall(3,1:10) = 0.02;
limitsall(3,11:20) = 0.05;
limitsall(3,21:30) = 0.1;
limitsall(3,31:length(P1allfinal)) = 0.2;
limitsall(4,1:10) = 0.01;
limitsall(4,11:20) = 0.02;
limitsall(4,21:30) = 0.04;
limitsall(4,31:length(P1allfinal)) = 0.1;
dt = 0.001;
P2initial = 1;
for p3i = 1:1:length(P3all)
    mdl = 'sync_flier_modelling_non_d_no_spring';
    P3 = P3all(p3i);
    trueall = zeros(1,length(P1allfinal));
    while (sum(trueall) < length(P1allfinal))
        clear in;
        index = 1;
        for p1i = 1:1:length(P1allfinal)
            if trueall(1,p1i) == 0
                P1 = P1allfinal(1,p1i);
                if p1i == 1
                    P2 = P2initial;
                else
                    P2 = P2new(1,p1i-1);
                end
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
        end
        outall = sim(in,'ShowProgress','off');

        index = 1;
        for p1i = 1:1:length(P1allfinal)
            if trueall(1,p1i) == 0
                out = outall(index);
                sync_flier_model_params_non_d_no_spring
                A = max(disp) - min(disp);
                if abs(A - 2) < 0.05
                    trueall(1,p1i) = 1;
                    Otherparams = zeros(6,1);
                    Otherparams(p1i,1) = dampmaxwork;
                    Otherparams(p1i,2) = maxinertiaenergy;
                    Otherparams(p1i,3) = maxinertiaenergy/dampmaxwork;
                    Otherparams(p1i,4) = workp;
                    Otherparams(p1i,5) = workn;
                    Otherparams(p1i,6) = abs(workn)/abs(workn + workp);
                    filestr = ['Consolidated_data_sync_no_stiff/sync_all_data_final_no_spring_' num2str(P3) '.mat'];
                    save(filestr,'Otherparams','P2new');
                elseif A - 2 > 0.5
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(1,p1i);
                elseif A - 2 > 0.25
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(2,p1i);
                elseif A - 2 > 0.1
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(3,p1i);
                elseif A - 2 > 0.05
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(4,p1i);
                elseif A - 2 < -0.5
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(1,p1i);
                elseif A - 2 < -0.25
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(2,p1i);
                elseif A - 2 < -0.1
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(3,p1i);
                elseif A - 2 < -0.05
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(4,p1i);
                end

                if P2new(1,p1i) < 0
                    P2new(1,p1i) = 0.01;
                end
                index = index + 1;
            end
        end
    end
end
