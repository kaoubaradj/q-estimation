% q-number [n]_q
function n_q = q_number(n, q)
    if q == 1
        n_q = n;
    else
        n_q = (1 - q^n) / (1 - q);
    end
end
