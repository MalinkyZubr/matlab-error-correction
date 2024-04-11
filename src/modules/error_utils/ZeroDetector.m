classdef ZeroDetector < Operation
    % Description:
    %   Runs the zero detector operation on the dataset, replacing negative values with zeros.
    %
    % Inputs:
    %   obj     - Instance of the ZeroDetector.
    %   dataset - Input dataset on which the operation is performed.
    %
    % Outputs:
    %   output  - Dataset with negative values replaced by zeros.
    methods(Access = public)
        function output = run(obj, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);
            
            for index = 1:1:numel(x_axis)
                if y_axis(index) < 0
                    y_axis(index) = 0;
                end
            end
            output = cat(1, x_axis, y_axis);
        end
    end
end