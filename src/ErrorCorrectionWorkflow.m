classdef ErrorCorrectionWorkflow
    properties (Access = private)
        operations (1,:)
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
        end

        function obj = add_operation(obj, operation)
            arguments (Input)
                obj ErrorCorrectionWorkflow
                operation SlidingWindow
            end

            operation.set_dataset_size(size(obj.x_axis))
            current_operations = obj.operations;
            obj.operations = [current_operations, filter];
        end

        function y_axis_filtered = run(obj)
            arguments(Input)
                obj ErrorCorrectionWorkflow
            end
            arguments(Output)
                y_axis_filtered (1,:) double
            end
            
            for i = 1:1:size(obj.operations)
                obj.run_operation(obj.operations(i));
            end

            y_axis_filtered = obj.y_axis;
        end
    end
    methods (Access = private)
        function obj = run_operation(obj, filter)
            arguments (Input)
                obj ErrorCorrectionWorkflow
                filter SlidingWindow
            end

            for index = filter.get_start_index():1:size(obj.x_axis)
                slice_indicies = filter.get_window(index);

                x_slice = obj.x_axis(slice_indicies);
                y_slice = obj.y_axis(slice_indicies);

                obj.y_axis(index) = filter.filter(x_slice, y_slice);
            end
        end
    end
end