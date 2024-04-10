classdef SquareFilter < WeightableSlidingWindow
    methods(Access = public)
        function y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
            %y_slice
            y_value_filtered = obj.compute_weighted_average(y_slice, requested_index);
        end
    end

    methods(Access = private)
        function weighted_average = compute_weighted_average(obj, y_slice, index)
            weights_sum = sum(obj.weight_scheme.get_weights(index));
            weighted_average = sum(obj.weight_scheme.apply_weights(y_slice, index)) / weights_sum;
        end
    end
end

