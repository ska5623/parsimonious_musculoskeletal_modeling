clear;
P3all = [0.4 0.5 0.6 0.7 0.8 0.85 0.9 0.95 1 1.05 1.1 1.2 1.4 1.6 1.8 2 2.2];
P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P1all_async = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];

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
hold on;
af = 3;
%contour3(1./P1allfinal(1,indicesp1), P3all, smoothdata(phi_workloop,'gaussian')+af,[2 4 6 8 10]+af,'ShowText','on','color','black','linewidth',2)
contour3(1./P1allfinal(1,indicesp1), P3all,phi_workloop+af,[2 4 6 8 10]+af,'ShowText','on','color','black','linewidth',2)
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
%saveas(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\PhiWL.pdf')
exportgraphics(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\PhiWL2.eps','ContentType','vector');

figure(2)
K = colormap(turbo(200));
K2 = [K(1:160,:); repmat(K(160,:),800,1)];
colormap(K2);
surf(1./P1allfinal(1,indicesp1), P3all, Min_Spring_energy.*phi_inertia,'edgecolor','none','facecolor','interp');
hold on;
af = 2;
%contour3(1./P1allfinal(1,indicesp1), P3all, smoothdata(Min_Spring_energy.*phi_inertia+af,'gaussian'),af+[0.5 1 1.5 2],'ShowText','on','color','black','linewidth',2)
contour3(1./P1allfinal(1,indicesp1), P3all, Min_Spring_energy.*phi_inertia+af,af+[0.5 1 1.5 2],'ShowText','on','color','black','linewidth',2)
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
set(gca, 'XScale', 'log');
cb = colorbar;
set(cb,'YLim',[0 2.5]);
set(cb,'TickLength',[0 0.01]);
set(cb,'Box','off');
grid off
%saveas(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\PhiSE.pdf')
exportgraphics(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\PhiSE.eps','ContentType','vector');

figure(3)
surf(1./P1allfinal(1,indicesp1), P3all, Waall./Total_muscle_work,'edgecolor','none','facecolor','interp');
hold on;
af = 0.001;
contour3(1./P1allfinal(1,indicesp1), P3all, Waall./Total_muscle_work+af,[0.2 0.4 0.6 0.8 1.0],'ShowText','on','color','black','linewidth',2)
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
cb = colorbar;
set(cb,'TickLength',[0 0.01]);
set(gca, 'XScale', 'log');
set(cb,'Box','off');
set(gca,'XTick',[], 'YTick', [])
grid off
%saveas(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\PhiME.pdf')
exportgraphics(gcf,'C:\Users\suyas\OneDrive - The Pennsylvania State University\Box sync\PhD\Journal papers\Work loop paper\Figures\pdfs\contours\PhiME.eps','ContentType','vector');

