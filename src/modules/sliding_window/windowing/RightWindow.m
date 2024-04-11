classdef RightWindow < WindowingFunction
    methods(Access = public)
         % Description:
        %   Generates window indices for a right-aligned window.
        %
        % Inputs:
        %   obj   - Instance of the RightWindow.
        %   index - Index for which window indices are generated.
        %
        % Outputs:
        %   window_indices - Indices of the right-aligned window.
        function window_indicies = generate_indicies(obj, index)
            window_indicies = index:1:index + (obj.window_width - 1);
        end
    end
end