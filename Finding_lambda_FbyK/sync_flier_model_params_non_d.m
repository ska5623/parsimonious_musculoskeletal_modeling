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

dampmaxwork = max(aerowork);
maxtspringwork = max(-tspringwork - min(-tspringwork));
maxuspringwork = max(-uspringwork - min(-uspringwork));
maxdspringwork = max(-dspringwork - min(-dspringwork));
maxinertiaenergy = max(inertiaenergy);

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
