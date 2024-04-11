classdef(Abstract) Weight < DataProcessor
    methods(Abstract)
        weights = generate_weights(obj, data)
    end

    methods(Access = public)
        % Description:
        %   Abstract method to generate weights based on the input data.
        %
        % Inputs:
        %   obj  - Instance of the Weight.
        %   data - Input data used for weight generation.
        %
        % Outputs:
        %   weights - Generated weights.
        function corrected_dataset = process_data(obj, data)
            x_axis_slice = data(1,:);
            y_axis_slice = data(2,:);
            weights = obj.generate_weights(obj.generate_weight_x_axis(numel(data(1,:))));
            
            corrected_y = []; 
            corrected_x = [];

            for index = 1:1:numel(data(1,:))
                fragment_y = ones(1, weights(index), "double") .* y_axis_slice(index);
                corrected_y = cat(2, corrected_y, fragment_y);
                
                fragment_x = ones(1, weights(index), "double") .* x_axis_slice(index);
                corrected_x = cat(2, corrected_x, fragment_x);
            end

            corrected_dataset = cat(1, corrected_x, corrected_y);
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