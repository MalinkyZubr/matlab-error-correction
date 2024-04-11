classdef ErrorCorrectionWorkflow < handle
    properties(Access = private)
        operations cell
        preprocessors cell
        run_strategy RunStrategy
    end

    methods(Access = public)
        % Description:
        %   Initializes an ErrorCorrectionWorkflow object with the specified run strategy.
        %
        % Inputs:
        %   run_strategy - Run strategy object to be used for executing operations.
        function obj = ErrorCorrectionWorkflow(run_strategy)
            obj.run_strategy = run_strategy;
        end

        % Description:
        %   Executes the error correction workflow on the given dataset.
        %
        % Inputs:
        %   dataset - Input dataset to be error corrected.
        %
        % Outputs:
        %   corrected_dataset - Error corrected dataset.
        function corrected_dataset = run_workflow(obj, dataset)
            if numel(obj.preprocessors) ~=0
                for index = 1:1:numel(obj.preprocessors)
                    dataset = obj.preprocessors{index}.process_data(dataset);
                end
            end

            if numel(obj.operations) == 0
                error("Workflow needs operations!")
            else
                dataset = obj.run_strategy.run_operations(obj.operations, dataset);
            end
            
            if numel(obj.preprocessors) ~= 0
                for index = numel(obj.preprocessors):-1:1
                    dataset = obj.preprocessors{index}.de_process_data(dataset);
                end
            end

            corrected_dataset = dataset;
        end

        % Description:
        %   Adds an operation to the error correction workflow.
        %
        % Inputs:
        %   operation - Operation to be added to the workflow.
        function add_operation(obj, operation)
            obj.operations{numel(obj.operations) + 1} = operation;
        end

        % Description:
        %   Adds a preprocessor to the error correction workflow.
        %
        % Inputs:
        %   preprocessor - Preprocessor to be added to the workflow.
        function add_preprocessor(obj, preprocessor)
            obj.preprocessors{numel(obj.preprocessors) + 1} = preprocessor;
        end
    end
end