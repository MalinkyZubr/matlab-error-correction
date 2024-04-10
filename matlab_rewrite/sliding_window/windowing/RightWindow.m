classdef RightWindow < WindowingFunction
    methods(Access = public)
        function window_indicies = generate_indicies(obj, index)
            window_indicies = index:1:index + (obj.window_width - 1);
        end
    end
end