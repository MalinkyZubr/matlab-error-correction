classdef(Abstract) AggregateDataProcessor < DataProcessor
    methods(Abstract)
        corrected_dataset = de_process_data(obj, data)
    end
end