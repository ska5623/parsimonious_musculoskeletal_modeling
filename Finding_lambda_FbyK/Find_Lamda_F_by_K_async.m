P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
t0 = 0.5;
limitasyncn = zeros(length(P1allnew),1);
limitasyncn(1:5,1) = 0.003;
limitasyncn(6:10,1) = 0.006;
limitasyncn(11:15,1) = 0.01;
limitasyncn(16:20,1) = 0.02;
limitasyncn(21:25,1) = 0.04;
limitasyncn(25:length(P1allnew),1) = 0.08;

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
for p1i = 1:1:length(P1allnew)
    P1 = P1allnew(1,p1i);
    if p1i == 1
        P2 = P2initial;
    else
        P2 = P2new(1,p1i-1);
    end
    out = sim('async_flier_modelling_non_d.slx',500);
    async_flier_model_params_non_d
    A = max(disp) - min(disp);
    Aolddiff = abs(A - 2);
    limitasync = limitasyncn;
    if abs(A - 2) < 0.025
    else
        index = 1;
        while abs(A - 2) > 0.025 && P2 > 0
            if index > 1 && abs(A-2) > Aolddiff
                limitasync = limitasync/2;
            end
            if A - 2 > 0.025
                P2 = P2 - limitasync(p1i,1);
            elseif A - 2 < -0.025
                P2 = P2 + limitasync(p1i,1);
            end
            out = sim('async_flier_modelling_non_d.slx',500);
            async_flier_model_params_non_d
            Aolddiff = abs(A - 2);
            A = max(disp) - min(disp);
            [P2 A]
            index = index + 1;
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
end

filestr = ['Consolidated_data_async/async_all_data_final_0.5.mat'];
save(filestr,'Otherparams','P2new');
