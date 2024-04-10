classdef QuadraticWeightScheme < Weight
    methods (Access = public)
        function weight_schema = generate_weights(obj, weight_x)
            intercept_value = (numel(weight_x) ^ 2) - 1;
            weight_schema = -((weight_x .^ 2) - intercept_value) + 1;
        end
    end
end