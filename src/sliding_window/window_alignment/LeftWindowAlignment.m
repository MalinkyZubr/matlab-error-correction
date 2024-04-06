classdef LeftWindowAlignment < BaseWindowAlignment
    methods (Access = public)
        function start_index = get_start_index(obj)
            arguments(Output)
                start_index int32
            end
            start_index = obj.window_size;
        end

        function window = window_generator(obj, index)
            arguments(Output)
                window (1,:) int32
            end

            window = index + 1 - obj.window_size:1:index;
        end

        function weight_window = generate_weights_window(obj)
            weight_window = 0:1:obj.window_size;
        end
    end
end