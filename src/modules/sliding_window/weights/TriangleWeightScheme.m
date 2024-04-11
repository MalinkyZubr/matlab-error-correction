classdef TriangleWeightScheme < Weight
    methods (Access = public)
        % Description:
        %   Generates weights using a triangle weight scheme.
        %
        % Inputs:
        %   obj      - Instance of the TriangleWeightScheme.
        %   weight_x - x-axis for which weights are generated.
        %
        % Outputs:
        %   weight_schema - Weights generated using the triangle weight scheme.
        function weight_schema = generate_weights(obj, weight_x)
            weight_schema = abs(weight_x .* (numel(weight_x) / 4));
        end
    end
end