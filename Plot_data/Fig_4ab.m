Time_period_all = zeros(5,31);
ME = zeros(5,31);
P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];

for p1i = 1:1:length(P1allnew)
    for ai = 1:1:5
          filestr = ['Emergent_time_amplitude/dataasync_' num2str(p1i) '_' num2str(ai) '.mat'];
          load(filestr);
          Waall = max(aerowork); 
          Total_muscle_work = max(abs(posforcework)) + max(abs(negforcework));
          ME(ai,p1i) = Waall./Total_muscle_work;                
          Time_period_all(ai,p1i) = (time(end) - time(1))/(2*pi);
    end 
end

figure(1);
C = copper(5);
plot(1./P1allnew,ME(1,:),'color',C(1,:));
hold on
plot(1./P1allnew,ME(2,:),'color',C(2,:));
plot(1./P1allnew,ME(3,:),'color',C(3,:));
plot(1./P1allnew,ME(4,:),'color',C(4,:));
plot(1./P1allnew,ME(5,:),'color',C(5,:));
ylim([0.5 1]);
set(gca, 'XScale', 'log')

figure(2)
C = copper(5);
plot(1./P1allnew,1./Time_period_all(1,:),'color',C(1,:));
hold on
plot(1./P1allnew,1./Time_period_all(2,:),'color',C(2,:));
plot(1./P1allnew,1./Time_period_all(3,:),'color',C(3,:));
plot(1./P1allnew,1./Time_period_all(4,:),'color',C(4,:));
plot(1./P1allnew,1./Time_period_all(5,:),'color',C(5,:));
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')