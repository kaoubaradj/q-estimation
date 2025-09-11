% q-exponential via series expansion
function sum_val = q_expo2(x, q)
    sum_val = 0;
    tol = 1e-12;
    max_terms = 200;  % reduced for efficiency

    for n = 0:max_terms
        term = x.^n / q_factorial(n, q); % need q_factorial defined
        sum_val = sum_val + term;
        if abs(term) < tol
            break;
        end
    end
end