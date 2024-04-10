classdef(Abstract) Weight < DataProcessor
    properties(Access = protected)
        height_multiplier double
    end
    methods(Abstract)
        weights = generate_weights(obj, data)
    end

    methods(Access = public)
        function obj = Weight(height_multiplier)
            obj.height_multiplier = height_multiplier;
        end

        function corrected_dataset = process_data(obj, data)
            weights = obj.generate_weights(obj, obj.generate_weight_x_axis(numel(data(1,:)))) * obj.height_multiplier;

            corrected_dataset = []; 

            for index = 1:1:numel(data(1,:))
                fragment = ones(1, weights(index), "double") .* data(index);
                cat(2, corrected_dataset, fragment);
            end
        end
    end

    methods(Access = protected)
        function weight_x = generate_weight_x_axis(obj, data_length)
            weight_x = -(data_length / 2) + 1:1:(data_length / 2) - 1;
        end
    end
end