# parallelplot

```julia
parallelplot(cmd0::String="", arg1=nothing; labels|axeslabels=String[], group=Vector{String},
             groupvar="", normalize="range", kwargs...)
```

*keywords: GMT, Julia, statistical plots*

Creates a parallel coordinates plot from the table (Matrix or \myreflink{GMTdataset}). Each line in the plot
represents a row in the table, and each coordinate variable in the plot corresponds to a column in the table.
By default, table columns are plotted.

---
parallelplot(D,y, ...) plots the elements in *y* at the locations specified by *x*. The inputs *x,y* can be vectors or
a vector and a matrix, both with the same number of rows.

---
parallelplot(D::GMTdatset, yvar, ...) plots the specified variable from the GMTdatset against the row indices of the table.
To plot one set of y-values, specify one variable for `yvar`. This can take the form of column names or column numbers.
To plot multiple sets of y-values, specify multiple variables for `yvar`. Example `yvar=:Y` or `yvar=(2,3)`, or
`yvar=[:Y, :Z1, :Z2]`.

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

- **axeslabels** or **labels** : -- *axeslabels=["??","??",...]* **|** *labels=["??","??",...]*\
   String vector with the names of each variable axis. Plots a default "Label?" if not provided..

- **group** : -- *group=["??","??",...]* **|** *group=Int(...)*\
   A string vector or vector of integers used to group the lines in the plot.

- **groupvar** : -- *groupvar="text* **|** *groupvar=Int* **|** *groupvar=:ColName*\
   Uses the table variable specified by `groupvar` to group the lines in the plot. `groupvar` can
   be a column number, or a column name passed in as a Symbol. *e.g.* `groupvar=:Male` if a column with that
   name exists.  When `arg1` is GMTdatset or `cmd0` is the name of a file with one and it has the `text` field
   filled, use `groupvar="text"` to use that text field as the grouping vector.

- **nomalize** : -- *nomalize="range"* **|** *nomalize="none"* **|** *nomalize="score"* **|** *nomalize="scale"*\
    - `range`: (Default) Display raw data along coordinate rulers that have independent minimum and maximum limits.
    - `none` or `""`: Display raw data along coordinate rulers that have the same minimum and maximum limits.
    - `zscore`: Display z-scores (with a mean of 0 and a standard deviation of 1) along each coordinate ruler.
    - `scale`: Display values scaled by standard deviation along each coordinate ruler.

- **quantile** : -- *quantile=0.25*\
    Give a quantile in the [0-1] interval to plot the median +- `quantile` as dashed lines.

- **std** : -- *std=1*\
    Instead of median plus quantile lines, draw the mean +- one standard deviation. This is achieved with both
    `std=true` or `std=1`. For other number od standard deviations use, *e.g.* `std=2`, or `std=1.5`.

- **band** : -- *band=true*\
    If used, instead of the dashed lines referred above, plot a band centered in the median. The band
    colors are assigned automatically but this can be overriden by the `fill` option. If set and `quantile`
    not given, set a default of `quantile = 0.25`.

- **fill** : -- *fill=true* **|** fill=["color1", "color2", ...]*\ 
    When `band` option is used and want to control the bands colors, give a list of colors to paint them.

- **fillalpha** : -- *fillalpha=[0.5, 0.7, ...]*\
    When `fill` option is used, we can set the bands transparency with this option that takes in an array
    (vec or 1-row matrix) with numeric values between [0-1] or ]1-100], where 100 (or 1) means full transparency.

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

Create a parallel plot using the measurement data in `iris.dat`. Use a different color for each group as
identified in species, and label the horizontal axis using the variable names.

\begin{examplefig}{}
```julia
using GMT
parallelplot(getpath4docs("iris.dat"), groupvar="text", normalize="none", legend=true, show=true)
```
\end{examplefig}

Plot only the median, 25 percent, and 75 percent quartile values for each group identified in species.
Label the horizontal axis using the variable names.

\begin{examplefig}{}
```julia
using GMT
parallelplot(getpath4docs("iris.dat"), groupvar="text", quantile=0.25, legend=true, show=true)
```
\end{examplefig}

Plot bands enveloping the +- 25% percentil arround the median.

\begin{examplefig}{}
```julia
using GMT
parallelplot(getpath4docs("iris.dat"), groupvar="text", band=true, legend=true, show=true)
```
\end{examplefig}
