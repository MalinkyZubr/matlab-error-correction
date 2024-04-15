% import src using relative path to directory of wherever this .m file happens to be
addpath(genpath("../src"));

% import the data
aggregate_data = readmatrix("sp24_cruiseAuto_experimental_data.csv");

% data input objects. These package the requested columns into a neat little object to make things easier
data_input1 = DataInput("Compact Summer Test", aggregate_data, 1, [2, 6]);
data_input2 = DataInput("Compact Yearround Test", aggregate_data, 1, [7, 11]);
data_input3 = DataInput("Compact Winter Test", aggregate_data, 1, [12, 16]);

data_input4 = DataInput("Sedan Summer Test", aggregate_data, 1, [17, 21]);
data_input5 = DataInput("Sedan Yearround Test", aggregate_data, 1, [22, 26]);
data_input6 = DataInput("Sedan Winter Test", aggregate_data, 1, [27, 31]);

data_input7 = DataInput("Suv Summer Test", aggregate_data, 1, [32, 36]);
data_input8 = DataInput("Suv Yearround Test", aggregate_data, 1, [37, 41]);
data_input9 = DataInput("Suv Winter Test", aggregate_data, 1, [42, 46]);

% Cell array of data input objects, make sure it is a cell array
old_data = {data_input1};%, data_input2, data_input3, data_input4, data_input5, data_input6, data_input7, data_input8, data_input9};

workflow = workflow_factory(true); % generate an error correction workflow
% 'true' to specify that the error correction should be completed thoroughly

% this includes 9 datasets, each is the corrected averaging of the corresponding data.
new_data = error_correct(old_data, workflow); % returns a cell array of all the requested datasets

y_column = new_data{1}.get_y_axis_column(); % get the y axis in column form
x_column = new_data{1}.get_x_axis_column(); % get the x axis in column form

plot(x_column, y_column);
