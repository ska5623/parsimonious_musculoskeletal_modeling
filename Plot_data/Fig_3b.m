P1allfinal = [0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
P3all = [0.4 0.5 0.6 0.7 0.8 0.85 0.9 0.95 1 1.05 1.1 1.2 1.4 1.6 1.8 2 2.2];
Achange_all = [0.6 0.8 1.0 1.2 1.4];

indicesp1 = 1:1:length(P1allfinal);
P2all_sync = zeros(length(P3all),length(P1allfinal));
for p3i = 1:1:length(P3all)
    P3 = P3all(p3i);
    filestr = ['Consolidated_data_sync\sync_all_data_final_' num2str(P3) '.mat'];
    load(filestr);
    for p1i = 1:1:length(P1allfinal)
        P2all_sync(p3i,p1i) = P2new(p1i);
        AM(p3i,p1i) = 1/P2new(p1i);
    end
end

P3all2 = zeros(1,length(P3all) - 1);
freq_mod = zeros(length(P3all) - 1,length(P1allfinal));
for p3i = 1:1:length(P3all)-1
    P3all2(1,p3i) = (P3all(1,p3i) + P3all(1,p3i+1))/2;
end

for p1i = 1:1:length(P1allfinal)
    for p3i = 1:1:length(P3all)-1 
       freq_mod(p3i,p1i) = abs(AM(p3i+1,p1i) - AM(p3i,p1i))/(P3all(p3i+1) - P3all(p3i));
    end
end

for p3i = 1:1:length(P3all2)
    freq_mod(p3i,:) = smooth(freq_mod(p3i,:));
end

figure(1)
C = copper(5);
surf(1./P1allfinal(1,indicesp1), P3all, 1./P2all_sync(:,indicesp1),'edgecolor','none','facecolor','interp');
hold on;
af = 0.5;
contour3(1./P1allfinal(1,indicesp1), P3all, 1./P2all_sync(:,indicesp1)+af,af + [0.5 1 2 3 4 5],'ShowText','on','color','black','linewidth',2)
XL = get(gca,'Xlim');
YL = get(gca,'Ylim');
view(0,90);
K = colormap(parula(400));
K2 = [K(2:380,:); repmat(K(380,:),400,1)];
colormap(K2);

cb = colorbar;
set(cb,'TickLength',[0 0.01]);
set(gca, 'XScale', 'log');
set(cb,'Box','off');
set(cb,'YLim',[0 6]);
set(gca,'XTick',[], 'YTick', [])
grid off

figure(2)
C = copper(5);
surf(1./P1allfinal(1,indicesp1), P3all2, freq_mod(:,indicesp1),'edgecolor','none','facecolor','interp');
hold on;
af = 2;
contour3(1./P1allfinal(1,indicesp1), P3all2, freq_mod(:,indicesp1)+af,af+[1 2 3.5 5 15 25 35],'ShowText','on','color','black','linewidth',2)
view(0,90);
K = colormap(parula(400));
K2 = [flip(K(1:380,:)); repmat(K(1,:),400,1)];
colormap(K2);
cb = colorbar;
set(cb,'TickLength',[0 0.01]);
set(gca, 'XScale', 'log');
set(cb,'Box','off');
set(cb,'YLim',[0 45]);
set(gca,'XTick',[], 'YTick', [])
grid off


