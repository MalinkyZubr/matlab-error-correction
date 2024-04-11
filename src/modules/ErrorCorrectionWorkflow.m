classdef ErrorCorrectionWorkflow < handle
    properties(Access = private)
        operations cell
        preprocessors cell
        run_strategy RunStrategy
    end

    methods(Access = public)
        function obj = ErrorCorrectionWorkflow(run_strategy)
            obj.run_strategy = run_strategy;
        end

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

        function add_operation(obj, operation)
            obj.operations{numel(obj.operations) + 1} = operation;
        end

        function add_preprocessor(obj, preprocessor)
            obj.preprocessors{numel(obj.preprocessors) + 1} = preprocessor;
        end
    end
end