addpath(genpath("../src"));

aggregate_data = readmatrix("sp24_cruiseAuto_experimental_data.csv");

data_input1 = DataInput("Compact Summer Test", aggregate_data, 1, [2, 6]);
data_input2 = DataInput("Compact Yearround Test", aggregate_data, 1, [7, 11]);
data_input3 = DataInput("Compact Winter Test", aggregate_data, 1, [12, 16]);

new_data = error_correct({data_input2});


for index = 1:1:numel(new_data)
    subplot(2, 2, index)
    data = new_data{index}.get_dataset();
    name = new_data{index}.get_name();

    plot(data(1,:), data(2,:));
    title(name);
end

%speed(95) = 3.5;

