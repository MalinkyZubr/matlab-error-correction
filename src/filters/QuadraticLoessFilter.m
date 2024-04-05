classdef QuadraticLoessFilter < SlidingWindow
    methods(Access = public)
        function y_value_filtered = filter_action(obj, x_slice, y_slice, requested_index)
            p = polyfit(x_slice, y_slice, 2);
            y_value_filtered = polyval(p, x_slice(requested_index));
        end
    end
end