classdef MeanFilter < SlidingWindow
    methods(Access = public)
        % Description:
        %   Applies mean filter to the dataset slice.
        %
        % Inputs:
        %   obj           - Instance of the MeanFilter.
        %   dataset_slice - Slice of the dataset on which mean filter is applied.
        %   x_value       - X-axis value corresponding to the dataset slice.
        %
        % Outputs:
        %   filtered_value - Result of the mean filter operation.
        function filtered_value = sliding_operation(obj, dataset_slice, x_value)
            filtered_value = mean(dataset_slice(2,:));
        end
    end
end