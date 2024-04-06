classdef (Abstract) BaseWeightScheme < handle & matlab.mixing.Heterogeneous
    properties (Access = protected)
        weight_schema (1,:) double
        height_coefficient double
    end
    methods (Abstract)
        weight_schema = weight_generator(obj, weight_function_input)
    end

    methods (Access = public)
        function obj = BaseWeightScheme(height_coefficient)
            arguments(Input)
                height_coefficient double
            end
            obj.height_coefficient = height_coefficient;
        end
        function weight_setup(obj, window_alignment)
            arguments(Input)
                obj BaseWeightScheme
                window_alignment BaseWindowAlignment
            end
            
            obj.weight_schema = obj.weight_generator(window_alignment.generate_weights_window());
        end

        function weight_schema = get_weight_schema(obj)
            weight_schema = obj.weight_schema;
        end

        function weighted_data = apply_weights(obj, unweighted_data)
            arguments(Input)
                obj BaseWeightScheme
                unweighted_data (1,:);
            end
            mustBeEqualSize(unweighted_data, obj.weight_schema);
            weighted_data = unweighted_data .* obj.weight_schema;
        end
    end
end