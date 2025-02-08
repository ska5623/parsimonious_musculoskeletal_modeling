clear;
P1all_async = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];

for p1i = 1:1:length(P1all_async)
    filestr = ['Data_async/dataasync_thorax_1_' num2str(p1i)  '.mat'];
    load(filestr);
    Min_Spring_energy_async(1,p1i) = min(-uspringwork - min(-uspringwork) -dspringwork - min(-dspringwork))/max(inertiaenergy);  % for async I didn't do the correction
end

filestr = ['Consolidated_data_async/async_all_data_final_0.5.mat'];
load(filestr);
phi_inertia_async = Otherparams(:,4);
phi_workloop_async = Otherparams(:,7);

C = copper(6);
C2 = turbo(9);

figure(1)
h(1) = plot(1./P1all_async,phi_workloop_async,'-','color',C(6,:));
xlabel('P1');
ylabel('phi_workloop');
set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log');


figure(2)
h(1) = plot(1./P1all_async, Min_Spring_energy_async.*phi_inertia_async','-','color',C(6,:));
xlabel('P1');
ylabel('Spring_energy');
set(gca, 'XScale', 'log')
