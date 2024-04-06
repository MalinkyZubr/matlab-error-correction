classdef (Abstract) Operation < handle
    methods (Abstract)
        output = run(obj, x_axis, y_axis)
    end
end