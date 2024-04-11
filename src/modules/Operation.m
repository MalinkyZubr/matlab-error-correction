classdef (Abstract) Operation < handle & matlab.mixin.Heterogeneous
    methods (Access = public)
        % Description:
        %   Abstract method to execute the operation on the dataset.
        %
        % Inputs:
        %   obj     - Instance of the operation.
        %   dataset - Input dataset to apply the operation.
        %
        % Outputs:
        %   corrected_dataset - Corrected dataset after applying the operation.
        corrected_dataset = run(obj, dataset)
    end
end