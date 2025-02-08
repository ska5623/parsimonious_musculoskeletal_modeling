clear;
P1allfinal = [0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20];
P3all = [0.8 0.9 1 1.1 1.2];

xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

mti = 0.5;
ku = (1-mti)*0.5;
kd = (1-mti)*0.5;
kt = 1 - ku - kd;

p3i = 1;
P3 = P3all(1,p3i);
filestr = ['Consolidated_data_sync\sync_all_data_final_' num2str(P3) '.mat'];
load(filestr);

p1i = 14; %length(P1allfinal)
P1 = P1allfinal(1,p1i);
P2 = P2new(1,p1i);
out = sim('sync_flier_modelling_non_d.slx',1000);
sync_flier_model_params_non_d

L = length(disp);
disp2 = zeros(1,L);
for i = 2:1:L
    disp2(1,i) = disp2(1,i-1) + vel(i-1)*dt;
end

min_xd = 1;
min_xu = -1;
tspringenergy = 0.5*kt*disp.^2;
dspringenergy = 0.5*ku*(disp - min_xd).^2;
uspringenergy = 0.5*kd*(disp - min_xu).^2;


figure(1)

plot(timec,-tspringwork - min(-tspringwork),'linewidth',2)
hold on
plot(timec,-uspringwork - min(-uspringwork),'linewidth',2)
plot(timec,-dspringwork - min(-dspringwork),'linewidth',2)
plot(timec,-tspringwork - min(-tspringwork)-dspringwork - min(-dspringwork)-uspringwork - min(-uspringwork),'linewidth',2)
legend('thorax spring energy','neg spring energy','pos spring energy','total spring energy');
xlabel('time (sec)');
ylabel('energy (J)');