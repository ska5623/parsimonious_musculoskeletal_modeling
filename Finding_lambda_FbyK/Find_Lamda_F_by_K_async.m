P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20 32];
t0 = 0.5;

xu_min = 0.5;
xd_max = 0;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

P2initial = 0.1;
Otherparams = zeros(length(P1allnew),7);
P2new = zeros(1,length(P1allnew));
for p1i = 1:1:2 % length(P1allnew)
    P1 = P1allnew(1,p1i);
    if p1i == 1
        P2 = P2initial;
    else
        P2 = P2new(1,p1i-1);
    end
    out = sim('async_flier_modelling_non_d.slx',500);
    async_flier_model_params_non_d
    A = max(disp) - min(disp);
    if abs(A - 2) < 0.025
    elseif A - 2 > 0.025
        while abs(A - 2) > 0.025 && P2 > 0
            P1 = P1allnew(1,p1i);
            P2 = P2 - 0.003;
            out = sim('async_flier_modelling_non_d.slx',500);
            async_flier_model_params_non_d
            A = max(disp) - min(disp);
            A
        end
    elseif A - 2 < -0.025
         while abs(A - 2) > 0.025 && P2 < 10
            P1 = P1allnew(1,p1i);
            P2 = P2 + 0.003;
            out = sim('async_flier_modelling_non_d.slx',500);
            async_flier_model_params_non_d
            A = max(disp) - min(disp);
            A
        end
    end
    Otherparams(p1i,1) = dampmaxwork;
    Otherparams(p1i,2) = maxdspringwork;
    Otherparams(p1i,3) = maxinertiaenergy;
    Otherparams(p1i,4) = maxinertiaenergy/dampmaxwork;
    Otherparams(p1i,5) = workp;
    Otherparams(p1i,6) = workn;
    Otherparams(p1i,7) = abs(Otherparams(p1i,6)/(Otherparams(p1i,5)+Otherparams(p1i,6)));
    P2new(1,p1i) = P2;
    filestr = ['Thorax data async/dataasync_thorax_1_' num2str(p1i) '.mat'];
    save(filestr,'time','disp','posforce','negforce','muscleforce_d','muscleforce_u','inertiaenergy','vel','workp','workn','accel','aerowork','tspringwork','uspringwork','dspringwork','posforcework','negforcework');
end

filestr = ['Consolidated_data_async/async_all_data_final_0.5.mat'];
save(filestr,'Otherparams','P2new');
