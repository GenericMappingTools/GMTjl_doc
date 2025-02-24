# findpeaks

```
findpeaks(y, x=1:length(y); min_height=minimum(y), min_prom=minimum(y), min_dist=0, threshold=0)
or
    
findpeaks(D::GMTdataset; min_height=D.bbox[1], min_prom=zero(D[1]), min_dist=0, threshold=0)
```

Returns indices of local maxima (sorted from highest peaks to lowest) in 1D array of real numbers.
Similar to MATLAB's findpeaks().

A local peak is a data sample that is either larger than its two neighboring samples or is equal to Inf.
The peaks are output in order of occurrence. This function is from the [Findpeaks.jl](https://github.com/tungli/Findpeaks.jl) package.

### Args
- `y`: Input data, specified as a vector. `y` must be real and must have at least three elements.

- `x`: Locations, specified as a vector or a datetime array. `x` must increase monotonically and have the
   same length as `y`. If `x` is omitted, then the indices of `y` are used as locations.

- `D`: Alternatively to `y` and `x` you can provide a `GMTdataset` with two, `x,y` (or more), columns.

### Kwargs
- `min_height`: Minimum peak height, specified as a real scalar. Use this argument to have
   ``findpeaks`` return only those peaks higher than `min_height`. 

- `min_prom`: Minimum peak prominence, specified as a nonnegative real scalar. Use this
   argument to have ``findpeaks`` return only those peaks that have a relative importance of at least
   `min_prom` (see [Prominence](https://www.mathworks.com/help/signal/ref/findpeaks.html#buff2uu)).

- `min_dist`: Minimum peak separation (keeping highest peaks). When you specify a value for this option,
   the algorithm chooses the tallest peak and ignores all peaks within `min_dist` of it.

- `threshold`: Minimal difference (absolute value) between peak and neighboring points. Use this argument to have
   ``findpeaks`` return only those peaks that exceed their immediate neighboring values by at least the value of `threshold`.

### Returns
- `peaks`: A vector of indices of local maxima (sorted from highest peaks to lowest).

### Examples

\begin{examplefig}{}
```julia
using GMT

D = gmtread(TESTSDIR * "assets/example_spectrum.txt");
peaks = findpeaks(D, min_prom=1000.);

plot(D, title="Prominent peaks")
scatter!(D[peaks,:], mc=:red, show=true)
```
\end{examplefig}

\begin{examplefig}{}
```julia
using GMT

D = gmtread(TESTSDIR * "assets/example_spectrum.txt");
peaks = findpeaks(D, min_dist=0.2)

plot(D, title="Peaks at least 0.2 units apart")
scatter!(D[peaks,:], mc=:red, show=true)
```
\end{examplefig}
