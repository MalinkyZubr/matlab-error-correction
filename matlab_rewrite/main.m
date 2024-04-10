addpath(genpath("validators"));
addpath(genpath("sliding_window"));
addpath(genpath("run_strategy"));
addpath(genpath("processors"));
addpath(genpath("error_utils"));

%data = readmatrix("sp24_cruiseAuto_experimental_data.csv");
%data = cat(1, data(:,1), data(:,2));

x_axis = 1:1:10000;
y_axis = log10(x_axis);
y_axis_noisy = y_axis + 0.5*rand(size(x_axis)) - 0.5*rand(size(x_axis));
y_axis_noisy(:, 5000:5500) = y_axis_noisy(4999);

data = cat(1, x_axis, y_axis_noisy);

workflow = ErrorCorrectionWorkflow(CascadingSequential());

%workflow.add_preprocessor(MinMaxNormalizer());

workflow.add_operation(NaNDetector());
workflow.add_operation(DeadDetector(3, 1));

%workflow.add_operation(LoessFilter(CenterWindow(501), 1));
%workflow.add_operation(LoessFilter(CenterWindow(15), 2));

%median_filter = MedianFilter(CenterWindow(15));
%median_filter.add_preprocessor(QuadraticWeightScheme(1));
%mean_filter = MeanFilter(CenterWindow(3));
%mean_filter.add_preprocessor(TriangleWeightScheme(1));

%workflow.add_operation(median_filter);
%workflow.add_operation(mean_filter);

data_filtered = workflow.run_workflow(data);

figure(1);
hold on;
plot(x_axis, y_axis_noisy)
plot(data_filtered(1,:), data_filtered(2,:));

clear all;