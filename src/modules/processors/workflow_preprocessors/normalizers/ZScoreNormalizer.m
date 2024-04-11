classdef ZScoreNormalizer < AggregateDataProcessor
    properties(Access = private)
        average double
        standard_deviation double
    end
    methods(Access = public)
        function corrected_dataset = process_data(obj, data)
            obj.average = mean(data(2,:));
            obj.standard_deviation = std(data(2,:));
            data(2,:) = (data(2,:) - obj.average) ./ obj.standard_deviation;
            corrected_dataset = data;
        end

        function corrected_dataset = de_process_data(obj, data)
            data(2,:) = (data(2,:) .* obj.standard_deviation) + obj.average;
            corrected_dataset = data;
        end
    end
end