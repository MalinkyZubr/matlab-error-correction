classdef CenterWindow < WindowingFunction
    methods(Access = public)
        % Description:
        %   Generates window indices for a center-aligned window.
        %
        % Inputs:
        %   obj   - Instance of the CenterWindow.
        %   index - Index for which window indices are generated.
        %
        % Outputs:
        %   window_indices - Indices of the center-aligned window.
        function window_indicies = generate_indicies(obj, index)
            side_bound = round((obj.window_width / 2) - 0.5);
            window_indicies = [index - side_bound, index + side_bound - 2];
        end
    end
end