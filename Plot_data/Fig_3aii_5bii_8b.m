clear;
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2.0 2.2];
P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P1all_async = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];

load('hummingbird.mat');
load('hawkmoth.mat');
si = 1;
ei = length(P1allfinal);
indicesp1 = si:1:ei;
sia = 1;
eia = length(P1all_async);
indicesp1a = sia:1:eia;

for p3i = 1:1:length(P3all)
    filestr = ['Consolidated_data_sync/sync_all_data_final_' num2str(P3all(p3i)) '.mat'];
    load(filestr);
    phi_inertia(p3i,:) = Otherparams(indicesp1,4);
    phi_workloop(p3i,:) = Otherparams(indicesp1,7);
    dyn_eff(p3i,:) = Otherparams(indicesp1,1)./(Otherparams(indicesp1,1) + Otherparams(indicesp1,3));
    P2_all(p3i,:) = P2new(1,indicesp1);
end

dispall = zeros(length(P3all),length(indicesp1));
for p3i = 1:1:length(P3all)
    for p1i =si:1:length(P1allfinal)
        filestr = ['Thorax data sync/datasync_thorax_1_' num2str(P3all(p3i)) '_' num2str(p1i)  '.mat'];
        load(filestr);
        dispall(p3i,p1i-si+1) = max(disp) - min(disp);
        Waall(p3i,p1i-si+1) = max(aerowork);
        Total_muscle_work(p3i,p1i-si+1) = max(abs(posforcework)) + max(abs(negforcework));
        Min_Spring_energy(p3i,p1i-si+1) = min(dspringwork + uspringwork)/max(inertiaenergy);
        Min_Spring_energy2(p3i,p1i-si+1) = min(dspringwork + uspringwork + tspringwork)/max(inertiaenergy);
    end
end

C = copper(6);
C2 = turbo(9);

figure(1)
K = colormap(turbo(200));
% % K = flip(K);
K2 = [K(1:160,:); repmat(K(160,:),1000,1)];

surf(1./P1allfinal(1,indicesp1), P3all, phi_workloop,'edgecolor','none','facecolor','interp');
colormap(K2);
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
cb = colorbar;
set(cb,'YLim',[0 10]);
set(cb,'Box','off');
set(cb,'TickLength',[0 0.01]);
set(gca, 'XScale', 'log');
set(gca,'XTick',[], 'YTick', [])
grid off

figure(2)
xlabel('P1');
ylabel('P3');
load('frequencies_RE.mat');
h(1) = plot(1./repelem(P1_hawkmoth,3),F(1).f,'-o','color',C2(1,:),'MarkerFaceColor',C2(1,:));
hold on;
h(2) = plot(1./P1_hummingbird,F(2).f,'-o','color',C2(2,:),'MarkerFaceColor',C2(2,:));
legend(h,'hawkmoth','hummingbird');
title('Phi_workloop');
set(gca, 'XScale', 'log');
xlim(XL);
ylim(YL);

figure(3)
K = colormap(turbo(200));
K2 = [K(1:160,:); repmat(K(160,:),800,1)];
colormap(K2);
surf(1./P1allfinal(1,indicesp1), P3all, Min_Spring_energy.*phi_inertia,'edgecolor','none','facecolor','interp');
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
set(gca, 'XScale', 'log');
cb = colorbar;
set(cb,'YLim',[0 2.5]);
set(cb,'TickLength',[0 0.01]);
set(cb,'Box','off');
grid off

figure(4)
load('frequencies_RE.mat');
h(1) = plot(1./repelem(P1_hawkmoth,3),F(1).f,'-o','color',C2(1,:),'MarkerFaceColor',C2(1,:));
hold on;
h(2) = plot(1./P1_hummingbird,F(2).f,'-o','color',C2(2,:),'MarkerFaceColor',C2(2,:));
xlabel('P1');
ylabel('P3');
legend(h,'hawkmoth','hummingbird');
title('min_spring_energy/phi_inertia');
set(gca, 'XScale', 'log');
xlim(XL);
ylim(YL);

figure(5)
surf(1./P1allfinal(1,indicesp1), P3all, Waall./Total_muscle_work,'edgecolor','none','facecolor','interp');
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
cb = colorbar;
set(cb,'TickLength',[0 0.01]);
set(gca, 'XScale', 'log');
set(cb,'Box','off');
set(gca,'XTick',[], 'YTick', [])
grid off

figure(6)
load('frequencies_RE.mat');
h(1) = plot(1./repelem(P1_hawkmoth,3),F(1).f,'-o','color',C2(1,:),'MarkerFaceColor',C2(1,:));
hold on;
xlabel('P1');
ylabel('P3');
h(2) = plot(1./P1_hummingbird,F(2).f,'-o','color',C2(2,:),'MarkerFaceColor',C2(2,:));
legend(h,'hawkmoth','hummingbird');
title('muscle efficiency');
set(gca, 'XScale', 'log');
xlim(XL);
ylim(YL);

% close all;

figure(7)
K = colormap(turbo(200));
K2 = [K(1:160,:); repmat(K(160,:),800,1)];
colormap(K2);
EEvals = Min_Spring_energy.*phi_inertia;
surf(1./P1allfinal(1,indicesp1), P3all, EEvals,'edgecolor','none','facecolor','interp');
view(0,90);
set(gca, 'XScale', 'log');
set(gca,'XTick',[], 'YTick', []);
xlim([1./P1allfinal(1,end) 10]);
ylim([min(P3all) max(P3all)]);
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
grid off


figure(8)
load('frequencies_RE.mat');
h(1) = plot(ones(1,3)./P1_hawkmoth,F(1).f,'-o','color',C2(2,:),'MarkerFaceColor',C2(2,:));
hold on;
h(2) = plot(1./P1_hummingbird,F(2).f,'-o','color',C2(2,:),'MarkerFaceColor',C2(2,:));
legend(h,'hawkmoth','hummingbird');
set(gca, 'XScale', 'log');
xlim(XL);
ylim(YL);

