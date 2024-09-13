clear all;
P1 = 0.77;
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;
ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

P3 = 2.2;
P2 = 5;
out = sim('sync_flier_modelling_non_d.slx',500);
sync_flier_model_params_non_d
A = max(disp) - min(disp)
K1 = maxinertiaenergy/dampmaxwork;
K2 = abs(workn/(workp + workn));
dspringwork = -dspringwork - min(-dspringwork);
uspringwork = -uspringwork - min(-uspringwork);

K3 = dampmaxwork/(max(abs(posforcework)) + max(abs(negforcework)));
K4 = min(uspringwork + dspringwork)/max(inertiaenergy);

X = posforce> 0;
Ph1 = strfind(X',[0 1]);
Ph1 = min(Ph1);
L = length(disp);
[~,Ph2] = min(disp);
phase = 1 - Ph1/Ph2;
K5 = max(posforcework) + max(negforcework);

Hummingbird_data = [K1 K2 K3 K4 phase K5];


figure(1)
h1 = plot(disp*180/pi,-muscleforce_u,'linewidth',2);
hold on;
h2 = plot(disp*180/pi,muscleforce_d,'linewidth',2);
set(h1,'LineWidth',2);
set(h2,'LineWidth',2);
set(gca,'xtick',[]);
set(gca,'ytick',[]);
xlim([min(disp*180/pi) max(disp*180/pi)]);
ylim([min(muscleforce_d) max(muscleforce_d)]);
% save('hummingbird.mat','disp','P2','muscleforce_d','muscleforce_u','Otherparams');

P1_hummingbird = 0.77;
P3_hummingbird = 2.2;
P2_hummingbird = 5;

Achange_all = [0.6 0.8 1.0 1.2 1.4];
index = 1;

mdl = 'sync_flier_modelling_non_d';
for ai = 1:1:5
    P2 = P2_hummingbird*Achange_all(1,ai);

    in(index) = Simulink.SimulationInput(mdl);
    in(index) = in(index).setVariable('xu_min',xu_min);
    in(index) = in(index).setVariable('xd_max',xd_max);
    in(index) = in(index).setVariable('xt',xt);
    in(index) = in(index).setVariable('dt',dt);
    in(index) = in(index).setVariable('ku',ku);
    in(index) = in(index).setVariable('kd',kd);
    in(index) = in(index).setVariable('kt',kt);
    in(index) = in(index).setVariable('P1',P1_hummingbird);
    in(index) = in(index).setVariable('P2',P2);
    in(index) = in(index).setVariable('P3',P3_hummingbird);
    index = index + 1;
end
outall(1:5) = parsim(in(1:5),'ShowProgress','off');
force_amp = zeros(5,1);
Aall = zeros(5,1);
Eall = zeros(5,1);

for ai = 1:1:5
    P2 = P2_hummingbird*Achange_all(1,ai);
    out = outall(ai);
    sync_flier_model_params_non_d
    force_amp(ai,1) = max(abs(posforce));
    Aall(ai,1) = max(disp) - min(disp);
    Eall(ai,1) = max(posforcework) + max(negforcework);
end

save('hummingbird.mat','P1_hummingbird','P2_hummingbird','P3_hummingbird','Hummingbird_data','force_amp','Aall','Eall');