function [sum,term]=q_expo2(x,q)
% Define the value of x for the Taylor expansion
% Initialize the sum
sum = 0;

% Set the convergence criterion (e.g., tolerance value)
eps = 1e-100; % Adjust as needed

% Set the maximum number of terms
max_terms = 5000;

% Compute the Taylor series expansion of e^x
for n = 0:max_terms
    term =x.^n / q_factorial(n,n,q);
    sum = sum + term;
    
    % Check convergence criterion
    if abs(term) < eps
        break; % Stop if the term is too small
    end
end

end
