classdef MeanFilter < SlidingWindow
    methods(Access = public)
        function filtered_value = sliding_operation(obj, dataset_slice, index)
            filtered_value = mean(dataset_slice(2,:));
        end
    end
end