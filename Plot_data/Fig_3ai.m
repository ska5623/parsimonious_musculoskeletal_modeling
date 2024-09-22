clear;
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2.0 2.2];
P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];

si = 1;
ei = 27;
indicesp1 = si:1:ei;

dispall = zeros(length(P3all),length(indicesp1));
for p3i = 1:1:length(P3all)
    for p1i =si:1:length(P1allfinal)
        filestr = ['Thorax_data_sync_no_spring/datasync_' num2str(P3all(p3i)) '_' num2str(p1i)  '.mat'];
        load(filestr);
        dispall(p3i,p1i-si+1) = max(disp) - min(disp);
        Waall(p3i,p1i-si+1) = max(aerowork);
        Total_muscle_work(p3i,p1i-si+1) = max(abs(posforcework)) + max(abs(negforcework));
    end
end

figure(1)
surf(1./P1allfinal(1,indicesp1), P3all, Waall./Total_muscle_work,'edgecolor','none','facecolor','interp');
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
cb = colorbar;
set(cb,'TickLength',[0 0.01]);
set(gca, 'XScale', 'log');
set(cb,'Box','off');
grid off
title('muscle efficiency');
xlim([0.1 10]);
ylim([min(P3all) max(P3all)]);
