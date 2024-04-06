classdef (Abstract) WeightableSlidingWindow < SlidingWindow
    properties(Access = protected)
        weight_scheme BaseWeightScheme
    end

    methods (Abstract)
        y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
    end

    methods (Access = public)
        function obj = WeightableSlidingWindow(width, window_alignment, weight_scheme)
            arguments(Input)
                width int32 {mustBeOdd(width)}
                window_alignment BaseWindowAlignment
                weight_scheme BaseWeightScheme
            end

            obj@SlidingWindow(width, window_alignment);
            if nargs < 3
                obj.weight_scheme = ConstantWeightScheme(1);
            else
                obj.weight_scheme = weight_scheme;
            end
            obj.weight_scheme.weight_setup(obj.window_alignment);
        end
    end
end