classdef(Abstract) RunStrategy < handle & matlab.mixin.Heterogeneous
    methods(Abstract)
        corrected_dataset = run_operations(obj, operations, dataset)
    end
end