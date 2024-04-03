classdef RightWindowAlignment < BaseWindowAlignment
    methods (Access = public)
        function start_index = get_start_index(obj)
            arguments(Output)
                start_index int32
            end
            start_index = 1;
        end

        function window = window_generator(obj, index)
            arguments(Output)
                window (1,2) int32
            end

            if index + obj.window_size > obj.dataset_size
                window = [index, obj.datset_size];
            else
                window = index:1:index + obj.window_size;
            end
        end
    end
end