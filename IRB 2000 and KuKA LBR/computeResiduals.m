function f = computeResiduals(thetas, M)
    f = zeros(12, 1);
    for i = 1:12
        f(i) = feval(['f', num2str(i)], thetas, M);
    end
end