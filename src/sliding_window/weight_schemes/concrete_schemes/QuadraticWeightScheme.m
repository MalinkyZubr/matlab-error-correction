classdef QuadraticWeightScheme < BaseWeightScheme
    methods (Access = public)
        function weight_schema = weight_generator(obj, weight_function_input)
            x_intercept = max(abs(weight_function_input));
            weight_schema = (weight_function_input .^ 2) - (x_intercept ^2);
        end
    end
end