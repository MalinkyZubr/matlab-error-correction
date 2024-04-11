classdef QuadraticWeightScheme < Weight
    methods (Access = public)
        function weight_schema = generate_weights(obj, weight_x)
            intercept_value = 1.0 / (double(max(weight_x)) ^ 2);
            weight_schema = int32(((-double(weight_x .^ 2) .* (intercept_value)) + 1.0) .* double(max(weight_x)));
        end
    end
end