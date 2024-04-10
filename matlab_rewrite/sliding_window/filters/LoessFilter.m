classdef LoessFilter < SlidingWindow
    properties(Access = private)
        polynomial_degree int32;
    end

    methods(Access = public)
        function obj = LoessFilter(windowing_function, polynomial_degree)
            obj@SlidingWindow(windowing_function)
            obj.polynomial_degree = polynomial_degree;
        end

        function filtered_value = sliding_operation(obj, dataset_slice, index)
            polynomial = polyfit(dataset_slice(1,:), dataset_slice(2,:), obj.polynomial_degree);
            filtered_value = polyval(polynomial, index);
        end
    end
end