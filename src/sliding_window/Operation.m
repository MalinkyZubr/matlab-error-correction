classdef (Abstract) Operation < handle & matlab.mixin.Heterogeneous
    properties (Access = protected)
        dataset_size int32
    end

    methods (Abstract)
        output = run(obj, x_axis, y_axis)
    end

    methods (Access = public)
        function set_dataset_size(obj, dataset_size)
            arguments (Input)
                obj Operation
                dataset_size int32
            end

            obj.dataset_size = dataset_size;
        end
    end
end