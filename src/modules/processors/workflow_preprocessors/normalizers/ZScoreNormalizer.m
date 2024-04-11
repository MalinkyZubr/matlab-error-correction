classdef ZScoreNormalizer < AggregateDataProcessor
    properties(Access = private)
        average double
        standard_deviation double
    end
    methods(Access = public)
        % Description:
        %   Processes the dataset by normalizing it using z-score normalization.
        %
        % Inputs:
        %   obj     - Instance of the ZScoreNormalizer.
        %   data    - Input dataset to be normalized.
        %
        % Outputs:
        %   corrected_dataset - Normalized dataset using z-score normalization.
        function corrected_dataset = process_data(obj, data)
            obj.average = mean(data(2,:));
            obj.standard_deviation = std(data(2,:));
            data(2,:) = (data(2,:) - obj.average) ./ obj.standard_deviation;
            corrected_dataset = data;
        end

        % Description:
        %   Reverses the normalization operation, restoring the original values.
        %
        % Inputs:
        %   obj            - Instance of the ZScoreNormalizer.
        %   corrected_data - Data previously normalized using z-score normalization.
        %
        % Outputs:
        %   corrected_dataset - Original dataset restored from normalized data.
        function corrected_dataset = de_process_data(obj, data)
            data(2,:) = (data(2,:) .* obj.standard_deviation) + obj.average;
            corrected_dataset = data;
        end
    end
end