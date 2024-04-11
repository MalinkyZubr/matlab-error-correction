classdef MedianFilter < SlidingWindow
    methods(Access = public)
        function filtered_value = sliding_operation(obj, dataset_slice, x_value)
            filtered_value = median(dataset_slice(2,:));
        end
    end
end