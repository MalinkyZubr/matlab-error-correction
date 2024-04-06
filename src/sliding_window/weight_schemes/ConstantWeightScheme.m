classdef ConstantWeightScheme < BaseWeightScheme
    methods (Access = public)
        function weight_schema = weight_generator(obj, weight_function_input)
            arguments(Input)
                obj ConstantWeightScheme
                weight_function_input (1,:)
            end
            weight_schema = ones(size(weight_function_input));
        end
    end
end