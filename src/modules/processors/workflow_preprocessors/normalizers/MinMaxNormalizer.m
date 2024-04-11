classdef MinMaxNormalizer < AggregateDataProcessor
    properties(Access = public)
        minimum double
        maximum double
    end
    methods(Access = public)
        % Description:
        %   Processes the dataset by normalizing it using min-max normalization.
        %
        % Inputs:
        %   obj     - Instance of the MinMaxNormalizer.
        %   data    - Input dataset to be normalized.
        %
        % Outputs:
        %   corrected_dataset - Normalized dataset using min-max normalization.
        function corrected_dataset = process_data(obj, data)
            obj.minimum = min(data(2,:));
            obj.maximum = max(data(2,:));
            data(2,:) = (data(2,:) - obj.minimum) ./ (obj.maximum - obj.minimum);
            corrected_dataset = data;
        end

        % Description:
        %   Reverses the normalization operation, restoring the original values.
        %
        % Inputs:
        %   obj            - Instance of the MinMaxNormalizer.
        %   corrected_data - Data previously normalized using min-max normalization.
        %
        % Outputs:
        %   corrected_dataset - Original dataset restored from normalized data.
        function corrected_dataset = de_process_data(obj, data)
            data(2,:) = (data(2,:) .* (obj.maximum - obj.minimum)) + obj.minimum;
            corrected_dataset = data;
        end
    end
end