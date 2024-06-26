classdef NaNDetector < AggregateDataProcessor
    methods(Access = public)
        % Description:
        %   Processes the dataset to handle NaN values by linear interpolation.
        %
        % Inputs:
        %   obj     - Instance of the NaNDetector.
        %   dataset - Input dataset containing NaN values to be handled.
        %
        % Outputs:
        %   output  - Processed dataset with NaN values handled by linear interpolation.
        function output = process_data(obj, dataset)
            x_axis = dataset(1,:);
            y_axis = dataset(2,:);
            
            for start_index = 1:1:numel(x_axis)
                value = y_axis(start_index);

                if isnan(value)
                    search_index = start_index;
                    while isnan(y_axis(search_index)) && search_index < numel(x_axis)
                        search_index = search_index + 1;
                    end
                    if search_index == numel(x_axis)
                        search_index = start_index - 10;
                    end
                    indicies = [start_index - 1, search_index];

                    x = x_axis(indicies);
                    y = y_axis(indicies);
                    p = polyfit(x, y, 1);

                    fit_value = polyval(p, x_axis(start_index));
                    y_axis(start_index) = fit_value;
                end
            end
            output = cat(1, x_axis, y_axis);
        end

        function corrected_dataset = de_process_data(obj, data)
            corrected_dataset = data;
        end
    end
end