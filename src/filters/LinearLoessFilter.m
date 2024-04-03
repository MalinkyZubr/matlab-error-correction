classdef LinearLoessFilter < SlidingWindow
    methods(Access = public)
        function y_value_filtered = filter_action(obj, x_slice, y_slice)
            requested_index = obj.window_alignment.get_start_index();
            p = polyfit(x_slice, y_slice, 1);
            y_value_filtered = polyval(p, x_slice(requested_index));
        end
    end
end