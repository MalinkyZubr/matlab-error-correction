classdef SquareFilter < SlidingWindow
    methods(Access = public)
        function y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
            y_value_filtered = obj.compute_weighted_average(y_slice);
        end
    end

    methods(Access = private)
        function weighted_average = compute_weighted_average(obj, y_slice)
            weights_sum = sum(obj.weight_scheme.get_weight_schema());
            weighted_average = obj.weight_scheme.apply_weights(y_slice) / weights_sum;
        end
    end
end

