% 1. q-analog of n
function n_q = q_number(n, q)
if q == 1
    n_q = n;
else
    n_q = (1 - q^n) / (1 - q);
end
end

% 2. q-analog factorial
function q_nfac = q_factorial(n, k, q)
prod = 1;
if k >= 1
    for i = 1:k
        prod = prod * q_number(n - i + 1, q);
    end
end
q_nfac = prod;
end

% 4. q-analog exponential
function sum = q_expo2(x, q)
sum = 0;
eps = 1e-100;
max_terms = 5000;
for n = 0:max_terms
    term = x.^n / q_factorial(n, n, q);
    sum = sum + term;
    if abs(term) < eps
        break;
    end
end
end