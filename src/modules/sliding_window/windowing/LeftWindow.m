classdef LeftWindow < WindowingFunction
    methods(Access = public)
        function window_indicies = generate_indicies(obj, index)
            window_indicies = index - (obj.window_width + 1):1:index;
        end
    end
end