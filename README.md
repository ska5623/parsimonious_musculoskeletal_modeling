# Parsinomious_musculoskeletal_modeling
This folder includes the scripts for finding lambda_F/K, data generation, plotting, and analysis for the paper. The results of this study are reported in the manuscript "Efficiency and control trade-offs and work loop characteristics of flapping-wing systems with synchronous and asynchronous muscles".

## Procedure
1. Finding Lambda_F/K: The lambda_F/K for each of synchronous model with no spring, synchronous model, and asynchronous model can be found by running the "Find_Lamda_F_by_K_main" script. Additionally, it runs the script "Find_Lambda_F_by_K_diff_amp_async" which finds lambda_F/K for generating different amplitudes.
 
2. Data generation: Data can be generated for synchronous model, asynchronous model, and for reverse engineering using the "Generate_data_main.m" script, which runs several scripts for data generation. Create folders "Consolidated_data_async", "Consolidated_data_sync", "Consolidated_data_sync_no_stiff", "Different_lambda_stiff_sync", "Emergent_time_amplitude", "Thorax_data_sync_no_spring", "Thorax data async", and "Thorax data sync" in the folder before running "Generate_data_main.m".

3. Final Data and plotting: Copy folders "Consolidated_data_async", "Consolidated_data_sync", "Consolidated_data_sync_no_stiff", "Different_lambda_stiff_sync", "Emergent_time_amplitude", "Thorax_data_sync_no_spring", "Thorax data async", and "Thorax data sync" from "Data_generation" folder. This folder contains scripts for generating the figures, where the figure numbers are included in the name. Run each script to generate the respective figure(s).
