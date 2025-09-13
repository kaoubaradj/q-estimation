function plot_histogram_expo_q(samples, q_theta, x_max, q, numBins)
% plot_expo_q
%
% Plots a histogram of the given sample data alongside the theoretical
% q-Lindley probability density function.
%
% INPUTS:
%   samples  - vector of data points sampled from q-expo distribution
%   q_theta  - q-analog parameter (q-number of theta)
%   q        - q-scaling factor (0 < q < 1)
%   numBins  - number of bins for the histogram (default: 15)
%
% EXAMPLE USAGE:
%   samples = rand(1,500);
%   plot_expo_q(samples, 2.5, 0.7, 15);

    if nargin < 5
        numBins = 15; % default number of bins
    end

    % Plot histogram (normalized as PDF)
    histogram(samples, numBins, 'Normalization', 'pdf', ...
              'FaceColor', [0.2 0.6 0.8], 'FaceAlpha', 0.7);
    hold on;

    % Define target q-expo distribution
    target_distribution = @(x) q_theta * (1 ./ q_expo2(q * q_theta * x, q));

    % Create smooth curve for the theoretical PDF
    x_values = linspace(0, x_max, 1000);

    plot(x_values, target_distribution(x_values), 'r', 'LineWidth', 2);

    % Labels and styling
    xlabel('x');
    ylabel('Density');
    title('q-expo Distribution: Empirical vs Theoretical');
    legend('Sample (Histogram)', 'Theoretical PDF', 'Location', 'Best');
    grid on;
    hold off;
end
