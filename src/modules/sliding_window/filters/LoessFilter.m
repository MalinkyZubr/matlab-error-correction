classdef LoessFilter < SlidingWindow
    methods(Access = public)
        % Description:
        %   Applies Loess filter to the dataset slice.
        %
        % Inputs:
        %   obj           - Instance of the LoessFilter.
        %   dataset_slice - Slice of the dataset on which Loess filter is applied.
        %   x_value       - X-axis value corresponding to the dataset slice.
        %
        % Outputs:
        %   filtered_value - Result of the Loess filter operation.
        function filtered_value = sliding_operation(obj, dataset_slice, x_value)
            coefficients = obj.generate_loess_model(dataset_slice);
            filtered_value = (coefficients(1) * x_value) + coefficients(2)
        end
    end

    methods(Access = private)
        function coefficients = generate_loess_model(obj, dataset_slice)
            num_elements = size(dataset_slice, 2)
            sum_prod = sum(prod(dataset_slice))

            sum_y = sum(dataset_slice(2,:))
            prod_sum = sum(dataset_slice(1,:)) + sum_y

            x_squared_sum = sum(dataset_slice(1,:) .^ 2)
            x_sum_squared = sum(dataset_slice(1,:)) ^ 2

            slope = ((num_elements * sum_prod) - prod_sum) / ((num_elements * x_squared_sum) - x_sum_squared)
            intercept = (sum_y - (slope * sum(dataset_slice(1,:)))) / num_elements
            coefficients = [slope, intercept]
        end
    end
end