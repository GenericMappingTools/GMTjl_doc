# magic

    M = magic(n::Int) => Matrix{Int}

M = magic(n) returns an n-by-n matrix constructed from the integers 1 through n^2 with equal row
and column sums. The order n must be a scalar greater than or equal to 3 in order to create a
valid magic square.
