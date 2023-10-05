# fill_between

```julia
fill_between(D1 [,D2]; kwargs...)
```

*keywords: GMT, Julia, area fill plots*

Fill the area between two horizontal curves.

The curves are defined by the points (x, y1, y2) in matrix or GMTdataset `D1`. This creates one or
multiple polygons describing the filled area. Alternatively, give a second matrix, `D2` (or a scalar y=cte)
and the polygons are constructed from the intersections of curves `D1` and `D2`. The `D1` arg can
also be a file name of a file that can be read with \myreflink{gmtread} and return a \myreflink{GMTdataset}
Note: `D1` and `D2` do **not** need to have the same number of points but they should have the same *xx*
limits (or close), otherwise results my look weird.

-----
`fill_between(D1)` Plots two curves *x,y1,y2* and fills the areas bwtween the two curves. 

-----
`fill_between(..., fill=colors)` Give a list with two colors to paint the 'up' and 'down' polygons.
Example, `fill=(:yellow, :brown)`

-----
`fill_between(..., fillalpha=[alpha1,alpha2])`: Sets the transparency of the two sets of polygons (default 60%).
`alpha1` and `alpha2` are numbers between [0-1] or [0-100], where 1 or 100 mean full transparency.

-----
`fill_between(..., pen=...)`: Sets pen specifications for the two curves. Easiest is to use the shortcuts
   `lt`, `lc` and `ls` for the line thickness, color and style like it is used in the \myreflink{plot} module.

-----
`fill_between(..., markers=true)` Add marker points at the data locations. These markers will have the
same color as the line they sit on.

-----
`fill_between(..., stairs=true)` Plot stairs curves instead.

-----
`fill_between(..., white=true)`: Draw a thin white border between the curves and the fills.

-----
`fill_between(..., labels=...)` Pass labels to use in a legend.
   - `labels=true` wil use the column names in `D1` and `D2`. 
   - `labels="Lab1,Lab2"` or `labels=["Lab1","Lab2"]` (this one can be a Tuple too) use the text in `Lab1`, `Lab2`.

-----
`fill_between(..., legend=...)`: If used as the above `labels` it behaves like wise, but its argument can
also be a named tuple with `legend=(labels="Lab1,Lab2", position=poscode, box=(...))`, where `poscode`
is the same as used in \myreflink{text}, *e.g.* `TL` means *TopLeft* and `box` controls the legend box details.
See [examples at](https://www.generic-mapping-tools.org/GMTjl_doc/examples/legends/01_legends)

-----
`fill_between(...,xvar,yvar)` plots the variables `xvar` and `yvar` from the table `D1`. You can specify one or
multiple variables for `yvar` and one only for `xvar`.


Common options
--------------

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

Examples
--------

See the intersections of two *sinc* curves.

\begin{examplefig}{}
```julia
using GMT
theta = linspace(-2π, 2π, 150);
y1 = sin.(theta) ./ theta;
y2 = sin.(2*theta) ./ theta;
fill_between([theta y1 y2], legend="Sinc1,Sinc2", show=true)
```
\end{examplefig}

Control the legend position.

\begin{examplefig}{}
```julia
using GMT
theta = linspace(-2π, 2π, 150);
y1 = sin.(theta) ./ theta;
y2 = sin.(2*theta) ./ theta;
fill_between([theta y1], [theta y2], fill=("lightblue",:orange), white=true,
             legend=(labels="Sinc1,Sinc2", pos=:TL, box=:none), show=true)
```
\end{examplefig}

Use a constant *y* for the second curve.

\begin{examplefig}{}
```julia
using GMT
theta = linspace(-2π, 2π, 150);
y2 = sin.(2*theta) ./ theta;
fill_between([theta y2], 0.0, white=true, lt=1, ls=:dash, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{plot}