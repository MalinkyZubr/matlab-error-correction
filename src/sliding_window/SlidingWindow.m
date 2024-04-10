classdef (Abstract) SlidingWindow < Operation
    properties (Access = protected)
        width int32
        window_alignment BaseWindowAlignment
    end

    methods (Abstract)
        y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
    end

    %methods (Static,Sealed,Access=protected)
    %    function default_object = getDefaultScalarElement
    %       default_object = SquareFilter(1, CenterWindowAlignment());
    %    end
    %end

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
        
        % REPURPOSE THIS FUNCTION
        function output = run(obj, x_axis, y_axis)
            arguments (Input)
                obj SlidingWindow
                x_axis (1,:) double
                y_axis (1,:) double
            end

            for index = 1:1:numel(x_axis)
                slice_indicies = obj.window_alignment.generate_window(index);

                x_slice = x_axis(slice_indicies);
                y_slice = y_axis(slice_indicies);

                new_y_value = obj.filter_slice(x_slice, y_slice);

                y_axis(index) = new_y_value;
            end

            output = y_axis;
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
            set_dataset_size@Operation(obj, dataset_size);
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

