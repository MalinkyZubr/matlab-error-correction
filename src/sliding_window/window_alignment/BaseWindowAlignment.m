classdef (Abstract) BaseWindowAlignment < matlab.mixin.Heterogeneous & handle
    properties(Access = protected)
        dataset_size int32
        window_size int32
    end

    methods (Access = public)
        function set_window_size(obj, window_size)
            obj.window_size = window_size;
        end

        function set_dataset_size(obj, dataset_size)
            obj.dataset_size = dataset_size;
        end

        function window = generate_window(obj, index)
            arguments(Output)
                window (1,:) int32
            end

            if index > obj.dataset_size
                error("I am a silly goober") % implement me
            end
            window = obj.window_generator(index);
        end

        function weight_window = generate_weights_window(obj, index)
            window = obj.generate_window(index);
            center = index - window(1) + 1;
            weight_window = -center + 1:1:numel(window) - center;
        end
    end

    methods (Abstract)
        start_index = get_start_index(obj, dataset_size, window_size)
        window = window_generator(obj, index)
    end
end