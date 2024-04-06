classdef ErrorCorrectionWorkflow < handle
    properties (Access = public)
        operations cell
        x_axis (1,:) double
        y_axis (1,:) double
    end

    methods (Access = public)
        function obj = ErrorCorrectionWorkflow()
            obj.operations = cell(0);
        end

        function set_dataset(obj, x_axis, y_axis)
            arguments(Input)
                obj ErrorCorrectionWorkflow
                x_axis (1,:) double {mustBeReal}
                y_axis (1,:) double {mustBeReal, mustBeEqualSize(y_axis, x_axis)}
            end

            obj.x_axis = x_axis;
            obj.y_axis = y_axis;
        end

        function add_operation(obj, operation)
            arguments (Input)
                obj ErrorCorrectionWorkflow
                operation SlidingWindow
            end
            
            operation.set_dataset_size(numel(obj.x_axis));

            temp_operations = obj.operations;
            temp_operations{numel(temp_operations) + 1} = operation;
            obj.operations = temp_operations;
        end

        function y_axis_filtered = run(obj)
            arguments(Input)
                obj ErrorCorrectionWorkflow
            end
            arguments(Output)
                y_axis_filtered (1,:) double
            end
            

            if numel(obj.operations) == 0
                error("No operations present in workflow");
            else
                completed_operations = 0;
                percent_completion = 0;
                for i = 1:1:numel(obj.operations)
                    obj.operations{i}.run(obj.x_axis, obj.y_axis);
                    completed_operations = completed_operations + 1;
                    percent_completion = (completed_operations / numel(obj.operations)) * 100;

                    fprintf("Operation %d completed: %.2f%% complete", completed_operations, percent_completion)
                end
            end

            y_axis_filtered = obj.y_axis;
        end
    end
    methods (Access = private)
    end
end