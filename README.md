# Parsinomious_musculoskeletal_modeling
This folder includes the scripts for data generation, plotting, and analysis for the paper. All the data required to run these scripts can be found at Dryad (). The results of this study are reported in the manuscript "Efficiency and control trade-offs and work loop characteristics of flapping-wing systems with synchronous and asynchronous muscles".

## Procedure
1. Data generation: Data can be generated for synchronous model, asynchronous model, and for reverse engineering using the "Generate_data_main.m" script, whic runs several scripts for data generation. Create folders "Consolidated_data_async", "Consolidated_data_sync", "Consolidated_data_sync_no_stiff", "Different_lambda_stiff_sync", "Emergent_time_amplitude", "Thorax_data_sync_no_spring", "Thorax data async", and "Thorax data sync" in the folder before running "Generate_data_main.m".

2. Final Data and plotting: Copy folders "Consolidated_data_async", "Consolidated_data_sync", "Consolidated_data_sync_no_stiff", "Different_lambda_stiff_sync", "Emergent_time_amplitude", "Thorax_data_sync_no_spring", "Thorax data async", and "Thorax data sync" from "Data_generation" folder. This folder contains scripts for generating the figures, where the figure numbers are included in the name. Run each script to generate the respective figure(s).
