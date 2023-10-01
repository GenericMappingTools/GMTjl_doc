# stairs

```julia
stairs(cmd0::String="", arg1=nothing; step=:post, kwargs...)
```

*keywords: GMT, Julia, stair plots*

Reads (x,y) pairs and plot stairstep graph. The input can either be a file name of a file with at least two columns
(x,y), but optionally more, a GMTdatset object with also two or more columns, or direct *x,y* inputs

---
stairs(x,y, ...) plots the elements in *y* at the locations specified by *x*. The inputs *x,y* can be vectors or
a vector and a matrix, both with the same number of rows.

---
stairs(D::GMTdatset, yvar, ...) plots the specified variable from the GMTdatset against the row indices of the table.
To plot one set of y-values, specify one variable for `yvar`. This can take the form of column names or column numbers.
To plot multiple sets of y-values, specify multiple variables for `yvar`. Example `yvar=:Y` or `yvar=(2,3)`, or
`yvar=[:Y, :Z1, :Z2]`.

---
stairs(D::GMTdatset,xvar,yvar) plots the variables `xvar` and `yvar` from the table `D`. You can specify one or
multiple variables for `yvar` and one only for `xvar`.

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

- **step** : -- *step=:post* **|** *step=:pre*\
   With **step=:post**, the default, lines move first along *x* for cartesian plots or the parallels for geographic
   and then along *y* or the meridians. **step=:pre** (or whatever != *:post*), lines move first along *y* for
   cartesian plots or the meridians for geographic and then along *x* or the parallels.

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

Create a stairs plot of sine evaluated at 50 equally spaced values between 0 and 4π. 

\begin{examplefig}{}
```julia
using GMT
x = linspace(0, 4*pi, 50);
stairs(x, sin.(x), show=true)
```
\end{examplefig}

Create a stairs plot of sine and a cosine evaluated at same points as above and add a circle marker
at the points location. Note that now we are selectiong the columns from teir names in the `D` *GMTdataset*.

\begin{examplefig}{}
```julia
using GMT
# Create a GMTdataset with named columns.
x = linspace(0, 4*pi, 50);
D = mat2ds([x sin.(x) cos.(x)], colnames=["x", "sin(x)", "cos(x)"]);
stairs(D, xvar=:x, yvar=["sin(x)", "cos(x)"], lw=0.5, marker=:circ, show=true)
```
\end{examplefig}