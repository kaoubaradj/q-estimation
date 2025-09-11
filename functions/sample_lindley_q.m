%% ============================================================
% Function: sample_lindley_q
% Purpose : Generate random samples from Lindley q-distribution
% Method  : Acceptance-Rejection Sampling
% ============================================================

function samples = sample_lindley_q(q_theta, len, height, num_samples, q)

    % Target PDF (lindley q-distribution)
    target_pdf = @(x) (q_theta^2 / (q_theta + 1)) .* ...
                      (1 + x) .* (1 ./ q_expo2(q * q_theta * x, q));

    % Proposal: Uniform(0,len), density = 1/len
    proposal_pdf = 1/len;

    % Envelope constant (should be chosen ? sup(target/proposal))
    envelope_const = height * len;

    % Storage for samples
    samples = zeros(1,num_samples);
    count = 0;

    % Acceptance-Rejection Loop
    while count < num_samples
        x = unifrnd(0, len); % proposal sample
        u = rand;           % uniform(0,1)

        acceptance_ratio = target_pdf(x) / (envelope_const * proposal_pdf);

        if u < acceptance_ratio
            count = count + 1;
            samples(count) = x;
        end
    end
end

