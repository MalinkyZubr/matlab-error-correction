classdef DeadDetector < Operation
    properties(Access = private)
        threshold int32
        degree int32
    end
    methods (Access = public)
        % Description:
        %   Constructor for DeadDetector class.
        %
        % Inputs:
        %   threshold          - Threshold for detecting dead zones.
        %   polynomial_degree  - Degree of polynomial for curve fitting.
        function obj = DeadDetector(threshold, polynomial_degree)
            obj.threshold = threshold;
            obj.degree = polynomial_degree;
        end

        % Description:
        %   Runs the dead zone detection operation on the dataset.
        %
        % Inputs:
        %   obj     - Instance of the DeadDetector.
        %   dataset - Input dataset on which the operation is performed.
        %
        % Outputs:
        %   output  - Dataset with dead zones detected and corrected.
        function output = run(obj, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);
            
            for index = obj.threshold + 1:1:numel(x_axis)
                left_unique_index = index - obj.threshold;
                examination_slice = y_axis(left_unique_index:1:index);

                if sum(examination_slice, "all") == obj.threshold * y_axis(index)
                    right_unique_index = obj.nearest_unique(index - obj.threshold, y_axis);
                    y_axis(dead_indicies) = obj.pacify_death(left_unique_index, right_unique_index, ...
                                                             x_axis, y_axis);
                end
            end

            output = cat(1, x_axis, y_axis);
        end
    end
    methods(Access = private)
        % Description:
        %   Finds the nearest unique value index.
        %
        % Inputs:
        %   obj        - Instance of the DeadDetector.
        %   start_index - Start index for search.
        %   y_axis     - Y-axis values of the dataset.
        %
        % Outputs:
        %   closest    - Index of the nearest unique value.
        function closest = nearest_unique(obj, start_index, y_axis)
            index = start_index;
            selected_value = y_axis(start_index);
            start_value = selected_value;

            while (selected_value == start_value) && index < numel(y_axis)
                index = index + 1;
                selected_value = y_axis(index);
            end
            if index == numel(y_axis)
                index = start_index - 10;
            end

            closest = index;
        end

        % Description:
        %   Pacifies the dead zone by fitting a curve.
        %
        % Inputs:
        %   obj                 - Instance of the DeadDetector.
        %   left_unique_index   - Start index of the dead zone.
        %   right_unique_index  - End index of the dead zone.
        %   x_axis              - X-axis values of the dataset.
        %   y_axis              - Y-axis values of the dataset.
        %
        % Outputs:
        %   fit_y_values        - Values of the fitted curve within the dead zone.
        function fit_y_values = pacify_death(obj, left_unique_index, right_unique_index, x_axis, y_axis)
            dead_indicies = left_unique_index:1:right_unique_index;
            model = polyfit([x_axis(left_unique_index), x_axis(right_unique_index)], ...
                            [y_axis(left_unique_index), y_axis(right_unique_index)], ...
                            obj.degree);
            fit_y_values = polyval(x_axis(dead_indicies), model);
        end
    end
end