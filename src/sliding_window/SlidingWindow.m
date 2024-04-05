classdef (Abstract) SlidingWindow < handle
    properties (Access = protected)
        width int32
        window_alignment BaseWindowAlignment
    end

    methods (Abstract)
        y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
    end

    methods (Static,Sealed,Access=protected)
        function default_object = getDefaultScalarElement
           default_object = SquareFilter(1, CenterWindowAlignment());
        end
    end

    methods (Access = public)
        function obj = SlidingWindow(width, window_alignment)
            arguments (Input)
                width int32 {mustBeOdd(width)}
                window_alignment BaseWindowAlignment
            end
            if nargin == 0
                obj.width = int32(0); % Provide default values or initialize appropriately
                obj.window_alignment = CenterWindowAlignment();
            else
                obj.width = width;
                window_alignment.set_window_size(width);
                obj.window_alignment = window_alignment;
            end
        end

        function y_value_filtered = filter_slice(obj, x_slice, y_slice)
            arguments(Input)
                obj SlidingWindow
                x_slice (1,:) double
                y_slice (1,:) double {mustBeEqualSize(x_slice, y_slice)}
            end
            arguments(Output)
                y_value_filtered double
            end
            
            requested_index = obj.window_alignment.get_start_index();
            if(requested_index > numel(x_slice))
                requested_index  = round(numel(x_slice) / 2, 1);
            end
            y_value_filtered = obj.filter_action(x_slice, y_slice, requested_index);
        end

        function set_dataset_size(obj, dataset_size)
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

