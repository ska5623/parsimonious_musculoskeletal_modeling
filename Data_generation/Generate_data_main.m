%% Synchronous model with no spring
Generate_data_sync_no_spring
bdclose; clear all;

% Synchronous model
Generate_data_sync
bdclose; clear all;
Generate_data_at_different_lambda_thorax_for_sync
bdclose; clear all;

% Asynchronous model
Generate_data_async
bdclose; clear all;
Generate_data_at_different_lambda_thorax_for_async
bdclose; clear all;
