# stem

```julia
stem(cmd0::String="", arg1=nothing; kwargs...)
```

Reads (x,y) pairs and plot the data sequence, *y*, as stems that extend from a baseline along the x-axis.
The data values are indicated by circles terminating each stem. The input can either be a file name of a file with
at least two columns (x,y), but optionally more, a GMTdatset object with also two or more columns, or direct *x,y* inputs

---
stem(x,y, ...) plots the elements in *y* at the locations specified by *x*. The inputs *x,y* can be vectors or
a vector and a matrix, both with the same number of rows.

---
stem(D::GMTdatset, yvar, ...) plots the specified variable from the GMTdatset against the row indices of the table.
To plot one set of y-values, specify one variable for `yvar`. This can take the form of column names or column numbers.
To plot multiple sets of y-values, specify multiple variables for `yvar`. Example `yvar=:Y` or `yvar=(2,3)`, or
`yvar=[:Y, :Z1, :Z2]`.

---
stem(D::GMTdatset,xvar,yvar) plots the variables `xvar` and `yvar` from the table `D`. You can specify one or
multiple variables for `yvar` and one only for `xvar`.

-----------
This module is a subset of `plot` to make it simpler to draw stem plots. So not all (fine) controlling
parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

- **multicol** : -- *multicol=true*\
    Use this option when passing a multicolumn input and and plot a stemplot for each column.

- **nobaseline** : -- *nobaseline=true*\
    If `nobaseline=true` do not paint the horizontal baseline from which the stems start.

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

Create a stem plot of 50 data values between −2π and 2π. 

\begin{examplefig}{}
```julia
using GMT
Y = linspace(-2*pi,2*pi,50);
stem(Y, show=true)
```
\end{examplefig}


The same but now specify the set of x values for the stem plot. 

\begin{examplefig}{}
```julia
using GMT
Y = linspace(-2*pi,2*pi,50);
stem([Y Y], show=true)
```
\end{examplefig}


Two of them and with some variations.

\begin{examplefig}{}
```julia
using GMT
Y = linspace(-2*pi,2*pi,50);
stem(Y,[Y -Y], multicol=true, fill=true, ms="10p", nobaseline=true, ls=:DashDot, show=true)
```
\end{examplefig}