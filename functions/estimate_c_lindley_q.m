%% ============================================================
% Function: estimate_c_lindley_q
% Purpose : Estimate scaling constant c for the Lindley q-distribution
% Method  : Compares theoretical PDF with empirical histogram density
% ============================================================

function c = estimate_c_lindley_q(samples, theta, numBins, q)

    % --------------------------------------------------------
    % Step 1: Compute q-teta1 using q-numbers
    % --------------------------------------------------------
    q_theta = q_number(theta, q); 

    % --------------------------------------------------------
    % Step 2: Build histogram (empirical PDF approximation)
    % --------------------------------------------------------
    [counts, edges] = histcounts(samples, numBins);
    binWidth  = edges(2) - edges(1);
    binCenters = edges(1:end-1) + binWidth/2;

    % Normalize histogram to approximate PDF
    empirical_pdf = counts / (sum(counts) * binWidth);

    % --------------------------------------------------------
    % Step 3: Theoretical PDF at bin centers
    % --------------------------------------------------------
    target_pdf = @(x) (q_theta^2 / (q_theta + 1)) .* ...
                      (1 + x) .* (1 ./ q_expo2(q * q_theta * x, q));

    pdf_values = target_pdf(binCenters);

    % --------------------------------------------------------
    % Step 4: Ratio of theoretical PDF to empirical PDF
    % --------------------------------------------------------
    ratios = pdf_values ./ empirical_pdf;

    % Estimate c as the median of ratios
    c = median(ratios);

end
