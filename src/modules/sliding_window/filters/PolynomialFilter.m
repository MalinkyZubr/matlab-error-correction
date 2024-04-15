classdef PolynomialFilter < SlidingWindow
    properties(Access = private)
        polynomial_degree int32;
    end

    methods(Access = public)
        % Description:
        %   Constructor for PolynomialFilter class.
        %
        % Inputs:
        %   windowing_function - Windowing function object to be used for generating window slices.
        %   polynomial_degree  - Degree of the polynomial for fitting the data.
        function obj = PolynomialFilter(windowing_function, polynomial_degree)
            obj@SlidingWindow(windowing_function)
            obj.polynomial_degree = polynomial_degree;
        end

        % Description:
        %   Applies Loess filter to the dataset slice.
        %
        % Inputs:
        %   obj           - Instance of the PolynomialFilter.
        %   dataset_slice - Slice of the dataset on which Loess filter is applied.
        %   x_value       - X-axis value corresponding to the dataset slice.
        %
        % Outputs:
        %   filtered_value - Result of the Loess filter operation.
        function filtered_value = sliding_operation(obj, dataset_slice, x_value)
            polynomial = polyfit(dataset_slice(1,:), dataset_slice(2,:), obj.polynomial_degree);
            filtered_value = polyval(polynomial, x_value);
        end
    end
end