classdef TriangleWeightScheme < Weight
    methods (Access = public)
        function weight_schema = generate_weights(obj, weight_x)
            weight_schema = abs(weight_x .* (numel(weight_x) / 4));
            weight_schema
        end
    end
end