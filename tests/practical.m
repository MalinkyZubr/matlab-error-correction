addpath("tests");
addpath("src");
addpath(genpath("src/error_utils"));
addpath(genpath("src/filters"));
addpath(genpath("src/sliding_window"))

data = readmatrix("sp24_cruiseAuto_experimental_data.csv");
data = data(:,1:2);

%time = 1:1:10000;
%speed = log10(time);
%speed = speed + 0.5*rand(size(speed)) - 0.5*rand(size(speed));
%speed(55) = 0.9;
%speed(95) = 3.5;

