classdef(Abstract) DataProcessor < handle & matlab.mixin.Heterogeneous
    methods(Abstract)
        corrected_dataset = process_data(obj, data)
    end
end