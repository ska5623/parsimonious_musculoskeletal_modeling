

% kt = 10*ku;
% P1 = 0.0017/0.01;
% P2 = (0.07*15)/6.3;

disp = out.displacement.data(1:end,1);

[pks,locs] = findpeaks(disp);
L = length(locs);
si = locs(L-2,1);
ei = locs(L-1,1);
k = L-2;
while abs(disp(si,1) - disp(ei,1)) > 0.1 
    si = locs(k-1,1);
    k = k - 1;
end

vel = out.velocity.data(si:ei,1);
disp = out.displacement.data(si:ei,1);
accel = out.accel.data(si:ei,1);

time = out.velocity.Time(si:ei,1);
springforce_t = out.springforce_t.data(si:ei,1);
dampforce_aero = out.dampforce_aero.data(si:ei,1);
springforce_d = out.springforce_d.data(si:ei,1);
springforce_u = out.springforce_u.data(si:ei,1);
posforce = out.posforce.data(si:ei,1);
negforce = out.negforce.data(si:ei,1);

aerowork = out.aerowork.data(si:ei,1);
aerowork = aerowork - min(aerowork);

tspringwork = out.tspringwork.data(si:ei,1);
tspringwork = -tspringwork;
tspringwork = tspringwork - min(tspringwork);

dspringwork = out.dspringwork.data(si:ei,1);
dspringwork = -dspringwork;
dspringwork = dspringwork - min(dspringwork);

uspringwork = out.uspringwork.data(si:ei,1);
uspringwork = -uspringwork;
uspringwork = uspringwork - min(uspringwork);

posforcework = out.posforcework.data(si:ei,1);
posforcework = posforcework - min(posforcework);
negforcework = out.negforcework.data(si:ei,1);
negforcework = negforcework - min(negforcework);
inertiaenergy = out.inertiaenergy.data(si:ei,1);
inertiaenergy = inertiaenergy - min(inertiaenergy);
dispc = out.displacement.data(si:ei,1);
negforcec = out.negforce.data(si:ei,1);
posforcec = out.posforce.data(si:ei,1);
mfuc = negforcec - out.springforce_u.data(si:ei,1);
mfdc = posforcec - out.springforce_d.data(si:ei,1);
timec = out.springforce_d.time(si:ei,1);

muscleforce_u = -springforce_u + negforce;
muscleforce_d = -springforce_d + posforce;
thoraxforce = -springforce_t;

% figure(1)
% plot(timec,aerowork,'linewidth',2)
% hold on
% % plot(timec,tdampwork,'linewidth',2)
% plot(timec,-tspringwork - min(-tspringwork),'linewidth',2)
% plot(timec,-uspringwork - min(-uspringwork),'linewidth',2)
% plot(timec,-dspringwork - min(-dspringwork),'linewidth',2)
% plot(timec,negforcework,'linewidth',2)
% plot(timec,posforcework,'linewidth',2)
% plot(timec,inertiaenergy,'linewidth',2,'color',[0 0 0]);
% legend('work against aero','thorax spring energy','neg spring energy','pos spring energy','work done by neg force','work done by pos force','inertia (wing + thorax) energy');
% xlabel('time (sec)');
% ylabel('energy (J)');
dampmaxwork = max(aerowork);
maxtspringwork = max(-tspringwork - min(-tspringwork));
maxuspringwork = max(-uspringwork - min(-uspringwork));
maxdspringwork = max(-dspringwork - min(-dspringwork));
maxinertiaenergy = max(inertiaenergy);
% maxinertiaenergy/dampmaxwork;
% 
% figure(2)
% plot(timec,dispc*180/pi)
% xlabel('time (sec)');
% ylabel('displacement (degrees)');

% disp = disp - min(disp);
% figure(3)
% plot(disp*180/pi,-muscleforce_u)
% hold on
% plot(disp*180/pi,muscleforce_d)
% legend('neg force','pos force')
% xlabel('displacement (degrees)');
% ylabel('non-dimensionalized force');
% % xlim([-10 150]);
% % ylim([0 2.5]);
% 
L = length(muscleforce_d);
[minL, minI] = min(disp);
workc = zeros(1,L);
workp = 0;
workn = 0;
for i = 2:1:minI
    workn = workn + (muscleforce_d(i,1) + muscleforce_d(i-1,1))*0.5*(disp(i,1) - disp(i-1,1));
    workc(1,i) = workn;
end

for i = minI+1:1:L
    workp = workp + (muscleforce_d(i,1) + muscleforce_d(i-1,1))*0.5*(disp(i,1) - disp(i-1,1));
    workc(1,i) = workp;
end

% 
% figure(4)
% plot(workc)

% figure(4)
% plot(timec,-mfuc)
% hold on
% plot(timec,mfdc)
% plot(timec,-negforcec)
% plot(timec,posforcec)
% legend('neg total','pos totol','neg active','pos active');
% xlabel('time (sec)');
% ylabel('Torque (N m)');
% 
% figure(5)
% plot(dampforce_aero)
% hold on
% plot(posforce)
% plot(negforce)
% plot(springforce_d)
% plot(springforce_u)
% plot(dampforce_t)
% 
% figure(6)
% plot(vel)
% 
% figure(7)
% plot(accel)
% 
% poswork = 0.115725 - 0.0409272 + 0.150754 - 0.0478255;
% negwork = 0.115725 - 0.0478255;
% 
% negworkact = 0.0630209  - 0.0478255;

%d poswork = 0.136555 - 0.0338648;
% negwork = 0.109706 - 0.0495315;
% 
% negworkact =  0.0637315 - 0.0495315;

%u poswork = 0.114848
%negwork = 0.0302882 + 0.114848 - 0.103455;
%negworkact = 0.0826768 - 0.0778665 + 0.00515175;
% 24%

% figure(6)
% yyaxis left
% plot(Tfinal,A(:,1) - min(A(:,1)));
% ylabel('displacement (mm)');
% hold on
% yyaxis right
% plot(Tfinal,A(:,2) - min(A(:,2)));
% ylabel('Force (N)');
% xlabel('time (sec)');

% figure(7)
% powera = zeros(1548,1);
% 
% for i = 2:1:1548
%    powera(i,1) = (negforcework(i,1) - negforcework(i-1,1))/0.0001;
% end