classdef DeadDetector < Operation
    methods (Access = public)
        function obj = DeadDetector(threshold, polynomial_degree)
            obj.threshold = threshold;
            obj.degree = polynomial_degree;
        end

        function output = run(obj, x_axis, y_axis)
            for index = threshold + 1:1:numel(x_axis)
                left_unique_index = index - threshold;
                examination_slice = y_axis(left_unique_index:1:index);

                if sum(examination_slice, "all") == threshold * y_axis(index)
                    right_unique_index = obj.nearest_unique(index - threshold, y_axis);
                    y_axis(dead_indicies) = obj.pacify_death(left_unique_index, right_unique_index, ...
                                                             x_axis, y_axis);
                end
            end

            output = y_axis;
        end
    end
    methods(Access = private)
        function closest = nearest_unique(obj, start_index, y_axis)
            index = start_index;
            selected_value = y_axis(start_index);
            start_value = selected_value;

            while selected_value == start_value
                index = index + 1;
                selected_value = y_axis(index);
            end

            closest = index;
        end

        function fit_y_values = pacify_death(obj, left_unique_index, right_unique_index, x_axis, y_axis)
            dead_indicies = left_unique_index:1:right_unique_index;
            model = polyfit([x_axis(left_unique_index), x_axis(right_unique_index)], ...
                            [y_axis(left_unique_index), y_axis(right_unique_index)], ...
                            obj.degree);
            fit_y_values = polyval(x_axis(dead_indicies), model);
        end
    end
end