classdef LeftWindow < WindowingFunction
    methods(Access = public)
        % Description:
        %   Generates window indices for a left-aligned window.
        %
        % Inputs:
        %   obj   - Instance of the LeftWindow.
        %   index - Index for which window indices are generated.
        %
        % Outputs:
        %   window_indices - Indices of the left-aligned window.
        function window_indicies = generate_indicies(obj, index)
            window_indicies = index - (obj.window_width + 1):1:index;
        end
    end
end