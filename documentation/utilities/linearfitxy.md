# linearfitxy

```julia
linearfitxy(X, Y; σX=0, σY=0, r=0, ci=95)
```

*keywords: GMT, Julia, liner fit, statistical plots*

Performs 1D linear fitting of experimental data with uncertainties in  X and Y:
- Linear fit:             `Y = a + b*X`                               [1]
- Errors:                 ``X ± σX;  Y ± σY``                         [2]
- Errors' correlation:    ``r =  = cov(σX, σY) / (σX * σY)``          [3]

# Arguments:
- `X` and `Y` are input data vectors with length ≥ 3

- Optional standard deviation errors ``σX`` and ``σY`` are vectors or scalars

- Optional `r` is the correlation between the ``σX`` and ``σY`` errors. `r` can be a vector or scalar

- `ci` is the confidence interval for the statistics. By default it's 95% but any integer number > 0 < 100 will do.

``σX`` and ``σY`` errors (error ellipses) with bivariate Gaussian distribution assumed.
If no errors, or if only ``σX`` or ``σY`` are provided, then the results are equivalent
to those from the [LsqFit.jl](https://github.com/JuliaNLSolvers/LsqFit.jl) package.

Based on York et al. (2004) with extensions (confidence intervals, diluted corr. coeff.).


The results are added as new columns of a GMTdataset structure when they are vectors (`σX σY r`)
and stored as attributes when they are scalars (`a`, `b`, `σa`, `σb`, `σa95`, `σb95`, `ρ` and `S`):

- The intercept `a`, the slope `b` and their uncertainties `σa` and `σb`

- ``σa95`` and ``σb95``: 95%-confidence interval using two-tailed t-Student distribution,
    e.g.: ``b ± σb95 = b ± t(0.975,N-2)*σb``

- Goodness of fit `S` (reduced ``Χ²`` test): quantity with ``Χ²`` N-2 degrees of freedom
  `S ~ 1`: fit consistent with errors, `S > 1`: poor fit, `S >> 1`: errors underestimated,
  `S < 1`: overfitting or errors overestimated

- Pearson's correlation coefficient ``ρ`` that accounts for data errors

For more information and references see the [LinearFitXYerrors.jl](https://github.com/rafael-guerra-www/LinearFitXYerrors.jl)
package, from which this function is derived. 


Examples
--------

```julia-repl
D = linearfitxy(X, Y)    # no errors in X and Y, no plot displayed

D = linearfitxy(X, Y; σX, σY) # XY errors not correlated (r=0);

D = linearfitxy([91., 104, 107, 107, 106, 100, 92, 92, 105, 108], [9.8, 7.4, 7.9, 8.3, 8.3, 9.0, 9.7, 8.8, 7.6, 6.9]);

D = linearfitxy([0.0, 0.9, 1.8, 2.6, 3.3, 4.4, 5.2, 6.1, 6.5, 7.4], [5.9, 5.4, 4.4, 4.6, 3.5, 3.7, 2.8, 2.8, 2.4, 1.5], sx=1 ./ sqrt.([1000., 1000, 500, 800, 200, 80,  60, 20, 1.8, 1]), sy=1 ./ sqrt.([1., 1.8, 4, 8, 20, 20, 70, 70, 100, 500]));

D = linearfitxy([0.037 0.0080; 0.035 0.0084; 0.032 0.0100; 0.040 0.0085; 0.013 0.0270; 0.038 0.0071; 0.042 0.0043; 0.030 0.0160], sx=0.03, sy=0.1, r=0.7071);
```

See Also
--------

\myreflink{plotlinefit}, \myreflink{plot}
