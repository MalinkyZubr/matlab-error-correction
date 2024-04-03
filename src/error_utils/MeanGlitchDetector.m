classdef MeanGlitchDetector < SlidingWindow
    properties (Access = private)
        threshold double
    end
    methods(Access = public)
        function obj = MeanGlitchDetector(width, window_alignment, threshold)
            obj@SlidingWindow(width, window_alignment);
            obj.threshold = threshold;
        end

        function y_value_filtered = filter_action(obj, x_slice, y_slice)
            window_mean = mean(y_slice);
            y_value_unfiltered = y_slice(obj.get_start_index());
            
            if abs(y_slice(y_value_unfiltered - window_mean)) > obj.threshold
                y_value_filtered = window_mean;
            else
                y_value_filtered = y_value_unfiltered;
            end
        end
    end
end