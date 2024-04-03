classdef LeftWindowAlignment < BaseWindowAlignment
    methods (Access = public)
        function start_index = get_start_index(obj)
            arguments(Output)
                start_index int32
            end
            start_index = obj.window_size;
        end

        function window = generate_window(obj, index)
            arguments(Output)
                window (1,2) int32
            end

            window = index - obj.window_size:1:index;
        end
    end
end