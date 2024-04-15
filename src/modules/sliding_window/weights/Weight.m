classdef(Abstract) Weight < DataProcessor
    methods(Abstract)
        weights = generate_weights(obj, data)
    end

    methods(Access = public)
        function corrected_dataset = process_data(obj, data)
            weights = obj.generate_weights(obj.generate_weight_x_axis(numel(data(1,:))));
            corrected_dataset = repelem(data, 1, weights);
        end
    end

    % Description:
    %   Processes the input data by applying weights.
    %
    % Inputs:
    %   obj  - Instance of the Weight.
    %   data - Input data to be processed.
    %
    % Outputs:
    %   corrected_dataset - Processed dataset with applied weights.
    methods(Access = protected)
        function weight_x = generate_weight_x_axis(obj, data_length)
            weight_x = -int32(data_length / 2) + 1:1:int32(data_length / 2) - 1;
        end
    end
end