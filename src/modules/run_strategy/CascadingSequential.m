classdef CascadingSequential < RunStrategy
    methods(Access = public)
        function corrected_dataset = run_operations(obj, operations, dataset)
            length_initial = numel(dataset(1,:));
            for index = 1:1:numel(operations(1,:))
                dataset = operations{index}.run(dataset);

                mustBeLength(dataset(1,:), length_initial);
                if size(dataset, 1) ~= 2
                    error('dataset must be 2d matrix, got rows: %d. Due to %s', size(dataset, 1), class(operations{index}));
                end

                fprintf('Completed operation # %d: %s. %.2f%% complete\n', index, class(operations{index}), ((index / numel(operations(1,:)) * 100)));
            end
            corrected_dataset = dataset;
        end
    end
end