# hampel

```
hampel(x; spread=mad(x), threshold=2)
```

Identify outliers using the Hampel criterion.

Given vector `x`, identify elements xₖ such that

```math
|xₖ - m| > t S,
```

where ``m`` is the median of the elements, the dispersion scale ``S`` is provided by the function
`spread`, and the parameter ``t`` is given by `threshold`. The return value is a `Bool` vector.

By default, `spread` is \myreflink{mad} and `threshold` is 2.


---------

```
hampel(x, K; spread=mad, threshold=2, boundary=:truncate)
```

Apply a windowed Hampel filter to a time series.

Given vector `x` and half-width `K`, apply a Hampel criterion within a sliding window of width
2K+1. The median ``m`` of the window replaces the element ``xₖ`` at the center of the window if it satisfies

```math
|xₖ - m| > t S,
```

where the dispersion scale ``S`` is provided by the function `spread` and the parameter
``t`` is given by `threshold`. The window shortens near the beginning and end of the vector
to avoid referencing fictitious elements. Larger values of ``t`` make the filter less agressive,
while ``t=0`` is the standard median filter.

For recursive filtering, see `hampel!`

The value of `boundary` determines how the filter handles the boundaries of the vector:

- `:truncate` (default): the window is shortened at the boundaries
- `:reflect`: values are reflected across the boundaries
- `:repeat`: end values are repeated as necessary

---------

```
hampel(x, weights; ...)
```

Apply a weighted Hampel filter to a time series.

Given vector `x` and a vector `weights` of positive intgers, before computing the criterion
each element in the window is repeated by the number of times given by its corresponding
weight. This is typically used to make the central element more influential than the others.


### CREDITS
This function is adapted from [HampelOutliers.jl](https://github.com/tobydriscoll/HampelOutliers.jl) and you should
consult the original source for more details and examples. The differences with respect to original
`HampelOutliers.jl` functions is that here we created different methods for `Hampel.identify` and
`Hampel.filter` and called them collectively just ``hampel`` and let the multi-dispatch do the work.

### Returns
- A vector of Boolean saying if points were considered _regular_ or outliers.
or
- A filtered version of `x`

### Example

\begin{examplefig}{}
```julia
using GMT

t = (1:50) / 10;
x = [1:2:40; 5t + (@. 6cos(t + 0.5(t)^2)); fill(40,20)];
x[12] = -10; x[50:52] .= -12; x[79:82] .= [-5, 50, 55, 0];
m = hampel(x, 4, threshold=0);
y = hampel(x, 4);

plot(x, marker=:point, mc=:blue, lc=:blue, label="Original", xlabel="k", ylabel="x_k")
scatter!(m, ms="2p", mc=:red, MarkerEdgeColor=true, label="Median filter")
scatter!(y, ms="2p", mc=:green, MarkerEdgeColor=true, label="Hampel filter", show=true)
```
\end{examplefig}
