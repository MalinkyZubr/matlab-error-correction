addpath("src");

data = readmatrix("sp24_cruiseAuto_experimental_data.csv");
time = data(:,1);
speed = data(:,37);

previous_value = 0;

for n = 1:1:numel(time)
    value = speed(n);
    if isnan(value)
        i = n;
        while isnan(speed(i))
            i = i + 1;
        end
        indicies = [n - 1, i];
        x = time(indicies);
        y = speed(indicies);
        p = polyfit(x, y, 1);
        speed(n) = polyval(p, time(n));
    end
end

%x_axis = 1:1:10000;
%y_axis = log10(x_axis);
%y_axis_noisy = y_axis + 0.5*rand(size(x_axis)) - 0.5*rand(size(x_axis));
%y_axis_noisy(55) = 0.9;
%y_axis_noisy(95) = 3.5;

filtering_workflow = ErrorCorrectionWorkflow(time, speed);

%filtering_workflow.add_operation(QuarticLoessFilter(101, CenterWindowAlignment()));
filtering_workflow.add_operation(QuadraticLoessFilter(201, CenterWindowAlignment()));
filtering_workflow.add_operation(LinearLoessFilter(101, CenterWindowAlignment()));

for n = 3:2:51
    filtering_workflow.add_operation(LinearLoessFilter(n, CenterWindowAlignment()));
    filtering_workflow.add_operation(MedianFilter(n, CenterWindowAlignment()));
    filtering_workflow.add_operation(SquareFilter(n, CenterWindowAlignment()));
    filtering_workflow.add_operation(MeanGlitchDetector(17, LeftWindowAlignment(), 2));
end

filtering_workflow.add_operation(MedianFilter(51, CenterWindowAlignment()));
filtering_workflow.add_operation(SquareFilter(51, CenterWindowAlignment()));

filtering_workflow.add_operation(MeanGlitchDetector(101, CenterWindowAlignment(), 0.35));
filtering_workflow.add_operation(MeanGlitchDetector(17, CenterWindowAlignment(), 2));

filtered_y_axis = filtering_workflow.run();

figure(1);
hold on;
plot(time, speed, "b");
plot(time, filtered_y_axis, "g");


