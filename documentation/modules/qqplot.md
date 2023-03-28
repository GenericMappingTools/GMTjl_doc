# qqplot

```julia
qqplot(x::AbstractVector{AbstractFloat}, y::AbstractVector{AbstractFloat}; kwargs...)
```

The `qqplot` function compares the quantiles of two distributions. The `qqnorm` is a shorthand for comparing a
distribution to the normal distribution. If the distributions are similar the points will be on a straight line.

---
qqplot(x,y, ...) displays a quantile-quantile plot of the quantiles of the sample data x versus the quantiles
of the sample data y. If the samples come from the same distribution, then the plot appears linear.

---
qqplot(x, ...) displays a quantile-quantile plot of the quantiles of the sample data x versus the theoretical
quantile values from a normal distribution. If the distribution of x is normal, then the data plot appears linear.
A common used alias to this form is the `qqnorm` function.

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

- **qqline** : -- Determines how to compute a fit line for the Q-Q plot. The options are\
    - `identity`: draw the line y = x (the deafult).
    - `fit`: draw a least squares line fit of the quantile pairs.
    - `fitrobust ` or `quantile`: draw the line that passes through the first and third quartiles of the distributions.
    - `none`: do not draw any line.

	Broadly speaking, `qqline=:identity` is useful to see if x and y follow the same distribution, whereas `qqline=:fit` and `qqline=:fitrobust` are useful to see if the distribution of y can be obtained from the distribution of x via an affine transformation.

- For fine the lines settings use the same options as in the \myreflink{plot} module. Nemely `lw` or `lt` for
    controling the line thickness, `lc` for line color, `ls` for line styles, etc...

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

\textinput{common_opts/opt_pen}

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

Examples
--------

\begin{examplefig}{}
```julia
using GMT
qqplot(randn(100), randn(100), show=true)
```
\end{examplefig}


\begin{examplefig}{}
```julia
using GMT
qqplot(randn(100), show=true)
```
\end{examplefig}
