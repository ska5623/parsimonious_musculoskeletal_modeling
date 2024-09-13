clear;

P1allfinal = [0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20];

xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;
   
P1 = 0.64;
MTall = [0.89 0.77 0.66];
P2all = [0.49 0.54 1.45];
P3all = [0.8 1 1.4];

Hawkmoth_data = zeros(3,6);
for mti = 1:1:3
    P3 = P3all(1,mti);
    MT = 1 - MTall(1,mti);
    P2 = P2all(1,mti);
    
    ku = MT*0.5;
    kd = MT*0.5;
    kt = 1 - ku - kd;
    out = sim('sync_flier_modelling_non_d.slx',500);
    sync_flier_model_params_non_d
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

    Hawkmoth_data(mti,:) = [K1 K2 K3 K4 phase K5];
    
    figure(mti)
    h1 = plot(disp*180/pi,-muscleforce_u,'linewidth',2);
    hold on;
    h2 = plot(disp*180/pi,muscleforce_d,'linewidth',2);
    set(h1,'LineWidth',2);
    set(h2,'LineWidth',2);
    set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    xlim([min(disp*180/pi) max(disp*180/pi)]);
    ylim([min(muscleforce_d) max(muscleforce_d)]);
end
P1_hawkmoth = 0.64;
MT_hawkmoth = [0.89 0.77 0.66];
P2_hawkmoth = [0.49 0.54 1.45];
P3_hawkmoth = [0.8 1 1.4];

Achange_all = [0.6 0.8 1.0 1.2 1.4];
index = 1;

mdl = 'sync_flier_modelling_non_d';

force_amp = zeros(3,5,1);
Aall = zeros(3,5,1);
Eall = zeros(3,5,1);

for p2i = 1:1:3
    for ai = 1:1:5
        P2 = P2_hawkmoth(1,p2i)*Achange_all(1,ai);

        in(index) = Simulink.SimulationInput(mdl);
        in(index) = in(index).setVariable('xu_min',xu_min);
        in(index) = in(index).setVariable('xd_max',xd_max);
        in(index) = in(index).setVariable('xt',xt);
        in(index) = in(index).setVariable('dt',dt);
        in(index) = in(index).setVariable('ku',ku);
        in(index) = in(index).setVariable('kd',kd);
        in(index) = in(index).setVariable('kt',kt);
        in(index) = in(index).setVariable('P1',P1_hawkmoth);
        in(index) = in(index).setVariable('P2',P2);
        in(index) = in(index).setVariable('P3',P3_hawkmoth(p2i));
        index = index + 1;
    end
end
outall(1:15) = parsim(in(1:15),'ShowProgress','off');

index = 1;
for p2i = 1:1:3
    for ai = 1:1:5
        P2 = P2_hawkmoth(1,p2i)*Achange_all(1,ai);
        out = outall(index);
        sync_flier_model_params_non_d
        force_amp(p2i,ai,1) = max(abs(posforce));
        Aall(p2i,ai,1) = max(disp) - min(disp);
        Eall(p2i,ai,1) = max(posforcework) + max(negforcework);
        index = index + 1;
    end
end

save('hawkmoth.mat','Hawkmoth_data','P1_hawkmoth','MT_hawkmoth','P2_hawkmoth','P3_hawkmoth','force_amp','Aall','Eall');
