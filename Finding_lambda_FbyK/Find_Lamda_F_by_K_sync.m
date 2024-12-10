P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P3all = [0.4 0.5 0.6 0.7 0.8 0.85 0.9 0.95 1 1.05 1.1 1.2 1.4 1.6 1.8 2 2.2];
limitsalln = zeros(4,length(P1allfinal));
limitsalln(1,1:4) = 0.5;
limitsalln(1,5:14) = 1;
limitsalln(1,15:24) = 2.5;
limitsalln(1,25:length(P1allfinal)) = 5;
limitsalln(2,1:4) = 0.25;
limitsalln(2,5:14) = 0.5;
limitsalln(2,15:24) = 1;
limitsalln(2,25:length(P1allfinal)) = 2;
limitsalln(3,1:4) = 0.1;
limitsalln(3,5:14) = 0.25;
limitsalln(3,15:24) = 0.5;
limitsalln(3,25:length(P1allfinal)) = 1;
limitsalln(4,1:4) = 0.025;
limitsalln(4,5:14) = 0.07;
limitsalln(4,15:24) = 0.15;
limitsalln(4,25:length(P1allfinal)) = 0.3;
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

P2initial = 1;
Otherparams = zeros(length(P1allfinal),length(P3all));
for p3i = 1:1:length(P3all)
    P3 = P3all(p3i);
    P2new = zeros(1,length(P1allfinal));
    for p1i = 1:1:length(P1allfinal)
        P1 = P1allfinal(1,p1i);
        if p1i == 1
            P2 = P2initial;
        else
            P2 = P2new(1,p1i-1);
        end
        P2new(1,p1i) = P2;

        if p1i < 6
            Tt = 1000;
        else
            Tt = 500;
        end
        out = sim('sync_flier_modelling_non_d');
        sync_flier_model_params_non_d
        A = max(disp) - min(disp);
        [p1i A P2]
        Adiffold = abs(A - 2);
        index = 1;
        limitsall = limitsalln;
        while abs(A - 2) > 0.005
            if index > 1 && Adiffold < abs(A - 2)
                limitsall = limitsall/2;
            end
            if A - 2 > 0.5
                P2new(1,p1i) = P2new(1,p1i) - limitsall(1,p1i);
            elseif A - 2 > 0.25
                P2new(1,p1i) = P2new(1,p1i) - limitsall(2,p1i);
            elseif A - 2 > 0.1
                P2new(1,p1i) = P2new(1,p1i) - limitsall(3,p1i);
            elseif A - 2 > 0.005
                P2new(1,p1i) = P2new(1,p1i) - limitsall(4,p1i);
            elseif A - 2 < -0.5
                P2new(1,p1i) = P2new(1,p1i) + limitsall(1,p1i);
            elseif A - 2 < -0.25
                P2new(1,p1i) = P2new(1,p1i) + limitsall(2,p1i);
            elseif A - 2 < -0.1
                P2new(1,p1i) = P2new(1,p1i) + limitsall(3,p1i);
            elseif A - 2 < -0.005
                P2new(1,p1i) = P2new(1,p1i) + limitsall(4,p1i);
            end
            if P2new(1,p1i) < 0
                P2new(1,p1i) = 0.01;
            end
            P2 = P2new(1,p1i);
            out = sim('sync_flier_modelling_non_d');
            sync_flier_model_params_non_d
            Adiffold = abs(A-2);
            A = max(disp) - min(disp);
            [p1i A P2]
            index = index + 1;
        end

        Otherparams(p1i,1) = dampmaxwork;
        Otherparams(p1i,2) = maxdspringwork;
        Otherparams(p1i,3) = maxinertiaenergy;
        Otherparams(p1i,4) = maxinertiaenergy/dampmaxwork;
        Otherparams(p1i,5) = workp;
        Otherparams(p1i,6) = workn;
        Otherparams(p1i,7) = abs(workn)/abs(workn + workp);
        filestr = ['Consolidated_data_sync/sync_all_data_final_' num2str(P3) '.mat'];
        save(filestr,'Otherparams','P2new');

    end
end
