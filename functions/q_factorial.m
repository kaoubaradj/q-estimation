% q-factorial [n]_q!
function f = q_factorial(n, q)
    if n == 0
        f = 1;
    else
        f = prod(arrayfun(@(k) q_number(k,q), 1:n));
    end
end