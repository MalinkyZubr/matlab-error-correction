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