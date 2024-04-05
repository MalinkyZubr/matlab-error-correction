classdef ErrorCorrectionWorkflow < handle
    properties (Access = public)
        operations cell
        x_axis (1,:) double
        y_axis (1,:) double
    end

    methods (Access = public)
        function obj = ErrorCorrectionWorkflow(x_axis, y_axis)
            arguments(Input)
                x_axis (1,:) double {mustBeReal}
                y_axis (1,:) double {mustBeReal, mustBeEqualSize(y_axis, x_axis)}
            end

            obj.x_axis = x_axis;
            obj.y_axis = y_axis;
            obj.operations = cell(0);
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
            
            numel(obj.operations)
            if numel(obj.operations) == 0
                error("No operations present in workflow");
            else
                for i = 1:1:numel(obj.operations)
                    obj.run_operation(obj.operations{i});
                end
            end

            y_axis_filtered = obj.y_axis;
        end
    end
    methods (Access = private)
        function run_operation(obj, operation)
            arguments (Input)
                obj ErrorCorrectionWorkflow
                operation SlidingWindow
            end

            disp("running next operation")
            for index = operation.get_start_index():1:numel(obj.x_axis)
                slice_indicies = operation.get_window(index);

                x_slice = obj.x_axis(slice_indicies);
                y_slice = obj.y_axis(slice_indicies);

                new_y_value = operation.filter_slice(x_slice, y_slice);
                obj.y_axis(index) = new_y_value;
            end
        end
    end
end