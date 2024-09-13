clear all;
t0 = 0.5;
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

P1 = 0.75;
P2 = 0.64;
MT = (1-0.42);
ku = MT*0.5;
kd = MT*0.5;
kt = 1 - ku - kd;

out = sim('async_flier_modelling_non_d.slx',500);
async_flier_model_params_non_d
max(disp) - min(disp)
K1 = maxinertiaenergy/dampmaxwork;
K2 = abs(workn/(workp + workn));
dspringwork = -dspringwork - min(-dspringwork);
uspringwork = -uspringwork - min(-uspringwork);

K3 = dampmaxwork/(max(abs(posforcework)) + max(abs(negforcework)));
K4 = min(uspringwork + dspringwork)/max(inertiaenergy);
K5 = max(posforcework) + max(negforcework);

X = posforce> 0;
Ph1 = strfind(X',[0 1]);
Ph1 = min(Ph1);
L = length(disp);
[~,Ph2] = min(disp);
phase = 1 - Ph1/Ph2;
e_time = time(end) - time(1);
       
P1_bumblebee = 0.75;
P2_bumblebee = 0.64;
MT_bumblebee = (1-0.42);
bumblebee_data = [K1 K2 K3 K4 phase e_time K5];

Achange_all = [0.6 0.8 1.0 1.2 1.4];
index = 1;

mdl = 'async_flier_modelling_non_d';
for ai = 1:1:5
    P2 = P2_bumblebee*Achange_all(1,ai);
    in(index) = Simulink.SimulationInput(mdl);
    in(index) = in(index).setVariable('xu_min',xu_min);
    in(index) = in(index).setVariable('xd_max',xd_max);
    in(index) = in(index).setVariable('xt',xt);
    in(index) = in(index).setVariable('dt',dt);
    in(index) = in(index).setVariable('ku',ku);
    in(index) = in(index).setVariable('kd',kd);
    in(index) = in(index).setVariable('kt',kt);
    in(index) = in(index).setVariable('P1',P1_bumblebee);
    in(index) = in(index).setVariable('P2',P2);
    in(index) = in(index).setVariable('t0',t0);
    index = index + 1;
end
outall(1) = sim(in(1),'ShowProgress','off');
outall(2) = sim(in(2),'ShowProgress','off');
outall(3) = sim(in(3),'ShowProgress','off');
outall(4) = sim(in(4),'ShowProgress','off');
outall(5) = sim(in(5),'ShowProgress','off');
force_amp= zeros(5,1);
Aall = zeros(5,1);
Eall = zeros(5,1);
for ai = 1:1:5
    P2 = P2_bumblebee*Achange_all(1,ai);
    out = outall(ai);   
    async_flier_model_params_non_d
    force_amp(ai,1) = max(abs(posforce));
    Aall(ai,1) = max(disp) - min(disp);
    Eall(ai,1) = max(posforcework) + max(negforcework);
end
save('bumblebee.mat','P1_bumblebee','P2_bumblebee','MT_bumblebee','bumblebee_data','force_amp','Aall','Eall');