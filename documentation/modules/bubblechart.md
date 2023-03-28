# bubblechart

```julia
bubblechart(cmd0::String="", arg1=nothing; size=?, kwargs...)
```

Reads (x,y) pairs and plot *bubbles* at those locations on a map/figure. The input can either be a file
name of a file with at least two columns (x,y), but optionally more, a GMTdatset object with also two
or more columns.

---
bubblechart(x,y,size=?, kwargs...) plots the elements in *y* at the locations specified by *x*. The inputs *x,y*
can be vectors or a vector and a matrix, both with the same number of rows. Bubble sizes are specified by `size`,
which can be a scalar (all bubbles with same size), a two elements array (linear growing from min/max), or a
tuple with a (restricted) function name and a limits two elements array. Ex: `size=(exp10, [2,20])`. If not
provided, it defaults to 5 pt.

---
bubblechart(x,y,size=?,zcolor=?, kwargs...) specifies the colors of the bubbles. You can specify one color for
all the bubbles, or you can vary the color. For example, you can plot all red bubbles by specifying `fill=:red`.
Alternatively, `zcolor` can be an numeric array with same length as `x` and colors are be drawn from the active colormap.

---
bubblechart(D::GMTdatset,yvar,szvar=?, kwargs...) plots the specified variable from the GMTdatset against the
row indices of the table and uses the variable `szvar` (or `svar` or `sizevar`) for the bubble sizes.
To plot one set of y-values, specify one variable for `yvar`. This can take the form of column names or column numbers.
To plot multiple sets of y-values, specify multiple variables for `yvar`. Example `yvar=:Y` or `yvar=(2,3)`, or
`yvar=[:Y, :Z1, :Z2]`. `szvar` selects a column with the bubble sizes, which defaukt to 5 pt if no column is selected.

---
bubblechart(D::GMTdatset,xvar,yvar,szvar=?,cvar=?, kwargs...) plots the specified variables from the dataset using
the colors specified in the variable `cvar` (or `colorvar`) and colors are be drawn from the active colormap.

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.


Optional Arguments
------------------

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt_save_fig}

Examples
--------

A simple bubble plot of 50 bubbles plotted with random sizes.

\begin{examplefig}{}
```julia
using GMT
bubblechart(1:50,rand(50), size=rand(50), fill=:blue, alpha=50, aspect="1:1", show=1)
```
\end{examplefig}

A plot where bubbles's size grows exponentialy between 2 and 40 points.

\begin{examplefig}{}
```julia
using GMT
bubblechart(1:50,rand(50), size=(exp10, [2,40]), fill=:blue, alpha=50, aspect="1:1", show=1)
```
\end{examplefig}
