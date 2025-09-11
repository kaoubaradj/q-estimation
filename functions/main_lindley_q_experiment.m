%% ============================================================
% Lindley q-Distribution Experiment
% Stage 1: Estimate c value by replication
% Stage 2: Use mean(c) to compute empirical q-mean and compare
%% ============================================================

function main_lindley_q_experiment()

    % -----------------------
    % User Parameters
    % -----------------------
    numBins       = 15;
    numSamples    = 5000;
    numRuns       = 10;
    maxIntervals  = 50;   % adjustable
    theta          = 2;    % example parameter
    len           = 1;    % adjust as needed
    height        = 1;    % adjust as needed
    q           = 0.9;  % must be 0 < q < 1
    q_theta       = q_number(theta, q);
    
    % -----------------------
    % Stage 1: Estimate c
    % -----------------------
    c_values = zeros(1,numRuns);
    for r = 1:numRuns
        samples = sample_lindley_q(q_theta, len, height, numSamples, q);
        c_values(r) = estimate_c_lindley_q(samples, theta, numBins, q);
    end

    Mean_c = mean(c_values);
    Var_c  = var(c_values);

    fprintf('Estimated Mean(c) = %.5f\n', Mean_c);
    fprintf('Variance of c     = %.5f\n', Var_c);

    % -----------------------
    % Stage 2: Empirical q-mean
    % -----------------------
    samples = sample_lindley(theta, len, height, numSamples, q);

    % Build grid Upper
    b     = max(samples);
    Upper  = b * q.^(0:maxIntervals-1);

    % Kernel density at Upper points
    [f_at_point, ~] = ksdensity(samples, Upper);

    % Optional: force first point to zero
    f_at_point(1) = 0;

    % Weights
    weights = q.^(0:maxIntervals-1);

    % Expectation sum (ensure elementwise multiplication!)
    exp_sum = sum(weights .* f_at_point .* (b * weights * (1 - q)));

    % Empirical mean
    mean_res = Mean_c * b * exp_sum;

    % -----------------------
    % True q-mean
    % -----------------------
    true_mean = compute_true_qmean(q_theta, q);

    % -----------------------
    % Error
    % -----------------------
    abs_err = abs(true_mean - mean_res);
    rel_err = abs_err / abs(true_mean);

    fprintf('Empirical q-mean = %.5f\n', mean_res);
    fprintf('Theoretical q-mean = %.5f\n', true_mean);
    fprintf('Absolute Error = %.5e\n', abs_err);
    fprintf('Relative Error = %.5f%%\n', 100*rel_err);

end


%% ============================================================
% Helper Functions
%% ============================================================

function mu = compute_true_qmean(q_theta, q)
    % Compute theoretical q-mean
    mu = 1/(q_theta^(-1) + q_theta^(-2)) * ...
         (1/q_theta^2 + q_number(2,q)/q_theta^3);
end

