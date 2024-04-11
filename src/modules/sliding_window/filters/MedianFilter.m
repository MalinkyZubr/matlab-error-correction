classdef MedianFilter < SlidingWindow
    methods(Access = public)
        % Description:
        %   Applies median filter to the dataset slice.
        %
        % Inputs:
        %   obj           - Instance of the MedianFilter.
        %   dataset_slice - Slice of the dataset on which median filter is applied.
        %   x_value       - X-axis value corresponding to the dataset slice.
        %
        % Outputs:
        %   filtered_value - Result of the median filter operation.
        function filtered_value = sliding_operation(obj, dataset_slice, x_value)
            filtered_value = median(dataset_slice(2,:));
        end
    end
end