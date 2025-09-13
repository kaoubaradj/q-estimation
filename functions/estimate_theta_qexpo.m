function theta_opt = estimate_theta_qexpo(sample, max_intervals, q)
% -------------------------------------------------------------------------
% Estimate the parameter theta of a expo q-distribution
% using modified method of moments and nonlinear least-squares optimization.
%
% INPUTS:
%   sample        - observed data (vector)
%   max_intervals - number of geometric partitions
%   q           - q-parameter (0 < q < 1)
%
% OUTPUT:
%   theta - estimated parameter
%
% -------------------------------------------------------------------------

    % ============================
    % Step 1: Define interval bounds
    % ============================
    b = max(sample);   % Maximum observed value in the sample
    Upper = zeros(1, max_intervals);
    bound = b;
    % Generate decreasing upper bounds: b, q*b, q^2*b, ...
    for i = 1:max_intervals
        Upper(i) = bound;
        bound = q * bound;
    end

    % ============================
    % Step 2: Kernel density estimation (KDE)
    % ============================
    % Approximate the density of the sample at the chosen points
    [f_at_point, ~] = ksdensity(sample, Upper);

    % Manually set first value to zero (adjustment)
    f_at_point(1) = 0;

    % ============================
    % Step 3: Compute weighted sums
    % ============================
    exp_sum_1 = 0;
    exp_sum_2 = 0;

    for i = 1:max_intervals
        % Weight factor for this interval
        weight = b * q^(i-1) * (1 - q);

        % Approximate contributions 
        exp_sum_1   = exp_sum_1   + q^(i-1)     * f_at_point(i) * weight;
        exp_sum_2 = exp_sum_2 + (q^(i-1))^2 * f_at_point(i) * weight;
    end

    % First and second weighted sum approximations
    mom_1_res   = b   * exp_sum_1;    % Approximation of U1 (first weighted sum)
    mom_2_res = b^2 * exp_sum_2;  % Approximation of U2 (second weighted sum)

    % ============================
    % Step 4: Define theoretical q-moments
    % ============================
    % q_number(n, q) is the q-analog of the number n with base q.
    u1 = @(q_theta) 1 / q_theta;

    u2 = @(q_theta) q_number(2, q) / q_theta^2;

    % ============================
    % Step 5: Objective function for optimization
    % ============================
    % Compare theoretical ratio with empirical ratio
    objective = @(param) u2(param) - ...
                         u1(param) * mom_2_res / mom_1_res;

    % ============================
    % Step 6: Solve nonlinear least squares
    % ============================
    initial_guess = 0.75;
    lb = 0;   % lower bound
    ub = 20;  % upper bound

    options = optimset('Display', 'off'); % suppress output
    [sol, ~] = lsqnonlin(objective, initial_guess, lb, ub, options);

    % ============================
    % Step 7: Final transformation
    % ============================
    theta_opt = log(1 - (1 - q) * sol) / log(q);
end

% Helper functions 

% 1. q-analog of n
function n_q = q_number(n, q)
if q == 1
    n_q = n;
else
    n_q = (1 - q^n) / (1 - q);
end
end