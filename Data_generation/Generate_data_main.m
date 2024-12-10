%% Synchronous model with no spring
Generate_consolidated_and_thorax_data_sync_no_spring
bdclose; clear all;

% Synchronous model
Generate_thorax_data_and_consolidated_data
bdclose; clear all;
Generate_Lambda_stiffness_sync
bdclose; clear all;
Generate_data_at_different_lambda_stiff_for_sync
bdclose; clear all;

% Asynchronous model
Generate_thorax_data_and_consolidated_data_async
bdclose; clear all;
Generate_data_Emergent_time_amplitude
bdclose; clear all;
Generate_data_at_different_lambda_stiff_for_async
bdclose; clear all;

%% Reverse Engineering
Generate_hummingbird_data
bdclose; clear all;
Generate_hawkmoth_data
bdclose; clear all;
Generate_bumblebee_data
bdclose; clear all;