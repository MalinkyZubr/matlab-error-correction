classdef (Abstract) Operation < handle & matlab.mixin.Heterogeneous
    methods (Abstract)
        output = run(obj, x_axis, y_axis)
    end
end