%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description: This function applies error correction to multiple datasets using a specified workflow.
%
% Function Call: 
%   [datasets] = error_correct(datasets, workflow)
%
% Input Arguments:
%   datasets (1xN cell array): A cell array containing N datasets to be error corrected.
%   workflow (ErrorCorrectionWorkflow object): An object representing the workflow to be applied for error correction.
%
% Output Arguments:
%   datasets (1xN cell array): A cell array containing N error-corrected datasets.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [datasets] = error_correct(datasets, workflow)
    arguments(Input)
        datasets (1,:) cell
        workflow ErrorCorrectionWorkflow
    end

    for index = 1:1:numel(datasets)
        original_data = datasets{index}.get_dataset();
        fprintf('NEW DATASET: %s\nDataset %d/%d\n', datasets{index}.get_name(), index, numel(datasets));

        data_filtered = workflow.run_workflow(original_data);
        datasets{index}.set_dataset(data_filtered);
    end
end