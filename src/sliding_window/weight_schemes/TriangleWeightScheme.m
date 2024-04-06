classdef TriangleWeightScheme < BaseWeightScheme
    methods (Access = public)
        function weight_schema = weight_generator(obj, weight_function_input)
            x_intercept = max(abs(weight_function_input));
            weight_schema = -abs(weight_function_input) + x_intercept;
        end
    end
end