classdef CenterWindow < WindowingFunction
    methods(Access = public)
        function window_indicies = generate_indicies(obj, index)
            side_bound = round((obj.window_width / 2) - 0.5);
            window_indicies = index - side_bound:1:index + side_bound - 2;
        end
    end
end