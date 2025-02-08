P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
t0 = 0.5;
P1all = [2 4 6 14 31];
ylimall_min = [-0.2 0 0 0 -0.5];
ylimall_max = [1.2 1.2 1.6 2.5 4.5];
MTall = [0 0.25 0.5 0.75 1];
P3 = 1;
xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;

P1all = [2 4 6 14 31];
ylimall_min = [0 0 0 0 0];
ylimall_max = [1.2 1.2 1.6 2.1 4.5];
F_max = zeros(5,5);
F_min = zeros(5,5);
for mti = 1:1:5
    for p1i = 1:1:5
        P1 = P1allnew(P1all(p1i));
        MT = MTall(1,mti);
        filestr = ['Different_lambda_thorax_async/dataasync_thorax_' num2str(MT) '_' num2str(P1all(p1i))  '.mat'];
        load(filestr);
        K1all(p1i,mti) = K1;
        K2all(p1i,mti) = K2;

        subplot(5,5,p1i + (mti-1)*5);
        h1 = plot(disp*180/pi,-muscleforce_u,'linewidth',2);
        set(h1,'LineWidth',2);
        set(gca,'xtick',[])
        set(gca,'ytick',[])
        ylim([0 max(muscleforce_d)]);
        xlim([min(disp*180/pi) max(disp*180/pi)]);
        F_max(mti,p1i) = max(muscleforce_d);
        F_min(mti,p1i) = min(muscleforce_d);
    end
end

