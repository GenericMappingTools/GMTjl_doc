# cornerplot

```julia
cornerplot(data; kwargs...)
```

Takes a nSamples-by-nDimensions array, and makes density plots of every combination of the dimensions.
Plots as a triangular matrix of subplots showing the correlation among input variables. Input `data`
can be a MxN matrix, a `GMTdataset` or a file name that upon reading with `gmtread` returns a `GMTdataset`.

The plot consists of histograms of each column along the diagonal and scatter or hexagonal bining plots
for the inter-variable relations, depending on if the the number of samples is <= 1000. But this can be
changed with options in `kwargs`.

---
`cornerplot(data)` plots every 2D projection of a multidimensional data set. 

---
`cornerplot(..., varnames)` prints the names of each dimension. `varnames` is a vector of strings
of length nDimensions. If not provided, column names in the `GMTdaset` are used.

---
`cornerplot(..., truths)` indicates reference values on the plots. Note that `truths` **must** be a
vector of length *n dimensions*, that is, number of columns in input data.

---
`cornerplot(..., quantile)` list of fractional quantiles to show on the 1-D histograms as vertical dashed lines.

---
`marginalhist(..., hexbin=true)` Force hexbin plots even when number of points <= 1000. Default hexagon sizes
are set via an heuristic rule but can be explicitly set via \myreflink{binstats} options, Namely `inc`
or `nbins` options.

---
`cornerplot(..., scatter=true)` Force scatter plots even when number of points > 1000.

---
`cornerplot(..., histcolor|histfill=color)` To paint diagonal histograms with a selected color (histcolor=:none to no paint).

---
`cornerplot(...,xvar,yvar)` plots the variables `xvar` and `yvar` from the table `D`. You can specify one or
multiple variables for `yvar` and one only for `xvar`.

Several other options can be used through `kwargs` to control plot details. Namelly options to fine control
the subplots sizes and that are passed to \myreflink{subplot}. Options to control the number of bins, and thresholds
on countings, passed to \myreflink{binstats}. Or options to change markers, marker size and or color, colormap, etc,
passed to \myreflink{plot}. See examples bellow.


Common options
--------------

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

Examples
--------

Create a cornerplot plot with hexagonal bins, setting the color map, the vriable names, plot *truth* and title.

\begin{examplefig}{}
```julia
using GMT
cornerplot(randn(4000,3), cmap=:viridis, truths=[0.25, 0.5, 0.75],
           varnames=["Ai", "Oi", "Ui"], title="Corner plot", show=true)
```
\end{examplefig}

Example on how to control the symbol types, size and color.

\begin{examplefig}{}
```julia
using GMT
cornerplot(randn(1500,3), scatter=true, marker=:cross, mec=:red, ms="3p", show=true)
```
\end{examplefig}


See Also
--------

\myreflink{binstats}, \myreflink{histogram}, \myreflink{marginalhist}, \myreflink{plot}