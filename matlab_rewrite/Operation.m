classdef (Abstract) Operation < handle & matlab.mixin.Heterogeneous
    methods (Access = public)
        corrected_dataset = run(obj, dataset)
    end
end