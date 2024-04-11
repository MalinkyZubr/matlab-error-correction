classdef QuadraticWeightScheme < Weight
    methods (Access = public)
        % Description:
        %   Generates weights using a quadratic weight scheme.
        %
        % Inputs:
        %   obj      - Instance of the QuadraticWeightScheme.
        %   weight_x - x-axis for which weights are generated.
        %
        % Outputs:
        %   weight_schema - Weights generated using the quadratic weight scheme.
        function weight_schema = generate_weights(obj, weight_x)
            intercept_value = 1.0 / (double(max(weight_x)) ^ 2);
            weight_schema = int32(((-double(weight_x .^ 2) .* (intercept_value)) + 1.0) .* double(max(weight_x)));
        end
    end
end