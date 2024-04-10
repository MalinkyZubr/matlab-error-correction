classdef MinMaxNormalizer < AggregateDataProcessor
    properties(Access = public)
        minimum double
        maximum double
    end
    methods(Access = public)
        function corrected_dataset = process_data(obj, data)
            obj.minimum = min(data(2,:));
            obj.maximum = max(data(2,:));
            data(2,:) = (data(2,:) - obj.minimum) ./ (obj.maximum - obj.minimum);
            corrected_dataset = data;
        end

        function corrected_dataset = de_process_data(obj, data)
            data(2,:) = (data(2,:) .* (obj.maximum - obj.minimum)) + obj.minimum;
            corrected_dataset = data;
        end
    end
end