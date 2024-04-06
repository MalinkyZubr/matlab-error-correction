classdef NaNDetector < Operation
    methods(Access = public)
        function output = run(obj, x_axis, y_axis)
            for start_index = 1:1:numel(x_axis)
                value = y_axis(start_index);
                if isnan(value)
                    search_index = start_index;
                    while isnan(y_axis(search_index))
                        search_index = search_index + 1;
                    end
                    indicies = [start_index - 1, search_index];
                    x = x_axis(indicies);
                    y = y_axis(indicies);
                    p = polyfit(x, y, 1);
                    y_axis(start_index) = polyval(p, x_axis(start_index));
                end
            end
            output = y_axis;
        end
    end
end