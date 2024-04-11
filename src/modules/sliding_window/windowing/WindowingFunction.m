classdef (Abstract) WindowingFunction < handle & matlab.mixin.Heterogeneous
    properties(Access = protected)
        window_width int32
    end

    methods (Abstract)
        window_indicies = generate_indicies(obj, index)
    end

    methods (Access = public)
        function obj = WindowingFunction(window_width)
            mustBeOdd(window_width);
            obj.window_width = window_width;
        end

        function generated_window = window(obj, index, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);
            max = numel(dataset(1,:));
            base_window_indicies = obj.generate_indicies(index);
            mustBeLength(base_window_indicies, obj.window_width);
            
            if base_window_indicies(end) > max
                window_x = obj.exceeds_max(base_window_indicies, max);
            elseif base_window_indicies(1) < 1
                window_x = obj.exceeds_min(base_window_indicies);
            else
                window_x = base_window_indicies;
            end

            mustBeLength(window_x, obj.window_width);
            generated_window = cat(1, x_axis(window_x), y_axis(window_x));
        end
    end

    methods (Access = private)
        function adjusted_indicies = exceeds_max(obj, base_window, max)
            exceeding = base_window(end);
            shift = exceeding - max;
            adjusted_indicies = base_window(1) - shift:1:max;
        end

        function adjusted_indicies = exceeds_min(obj, base_window)
            exceeding = abs(base_window(1)) + 1;
            adjusted_indicies = 1:1:base_window(end) + exceeding;
        end
    end
end