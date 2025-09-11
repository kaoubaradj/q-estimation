function plot_q_histogram(samples, q, max_intervals)
%plot_q_histogram Computes q-based intervals, their proportions, and plots a histogram.
%
%   plot_q_histogram(samples, q, max_intervals)
%
%   Inputs:
%       samples       - vector of sample data points
%       q           - q-parameter defining the geometric intervals
%       max_intervals - number of intervals to compute
%
%   This function:
%       1. Computes q-based intervals from max(samples) downwards.
%       2. Calculates the percentage of data points in each interval.
%       3. Plots a histogram with labeled intervals on the x-axis.

    % Optional upper bound choice:
    % b = 1 / (1 - q);
    b = max(samples); 

    intervals = cell(max_intervals, 1);
    percentages = zeros(max_intervals, 1); 
    upper_bound = b;
    midpoints = zeros(max_intervals, 1);

    for i = 1:max_intervals
        lower_bound = q * upper_bound;
        intervals{i} = [lower_bound, upper_bound];
        count_in_interval = sum(samples > lower_bound & samples <= upper_bound);
        percentages(i) = count_in_interval / length(samples);
        midpoints(i) = (lower_bound + upper_bound) / 2;
        upper_bound = lower_bound;
    end

    % Reverse for display (smallest interval first)
    intervals = flip(intervals);
    midpoints = flip(midpoints);
    percentages = flip(percentages);

    % Create interval labels
    interval_labels = cellfun(@(x) sprintf('(%.2f, %.2f)', x(1), x(2)), ...
                              intervals, 'UniformOutput', false);

    % Plot histogram
    figure;
    bar(percentages, 'FaceColor', [0.3 0.6 0.9], 'EdgeColor', 'k');
    set(gca, 'XTick', 1:length(interval_labels), ...
             'XTickLabel', interval_labels, ...
             'XTickLabelRotation', 45);
    ylabel('Proportion');
    xlabel('Intervals');
    title('Percentage of Data Points in Each Interval');
    grid on;
end
