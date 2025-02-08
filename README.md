# Parsinomious_musculoskeletal_modeling
This folder contains the scripts for finding lambda_F/K, data generation, plotting, and analysis for the paper. The results of this study are reported in the manuscript "Efficiency and control trade-offs and work loop characteristics of flapping-wing systems with synchronous and asynchronous muscles".


## Procedure
1. Finding Lambda_F/K: Lambda_F/K is the stiffness-normalized active force amplitude and is found via sweep method for different Lambda_D/I and Lambda_w/wn (See Fig. 2). The Lambda_F/K for different models and scenarios are obtained using the following scripts:

a) Find_Lamda_F_by_K_sync.m: Finds Lambda_F/K for the synchronous model with spring for obtaining an amplitude of 1 radian (see Fig. 2). The obtained Lambda_F/K for different Lambda_D/I are stored in the folder "Consolidated_data_sync", for different Lambda_w/wn (i.e., they are stored as 'sync_all_data_final_Lambda_w/wn.mat').
b) Find_Lamda_F_by_K_async.m: Finds Lambda_F/K for the asynchronous model with spring for obtaining an amplitude of 1 radian (see Fig. 2). The obtained Lambda_F/K for different Lambda_D/I are stored in the folder "Consolidated_data_async", for different Lambda_w/wn (i.e., they are stored as 'async_all_data_final_Lambda_w/wn.mat').
c) Find_Lamda_F_by_K_sync_no_spring.m: Finds Lambda_F/K for the synchronous model with no spring for obtaining an amplitude of 1 radian (see Fig. 2). The obtained Lambda_F/K for different Lambda_D/I are stored in the folder "Consolidated_data_sync_no_stiff", for different Lambda_w/wn (i.e., they are stored as 'sync_all_data_final_no_spring_Lambda_w/wn.mat').
d) "Find_Lambda_F_by_K_diff_amp_async": Similar to b) above, however, finds Lambda_F/K for different oscillation amplitudes (0.5, 0.75, 1.0, 1.25, 1.5 radians). The obtained Lambda_F/K is used to calculate different model characteristics (see Fig. 2), and is stored in "Emergent_time_amplitude" for each Lambda_D/I and Lambda_w/wn.

The scripts a-d can all be run in one go using "Find_Lamda_F_by_K_main.m". Before running "Find_Lamda_F_by_K_main", create folders "Emergent_time_amplitude", "Consolidated_data_sync_no_stiff", "Consolidated_data_sync", and "Consolidated_data_async", where the data would be stored. 

The folder also contains additional scripts and files, which are defined below:
e) sync_flier_modelling_non_d.slx: Simulation model (Simulink) that simulates Eqns. 4 - 5 (see paper), i.e., non-dimensionalized equation for synchronous model.  
f) sync_flier_modelling_non_d_no_spring.slx: Simulation model (Simulink) that simulates non-dimensionalized Eqn. 1 (see paper) for synchronous model, but with no spring.  
g) async_flier_modelling_non_d.slx: Simulation model (Simulink) that simulates Eqns. 6 - 7 (see paper), i.e., non-dimensionalized equation for asynchronous model.  
h) sync_flier_model_params_non_d.m: When the simulation of 'sync_flier_modelling_non_d.slx' is complete, obtains data from the simulated model and calculates several model characteristics (see Fig. 2).
i) sync_flier_model_params_non_d_no_spring.m: When the simulation of 'sync_flier_modelling_non_d_no_spring.slx' is complete, obtains data from the simulated model and calculates several model characteristics (see Fig. 2).
j) async_flier_model_params_non_d.m: When the simulation of 'async_flier_modelling_non_d_no_spring.slx' is complete, obtains data from the simulated model and calculates several model characteristics (see Fig. 2).


2. Data generation: Once the Lambda_F/K for each Lambda_D/I and Lambda_w/wn has been obtained in Step 1 above, the following scripts run the simulation models (e-g) using the obtained Lambda_F/K, followed by calculating the model characteristics using scripts h-j above. 

k) Generate_data_sync.m: Calculates model characteristics for synchronous model with spring, using the data in "Consolidated_data_sync", for each Lambda_D/I and Lambda_w/wn.   
l) Generate_data_async.m: Calculates model characteristics for asynchronous model with spring, using the data in "Consolidated_data_async", for each Lambda_D/I and Lambda_w/wn.   
m) Generate_data_sync_no_spring.m: Calculates model characteristics for synchronous model with no spring, using the data in "Consolidated_data_sync_no_stiff", for each Lambda_D/I and Lambda_w/wn.   

The following two scripts simulate the simulation models (e and g) and obtain force and displacement data for different Lambda_thorax (see Fig. 2 and text), which is then used to generate work loops at different Lambda_D/I, Lambda_w/wn, and Lambda_thorax, and associated model characteristics.  

n) Generate_data_at_different_lambda_thorax_for_sync.m: Generates the above data for synchronous model.
o) Generate_data_at_different_lambda_thorax_for_async.m: Generates the above data for asynchronous model.
 
The scripts k-o can all be run in one go using "Generate_data_main.m". 

Before running "Generate_data_main.m", copy folders "Consolidated_data_sync_no_stiff", "Consolidated_data_sync", and "Consolidated_data_async" from the folder "Finding Lambda_F/K" and create folders "Different_lambda_thorax_sync", "Different_lambda_thorax_async", "Data_sync_no_spring", "Data_async", and "Data_sync" in the folder.

3. Final Data and plotting: Copy folders "Consolidated_data_async", "Consolidated_data_sync", "Consolidated_data_sync_no_stiff", "Emergent_time_amplitude", "Different_lambda_thorax_sync", "Different_lambda_thorax_async", "Data_sync_no_spring", "Data_async", and "Data_sync" from "Data_generation" and "Finding Lambda_F/K" folders. This folder contains scripts for generating the figures, where the figure numbers are included in the name. Run each script to generate the respective figure(s).
