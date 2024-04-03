classdef (Abstract) SlidingWindow
    properties (Access = private)
        width int32
        window_alignment BaseWindowAlignment = CenterWindowAlignment()
    end

    methods (Abstract)
        y_value_filtered = filter_action(obj, x_slice, y_slice)
    end

    methods (Access = public)
        function obj = SlidingWindow(width, window_alignment)
            arguments (Input)
                width int32 {mustBeOdd(width)}
                window_alignment WindowAlignmentBase
            end
            obj.width = width;
            window_alignment.set_window_size(width);
            obj.window_alignment = window_alignment;
        end

        function y_value_filtered = filter(x_slice, y_slice)
            arguments(Input)
                x_slice (1,:) double
                y_slice (1,:) double {mustBeEqualSize(x_slice, y_slice)}
            end
            arguments(Output)
                y_value_filtered double
            end

            y_filter_slice = obj.filter_action(x_slice, y_slice);
        end

        function obj = set_dataset_size(obj, dataset_size)
            arguments (Input)
                obj SlidingWindow
                dataset_size int32
            end

            obj.window_alignment.set_dataset_size(dataset_size);
        end

        function start_index = get_start_index(obj)
            start_index = obj.window_alignment.get_start_index();
        end

        function window = get_window(obj, index)
            window = obj.window_alignment.generate_window(index);
        end
    end
end

