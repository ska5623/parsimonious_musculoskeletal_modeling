% clear;
%P1allnew = [0.1 0.2 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20];
P1allfinal = [0.01 0.02 0.03 0.04 0.05 0.075 0.1 0.15 0.2 0.25 0.3 0.4 0.5 0.75 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10 15 20 32];
P3all = [0.4 0.6 0.8 0.9 1 1.1 1.2 1.4 1.6 1.8 2 2.2];
limitsall = zeros(4,length(P1allfinal));
limitsall(1,1:10) = 0.1;
limitsall(1,11:20) = 0.2;
limitsall(1,21:30) = 0.4;
limitsall(1,31:length(P1allfinal)) = 1;
limitsall(2,1:10) = 0.05;
limitsall(2,11:20) = 0.1;
limitsall(2,21:30) = 0.2;
limitsall(2,31:length(P1allfinal)) = 0.5;
limitsall(3,1:10) = 0.02;
limitsall(3,11:20) = 0.05;
limitsall(3,21:30) = 0.1;
limitsall(3,31:length(P1allfinal)) = 0.2;
limitsall(4,1:10) = 0.01;
limitsall(4,11:20) = 0.02;
limitsall(4,21:30) = 0.04;
limitsall(4,31:length(P1allfinal)) = 0.1;
dt = 0.001;

for p3i = 2:1:2
    mdl = 'sync_flier_modelling_non_d_no_spring';
    P3 = P3all(p3i);
    if P3 > 1.2
        P3 = P3all(p3i-1);
    end
    filestr = ['Consolidated_data_sync_no_stiff/sync_all_data_final_no_spring_' num2str(P3) '.mat'];
    load(filestr,'Otherparams','P2new');
    P3 = P3all(p3i);
    trueall = zeros(1,length(P1allfinal));
    while (sum(trueall) <length(P1allfinal))
        clear in;
        index = 1;
        for p1i = 1:1:length(P1allfinal)
            if trueall(1,p1i) == 0
                P1 = P1allfinal(1,p1i);
                %         P2 = P2new(1,p1i);
                P2 = P2new(1,p1i);
                if p1i < 6
                    Tt = 1000;
                else
                    Tt = 500;
                end

                in(index) = Simulink.SimulationInput(mdl);
                in(index) = in(index).setVariable('dt',dt);
                in(index) = in(index).setVariable('P1',P1);
                in(index) = in(index).setVariable('P2',P2);
                in(index) = in(index).setVariable('Tt',Tt);
                in(index) = in(index).setVariable('P3',P3);
                
                index = index + 1;
            end
        end
        outall = sim(in,'ShowProgress','off');
     
        index = 1;
        for p1i = 1:1:length(P1allfinal)
            if trueall(1,p1i) == 0
                out = outall(index);
                sync_flier_model_params_non_d_no_spring
                A = max(disp) - min(disp);
                [p1i A P2new(1,p1i)]
                if abs(A - 2) < 0.05
                    trueall(1,p1i) = 1;
                    Otherparams(p1i,1) = dampmaxwork;
                    Otherparams(p1i,2) = maxinertiaenergy;
                    Otherparams(p1i,3) = maxinertiaenergy/dampmaxwork;
                    Otherparams(p1i,4) = workp;
                    Otherparams(p1i,5) = workn;
                    Otherparams(p1i,6) = abs(workn)/abs(workn + workp);
                    filestr = ['Thorax_data_sync_no_spring/datasync_' num2str(P3) '_' num2str(p1i)  '.mat'];
                    save(filestr,'disp','muscleforce_d','muscleforce_u','inertiaenergy','vel','workp','workn','accel','aerowork','posforcework','negforcework','posforce','negforce','P2');
                    filestr = ['Consolidated_data_sync_no_stiff/sync_all_data_final_no_spring_' num2str(P3) '.mat'];
                    save(filestr,'Otherparams','P2new');
                    A
                    trueall
                elseif A - 2 > 0.5
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(1,p1i);
                elseif A - 2 > 0.25
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(2,p1i);
                elseif A - 2 > 0.1
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(3,p1i);
                elseif A - 2 > 0.05
                    P2new(1,p1i) = P2new(1,p1i) - limitsall(4,p1i);
                elseif A - 2 < -0.5
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(1,p1i);
                elseif A - 2 < -0.25
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(2,p1i);
                elseif A - 2 < -0.1
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(3,p1i);
                elseif A - 2 < -0.05
                    P2new(1,p1i) = P2new(1,p1i) + limitsall(4,p1i);
                end

                if P2new(1,p1i) < 0
                    P2new(1,p1i) = 0.01;
                end
                index = index + 1;
            end     
        end
    end
end



%% correcting P2 to increase amplitude accuracy
% for i= 15:1:length(P1allnew)
%     P2start = 0;
%     P2end = 0;
%     sig = 1;
%     for j = 2:1:5
%        A1 = interp2(P1all,P2all,Amplitudeall',P1allnew(1,i),P2all(1,j-1),'spline');
%        A2 = interp2(P1all,P2all,Amplitudeall',P1allnew(1,i),P2all(1,j),'spline');
%          if  A1 < 1 && A2 > 1
%           P2start = P2all(1,j-1);
%           P2end = P2all(1,j);
%           j = 6;
%          end
%     end
%     if P2start == 0 && interp2(P1all,P2all,Amplitudeall',P1allnew(1,i),P2all(1,1),'spline') < 1
%         P2start = P2all(1,5);
%         P2end = 10;
%         sig = 1;
%     elseif P2start == 0 && interp2(P1all,P2all,Amplitudeall',P1allnew(1,i),P2all(1,1),'spline') > 1 
%         P2start = P2all(1,5);
%         P2end = 0;
%         sig = -1;
%     end
%     
%     P2final = P2start;
%     Ampfinal = 0;
%     Aold = 0;
%     
%     if sig == 1
%       while (Ampfinal ~= 1) && (P2final < P2end)
%           P2final = P2final + 0.01;
%           Anew = interp2(P1all,P2all,Amplitudeall',P1allnew(1,i),P2final,'spline');
%           if Aold < 1 && Anew > 1
%              Ampfinal = 1;
%              P2new(1,i) = P2final;
%              Ampnew(1,i) = Anew;
%           end
%           Aold = Anew;
%       end
%     elseif sig == -1
%       while (Ampfinal ~= 1) && (P2final > P2end)
%           P2final = P2final - 0.01;
%           Anew = interp2(P1all,P2all,Amplitudeall',P1allnew(1,i),P2final,'spline');
%           if Aold > 1 && Anew < 1
%              Ampfinal = 1;
%              P2new(1,i) = P2final;
%              Ampnew(1,i) = Anew;
%           end
%           Aold = Anew;
%       end  
%     end
% end