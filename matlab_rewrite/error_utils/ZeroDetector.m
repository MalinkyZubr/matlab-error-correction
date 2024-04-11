classdef ZeroDetector < Operation
    methods(Access = public)
        function output = run(obj, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);
            
            for index = 1:1:numel(x_axis)
                if y_axis(index) < 0
                    y_axis(index) = 0;
                end
            end
            output = cat(1, x_axis, y_axis);
        end
    end
end