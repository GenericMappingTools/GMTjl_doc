# feather

```julia
feather(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, arrow plots*

Plot arrows originating from the x-axis. Specify the direction of arrows using the Cartesian components
*U* and *V* or polar *theta,r*. The input can either be a file name of a file with at least two columns (u,v),
but preferably three, a GMTdatset object with also two or more columns, or direct *u,v* inputs. In case data
has only two columns the arrows are plotted in fuction of the number of points. If *xx* axis is time, provide
the data as *time u v* or *time theta r*.

---
feather(u,v, ...) plots the arrows in function of number of data points.

---
feather(x,u,v, ...) plots the arrows at the *x* coordinates. *x* may be a time column.

---
feather(D::GMTdatset, yvar, ...) plots the specified variables from the GMTdatset against the row indices of the table.
To select the two columns that make up the arrows, specify them via the variable `yvar`. This can take the form of
column names or column numbers. Example `yvar=[:Y1, :Y2]` or `yvar=(2,3)`.

---
feather(D::GMTdatset,xvar,yvar) plots the variables `xvar` and `yvar` from the table `D`. You can specify one or
multiple variables for `yvar` and one only for `xvar`.

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

- **arrow** : -- *arrow=(...)*\
    Control the arrow attributes, see \myreflink{Vector Attributes}

- **rtheta** : -- *rtheta=true*\
   Means the arrow components are given as azimuth and module (default is U,V).

- **endpt** or **endpoint** : -- *endpt=true*\
   Means the arrow components are given as *xx* and *yy* (default is U,V).

- **nohead** : -- *nohead=true*\
   Draw only the stick and drop the arrow head.

- For fine the lines settings use the same options as in the \myreflink{plot} module. Nemely `lw` or `lt` for
   controlling the line thickness, `lc` for line color, `ls` for line styles, etc...

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

Create a feather plot by specifying the components of each arrow as Cartesian values.. 

\begin{examplefig}{}
```julia
using GMT
uv= [0.0 0 2.0; 0.0 30 2; 0.0 60 2; 0.0 90 2; 0.0 120 2; 0.0 150 2; 0.0 180 2; 0.0 210 2; 0.0 240 2; 0.0 270 2; 0.0 300 2; 0.0 330 2; 0.0 360 2];
feather(uv, rtheta=true, aspect="1:1", arrow=(len=0.5, shape=0.5,), lw=0.5, fill=:green, show=true)
```
\end{examplefig}

With simple arrows and in function of number of arrows.

\begin{examplefig}{}
```julia
using GMT
t = -pi/2:pi/8:pi/2; u = 10*sin.(t); v = 10*cos.(t);
feather(u,v, show=true)
```
\end{examplefig}

Show the data used in this example.

```julia:./code/ex1
using GMT, PrettyTables   # hide
getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
io = IOBuffer() # hide
D = gmtread(getpath4docs("wind_faro_s.dat"))
pretty_table(io, D.data; header=D.colnames, backend=Val(:html))	# hide
println("~~~" * String(take!(io)) * "~~~") # hide
```

\textoutput{./code/ex1}

Create a winbarb plot. Note that since the data has 4 columns we must select the 3 that we want to use
in the plot. We select the columns from teir names in the `D` *GMTdataset*.

\begin{examplefig}{}
```julia
using GMT
GMT.resetGMT()  # hide
feather(getpath4docs("wind_faro.dat"), xvar=:Time, yvar=[:azimuth, :vmean], rtheta=true, nohead=1, lw=0.1, show=true)
```
\end{examplefig}