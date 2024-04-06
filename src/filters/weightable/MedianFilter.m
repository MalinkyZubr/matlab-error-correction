classdef MedianFilter < SlidingWindow
    methods(Access = public)
        function y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
            y_value_filtered = obj.compute_weighted_median(y_slice);
        end
    end

    methods(Access = private)
        function weighted_median = compute_weighted_median(obj, y_slice)
            sorted_y_slice = sort(y_slice, "ascend");
            weighted_values = obj.weight_scheme.apply_weights(sorted_y_slice);
            weighted_median_indicies = find(sorted_y_slice == median(weighted_values));
            weighted_median = mean(sorted_y_slice(weighted_median_indicies));
        end
    end
end