classdef (Abstract) BaseWeightScheme < handle & matlab.mixin.Heterogeneous
    properties (Access = protected)
        window_alignment BaseWindowAlignment
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
            
            obj.window_alignment = window_alignment;
        end
        
        function weights = get_weights(obj, index)
            weights = obj.weight_generator(obj.window_alignment.generate_weights_window(index));
        end

        function weighted_data = apply_weights(obj, unweighted_data, index)
            arguments(Input)
                obj BaseWeightScheme
                unweighted_data (1,:);
                index int32
            end

            weights = obj.get_weights(index);
            if numel(unweighted_data) ~= numel(weights)
                error("Data size must equal weight size, %d, %d", numel(unweighted_data), numel(weights));
            else
                weighted_data = unweighted_data .* weights;
            end
        end
    end
end