classdef CenterWindowAlignment < BaseWindowAlignment
    methods (Access = public)
        function start_index = get_start_index(obj)
            arguments(Input)
                obj CenterWindowAlignment
            end
            arguments(Output)
                start_index int32
            end

            start_index = int32((obj.window_size / 2) + 0.5);
        end

        function window = window_generator(obj, index)
            arguments(Output)
                window (1,:) int32
            end

            side_bound = ((obj.window_size / 2) - 0.5) - 1;
            if index + side_bound > obj.dataset_size
                window = index - side_bound:1:obj.dataset_size;
            elseif index - side_bound < 1
                window = 1:1:index + side_bound + abs(index - side_bound) + 1;
            else
                window = index - side_bound - (index + side_bound - obj.dataset_size):1:index + side_bound;
            end
        end
    end
end