classdef (Abstract) SlidingWindow < Operation
    properties(Access = private)
        data_processors cell
        windowing_function WindowingFunction
    end

    methods(Abstract)
        filtered_value = sliding_operation(obj, dataset_slice, x_value)
    end

    methods(Access = public)
        function obj = SlidingWindow(windowing_function)
            obj.windowing_function = windowing_function;
        end

        function corrected_dataset = run(obj, dataset)
            x_axis = dataset(1,:);

            for index = 1:1:numel(dataset(1,:))
                window = obj.windowing_function.window(index, dataset);
                processed_data = obj.apply_preprocessors(window);
                dataset(2, index) = obj.sliding_operation(processed_data, x_axis(index));
            end
            corrected_dataset = dataset;
        end

        function add_preprocessor(obj, preprocessor)
            obj.data_processors{numel(obj.data_processors) + 1} = preprocessor;
        end
    end
    methods(Access = private)
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