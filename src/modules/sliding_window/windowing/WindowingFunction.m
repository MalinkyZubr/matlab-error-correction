classdef (Abstract) WindowingFunction < handle & matlab.mixin.Heterogeneous
    properties(Access = protected)
        window_width int32
    end

    methods (Abstract)
        % Description:
        %   Abstract method to generate window indices for a given index.
        %
        % Inputs:
        %   obj   - Instance of the WindowingFunction.
        %   index - Index for which window indices are generated.
        %
        % Outputs:
        %   window_indices - Indices of the window.
        window_indicies = generate_indicies(obj, index)
    end

    methods (Access = public)
        % Description:
        %   Constructor for WindowingFunction class.
        %
        % Inputs:
        %   window_width - Width of the window.
        function obj = WindowingFunction(window_width)
            mustBeOdd(window_width);
            obj.window_width = window_width;
        end

        % Description:
        %   Generates a window slice for the given index in the dataset.
        %
        % Inputs:
        %   obj     - Instance of the WindowingFunction.
        %   index   - Index for which window slice is generated.
        %   dataset - Input dataset.
        %
        % Outputs:
        %   generated_window - Window slice generated from the dataset.
        function generated_window = window(obj, index, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);
            max = numel(dataset(1,:));
            base_window_indicies = obj.generate_indicies(index);
            mustBeLength(base_window_indicies, obj.window_width);
            
            if base_window_indicies(end) > max
                window_x = obj.exceeds_max(base_window_indicies, max);
            elseif base_window_indicies(1) < 1
                window_x = obj.exceeds_min(base_window_indicies);
            else
                window_x = base_window_indicies;
            end

            mustBeLength(window_x, obj.window_width);
            generated_window = cat(1, x_axis(window_x), y_axis(window_x));
        end
    end

    methods (Access = private)
        % Description:
        %   Adjusts the window indices if they exceed the maximum index of the dataset.
        %
        % Inputs:
        %   obj           - Instance of the WindowingFunction.
        %   base_window   - Base window indices.
        %   max           - Maximum index of the dataset.
        %
        % Outputs:
        %   adjusted_indices - Adjusted window indices.
        function adjusted_indicies = exceeds_max(obj, base_window, max)
            exceeding = base_window(end);
            shift = exceeding - max;
            adjusted_indicies = base_window(1) - shift:1:max;
        end

        % Description:
        %   Adjusts the window indices if they exceed the minimum index of the dataset.
        %
        % Inputs:
        %   obj           - Instance of the WindowingFunction.
        %   base_window   - Base window indices.
        %
        % Outputs:
        %   adjusted_indices - Adjusted window indices.
        function adjusted_indicies = exceeds_min(obj, base_window)
            exceeding = abs(base_window(1)) + 1;
            adjusted_indicies = 1:1:base_window(end) + exceeding;
        end
    end
end