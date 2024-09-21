clear;
P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.1 1.25 1.37 1.5 1.63 1.75 1.87 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10];
Achange_all = [0.6 0.8 1.0 1.2 1.4];

t0 = 0.5;

filestr = ['Consolidated_data_async/async_all_data_final_' num2str(t0) '.mat'];
load(filestr);

xu_min = 0;
xd_max = 0.5;
xt = 0;
dt = 0.001;

ku = 0.5;
kd = 0.5;
kt = 1 - ku - kd;
Ad = [1 1.5 2 2.5 3];

for p1i = 1:1:length(P1allnew)
    P1 = P1allnew(1,p1i);
    P2_nominal = P2new(1,p1i);
    for ai = 1:1:5
          P2 = P2_nominal;
          out = sim('async_flier_modelling_non_d.slx',500);
          async_flier_model_params_non_d
          A = max(disp) - min(disp);
          if abs(A - Ad(1,ai)) < 0.025
          elseif A - Ad(1,ai) > 0.025
              while abs(A - Ad(1,ai)) > 0.025 && P2 > 0
                  P1 = P1allnew(1,p1i);
                  P2 = P2 - 0.05;
                  out = sim('async_flier_modelling_non_d.slx',500);
                  async_flier_model_params_non_d
                  A = max(disp) - min(disp);
                  A
              end
          elseif A - Ad(1,ai) < -0.025
              while abs(A - Ad(1,ai)) > 0.025 && P2 < 10
                  P1 = P1allnew(1,p1i);
                  P2 = P2 + 0.05;
                  out = sim('async_flier_modelling_non_d.slx',500);
                  async_flier_model_params_non_d
                  A = max(disp) - min(disp);
                  A
              end
          end
          Otherparams(1,1) = dampmaxwork;
          Otherparams(1,2) = maxdspringwork;
          Otherparams(1,3) = maxinertiaenergy;
          Otherparams(1,4) = maxinertiaenergy/dampmaxwork;
          Otherparams(1,5) = workp;
          Otherparams(1,6) = workn;
          Otherparams(1,7) = abs(workn)/abs(workn + workp); 
          filestr = ['Emergent_time_amplitude/dataasync_' num2str(p1i) '_' num2str(ai) '.mat'];
          save(filestr,'disp','muscleforce_d','Otherparams','muscleforce_u','inertiaenergy','vel','workp','workn','accel','aerowork','tspringwork','uspringwork','dspringwork','posforcework','negforcework','posforce','negforce','P2');
    end 
end


