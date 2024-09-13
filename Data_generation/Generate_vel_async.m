t0 = 0.5;
velall = zeros(1,31);
force_num_all = zeros(1,31);

for p1i = 1:1:31
     filestr = ['Consolidated_data_async/dataasync_' num2str(p1i) '_' num2str(t0) '.mat'];
     load(filestr);
     velall(1,p1i) = max(vel) - min(vel);
     force_num_all(1,p1i) = max(posforce) - min(negforce);
end