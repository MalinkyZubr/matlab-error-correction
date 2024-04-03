classdef (Abstract) BaseWindowAlignment
    properties(Access = protected)
        dataset_size int32
        window_size int32
    end

    methods (Access = public)
        function obj = set_window_size(obj, window_size)
            obj.window_size = window_size;
        end

        function obj = set_dataset_size(obj, dataset_size)
            obj.dataset_size = dataset_size;
        end

        function window = generate_window(obj, index)
            arguments(Output)
                window (1,2) int32
            end

            if index > obj.dataset_size
                error("") % implement me
            end
            window = obj.generate_window(index);
        end
    end
    methods (Abstract)
        start_index = get_start_index(obj, dataset_size, window_size)
        window = window_generator(obj, index)
    end
end