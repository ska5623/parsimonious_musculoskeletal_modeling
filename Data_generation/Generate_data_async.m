P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
t0 = 0.5;

xu_min = 0.5;
xd_max = 0;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

filestr = ['Consolidated_data_async/async_all_data_final_' num2str(t0) '.mat'];
load(filestr);

Otherparams = zeros(length(P1allnew),7);
P2new = zeros(1,length(P1allnew));
for p1i = 1:1:length(P1allnew)
    P1 = P1allnew(1,p1i);
    P2 = P2new(1,p1i);
    out = sim('async_flier_modelling_non_d.slx',500);
    async_flier_model_params_non_d
    Otherparams(p1i,1) = dampmaxwork;
    Otherparams(p1i,2) = maxdspringwork;
    Otherparams(p1i,3) = maxinertiaenergy;
    Otherparams(p1i,4) = maxinertiaenergy/dampmaxwork;
    Otherparams(p1i,5) = workp;
    Otherparams(p1i,6) = workn;
    Otherparams(p1i,7) = abs(Otherparams(p1i,6)/(Otherparams(p1i,5)+Otherparams(p1i,6)));
    P2new(1,p1i) = P2;
    filestr = ['Data_async/dataasync_thorax_1_' num2str(p1i) '.mat'];
    save(filestr,'time','disp','posforce','negforce','muscleforce_d','muscleforce_u','inertiaenergy','vel','workp','workn','accel','aerowork','tspringwork','uspringwork','dspringwork','posforcework','negforcework');
end

