classdef GlitchDetector < Operation
    properties(Access = public)
        max_roc_deviation double
        lookbehind int32
        max_cluster_distance int32
        cluster_identity_threshold int32
    end
    methods(Access = public)
        % Description:
        %   Constructor for GlitchDetector class.
        %
        % Inputs:
        %   max_roc_deviation           - Maximum rate of change deviation allowed for glitch detection.
        %   lookbehind                  - Number of data points to look behind for glitch identification.
        %   max_cluster_distance        - Maximum distance allowed between glitch points to consider them in the same cluster.
        %   cluster_identity_threshold  - Minimum number of glitch points required to identify a cluster.
        function obj = GlitchDetector(max_roc_deviation, lookbehind, max_cluster_distance, cluster_identity_threshold);
            obj.max_roc_deviation = max_roc_deviation;
            obj.lookbehind = lookbehind;
            obj.max_cluster_distance = max_cluster_distance;
            obj.cluster_identity_threshold = cluster_identity_threshold;
        end

        % Description:
        %   Runs the glitch detection operation on the dataset.
        %
        % Inputs:
        %   obj     - Instance of the GlitchDetector.
        %   dataset - Input dataset on which the operation is performed.
        %
        % Outputs:
        %   output  - Dataset with detected glitches corrected.
        function output = run(obj, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);

            dydx = gradient(y_axis(:)) ./ gradient(x_axis(:));
            fastest_decrease = min(dydx);
            roc_range = [fastest_decrease - fastest_decrease * obj.max_roc_deviation, fastest_decrease + fastest_decrease * obj.max_roc_deviation];
            glitch_indicies = find(dydx < roc_range(1));
            
            glitch_cluster_start_indicies = obj.identify_clusters(glitch_indicies);

            if numel(glitch_cluster_start_indicies) > 0
                for n = 1:1:numel(glitch_cluster_start_indicies)
                    glitch_start_index = glitch_cluster_start_indicies(n) - obj.lookbehind;
                    glitch_end_index = obj.identify_glitch_end(y_axis, glitch_start_index)
                    p = polyfit([x_axis(glitch_start_index), x_axis(glitch_end_index)], ...
                                [y_axis(glitch_start_index), y_axis(glitch_end_index)], 1);
                    
                    y_axis(glitch_start_index:1:glitch_end_index) = polyval(p, x_axis(glitch_start_index:1:glitch_end_index));
                end
            end

            output = cat(1, x_axis, y_axis);
        end
    end

    methods(Access = private)
        % Description:
        %   Identifies clusters of glitch points.
        %
        % Inputs:
        %   obj                - Instance of the GlitchDetector.
        %   derivative_indicies - Indices of points with significant rate of change.
        %
        % Outputs:
        %   cluster_start_indicies - Indices indicating the start of each glitch cluster.
        function cluster_start_indicies = identify_clusters(obj, derivative_indicies)
            cluster_start_indicies = [];
            current_cluster = [];
            for index = 2:1:numel(derivative_indicies)
                difference = derivative_indicies(index) - derivative_indicies(index - 1);
                if difference <= obj.max_cluster_distance
                    current_cluster(end + 1) = derivative_indicies(index);
                elseif numel(current_cluster) > obj.cluster_identity_threshold
                    cluster_start_indicies(end + 1) = current_cluster(1);
                    current_cluster = [];
                else
                    current_cluster = [];
                end
            end
        end

        % Description:
        %   Identifies the end index of a glitch cluster.
        %
        % Inputs:
        %   obj          - Instance of the GlitchDetector.
        %   y_axis       - Y-axis values of the dataset.
        %   start_index  - Start index of the glitch cluster.
        %
        % Outputs:
        %   end_index    - End index of the glitch cluster.
        function end_index = identify_glitch_end(obj, y_axis, start_index)
            index = start_index;
            while (index < numel(y_axis)) && y_axis(index) <= y_axis(start_index)
                index = index + 1;
            end
            end_index = index;
        end
    end
end