classdef DataInput < handle
    properties(Access = private)
        dataset_name string
        dataset_aligned (2,:) double
    end

    methods(Access = public)
        function obj = DataInput(dataset_name, dataset, x_column_index, y_column_range)
            x_axis = dataset(:,x_column_index).';
            y_axis = dataset(:,y_column_range(1):y_column_range(2));
            y_axis_mean = mean(y_axis, 2).';

            obj.dataset_aligned = cat(1, x_axis, y_axis_mean);
            obj.dataset_name = dataset_name;
        end

        function dataset_aligned = get_dataset(obj)
            dataset_aligned = obj.dataset_aligned;
        end

        function set_dataset(obj, new_dataset)
            obj.dataset_aligned = new_dataset;
        end

        function name = get_name(obj)
            name = obj.dataset_name;
        end
    end
end