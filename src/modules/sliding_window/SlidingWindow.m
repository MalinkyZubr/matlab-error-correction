classdef (Abstract) SlidingWindow < Operation
    properties(Access = private)
        data_processors cell
        windowing_function WindowingFunction
    end

    methods(Abstract)
        % Description:
        %   Abstract method to perform sliding operation on a dataset slice.
        %
        % Inputs:
        %   obj           - Instance of the SlidingWindow.
        %   dataset_slice - Slice of the dataset to apply the sliding operation.
        %   x_value       - X-axis value corresponding to the dataset slice.
        %
        % Outputs:
        %   filtered_value - Result of the sliding operation.
        filtered_value = sliding_operation(obj, dataset_slice, x_value)
    end

    methods(Access = public)
        % Description:
        %   Constructor for SlidingWindow class.
        %
        % Inputs:
        %   windowing_function - Windowing function object to be used for generating window slices.
        function obj = SlidingWindow(windowing_function)
            obj.windowing_function = windowing_function;
        end

        % Description:
        %   Executes the sliding window operation on the given dataset.
        %
        % Inputs:
        %   dataset - Input dataset to apply the sliding window operation.
        %
        % Outputs:
        %   corrected_dataset - Dataset after applying the sliding window operation.
        function corrected_dataset = run(obj, dataset)
            x_axis = dataset(1,:);

            for index = 1:1:numel(dataset(1,:))
                window = obj.windowing_function.window(index, dataset);
                processed_data = obj.apply_preprocessors(window);
                dataset(2, index) = obj.sliding_operation(processed_data, x_axis(index));
            end
            corrected_dataset = dataset;
        end

        % Description:
        %   Adds a data preprocessor to the SlidingWindow.
        %
        % Inputs:
        %   preprocessor - Data preprocessor object to be added.
        function add_preprocessor(obj, preprocessor)
            obj.data_processors{numel(obj.data_processors) + 1} = preprocessor;
        end
    end
    methods(Access = private)
        % Description:
        %   Applies data preprocessors to the data slice.
        %
        % Inputs:
        %   data_slice - Slice of the dataset to apply data preprocessors.
        %
        % Outputs:
        %   processed_data - Data slice after applying data preprocessors.
        function processed_data = apply_preprocessors(obj, data_slice)
            if numel(obj.data_processors) ~= 0
                for index = 1:1:numel(obj.data_processors)
                    %data_slice
                    data_slice = obj.data_processors{index}.process_data(data_slice);
                    %data_slice
                end
            end
            processed_data = data_slice;
        end
    end
end