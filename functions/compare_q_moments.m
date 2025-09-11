% compare_q_moments.m
%
% Computes empirical q-moments from a given sample using kernel density
% estimation, compares them with theoretical q-moments, and returns the ratios.
%
% USAGE:
%   [mom_res, mom_theo, ratios] = compare_q_moments(samples, q, max_intervals, teta)
%
% INPUTS:
%   samples       - vector of observed data points
%   q           - q-scaling factor (0 < q < 1)
%   max_intervals - number of q-based intervals for computation
%   teta          - parameter for theoretical q-moment functions
%
% OUTPUTS:
%   mom_res   - [mom_1_res, mom_2_res, mom_3_res], empirical q-moments
%   mom_theo  - [mom1_theo, mom2_theo, mom3_theo], theoretical q-moments
%   ratios    - [c_1, c_2, c_3], ratios of theoretical to empirical moments
%
% DEPENDENCIES:
%   Requires the function q_number(teta, q) to be defined in your path.

function [mom_res, mom_theo, ratios] = compare_q_moments(samples, q, max_intervals, teta)

    % Upper bounds sequence
    Upper = [];
    b = max(samples);
    bound = b;
    for i = 1:max_intervals
        Upper = [Upper, bound];
        bound = q * bound;
    end

    % Kernel density at interval upper bounds
    [f_at_point, ~] = ksdensity(samples, Upper);
    f_at_point(1) = 0;

    % Empirical q-moment sums
    exp_sum_1   = 0;
    exp_sum_2 = 0;
    exp_sum_3 = 0;

    for i = 1:max_intervals
        weight = f_at_point(i) * (b * q^(i-1) * (1 - q));
        exp_sum_1   = exp_sum_1   + q^(i-1)   * weight;
        exp_sum_2 = exp_sum_2 + (q^(i-1))^2 * weight;
        exp_sum_3 = exp_sum_3 + (q^(i-1))^3 * weight;
    end

    % Empirical q-moments
    mom_1_res = b   * exp_sum_1;
    mom_2_res = b^2 * exp_sum_2;
    mom_3_res = b^3 * exp_sum_3;

    mom_res = [mom_1_res, mom_2_res, mom_3_res];

    % Theoretical q-moments (require q_number function)
    u1 = @(teta) (q_number(teta, q) + q_number(2, q)) ./ ...
                 (q_number(teta, q) .* (q_number(teta, q) + 1));

    u2 = @(teta) q_number(2, q) .* (q_number(teta, q) + q_number(3, q)) ./ ...
                 (q_number(teta, q).^2 .* (q_number(teta, q) + 1));

    u3 = @(teta) q_number(2, q) .* q_number(3, q) .* (q_number(teta, q) + q_number(4, q)) ./ ...
                 (q_number(teta, q).^3 .* (q_number(teta, q) + 1));

    mom1_theo = u1(teta);
    mom2_theo = u2(teta);
    mom3_theo = u3(teta);

    mom_theo = [mom1_theo, mom2_theo, mom3_theo];

    % Ratios
    c_1 = mom1_theo / mom_1_res;
    c_2 = mom2_theo / mom_2_res;
    c_3 = mom3_theo / mom_3_res;

    ratios = [c_1, c_2, c_3];

end
