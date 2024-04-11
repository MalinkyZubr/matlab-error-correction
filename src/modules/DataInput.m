classdef DataInput < handle
    properties(Access = private)
        dataset_name string
        dataset_aligned (2,:) double
    end

    methods(Access = public)
        % Description:
        %   Initializes a DataInput object with the provided dataset information.
        %
        % Inputs:
        %   dataset_name      - Name of the dataset.
        %   dataset           - Input dataset containing x and y values.
        %   x_column_index    - Index of the column containing x values in the dataset.
        %   y_column_range    - Range of column indices containing y values in the dataset.
        %
        % Outputs:
        %   obj               - Initialized DataInput object.
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

        function x_axis = get_x_axis_column(obj)
            x_axis = obj.dataset_aligned(1,:).';
        end

        function y_axis = get_y_axis_column(obj)
            y_axis = obj.dataset_aligned(2,:).';
        end

        function set_dataset(obj, new_dataset)
            obj.dataset_aligned = new_dataset;
        end

        function name = get_name(obj)
            name = obj.dataset_name;
        end
    end
end