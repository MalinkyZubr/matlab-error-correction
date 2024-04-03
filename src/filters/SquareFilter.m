classdef SquareFilter < SlidingWindow
    methods(Access = public)
        function y_value_filtered = filter_action(obj, x_slice, y_slice)
            y_value_filtered = mean(y_slice);
        end
    end
end

