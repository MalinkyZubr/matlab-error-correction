function [datasets] = error_correct(datasets)
    arguments(Input)
        datasets (1,:) cell
    end

    workflow = ErrorCorrectionWorkflow(CascadingSequential());
    workflow.add_preprocessor(NaNDetector());
    workflow.add_preprocessor(MinMaxNormalizer());
    workflow.add_operation(DeadDetector(3, 1));
    workflow.add_operation(ZeroDetector());

    mean_filter = MeanFilter(CenterWindow(251));
    mean_filter.add_preprocessor(QuadraticWeightScheme())
    workflow.add_operation(mean_filter);

    workflow.add_operation(ZeroDetector());
    workflow.add_operation(GlitchDetector(0.45, 20, 3, 5));

    widths = [5, 11, 21, 51, 21, 11, 5];
    % for index = 1:1:numel(widths)
    %     mean_filter = MeanFilter(CenterWindow(widths(index)));
    %     mean_filter.add_preprocessor(QuadraticWeightScheme());
    %     workflow.add_operation(mean_filter);
    %     loess_filter = LoessFilter(CenterWindow(widths(index) * 3), 1);
    %     loess_filter.add_preprocessor(QuadraticWeightScheme());
    %     workflow.add_operation(loess_filter);
    %     workflow.add_operation(LoessFilter(CenterWindow(widths(index)), 2))
    % end

    for index = 1:1:numel(datasets)
        data_filtered = workflow.run_workflow(datasets{index}.get_dataset());
        datasets{index}.set_dataset(data_filtered);
    end
end