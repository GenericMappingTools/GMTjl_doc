# vlines

```julia
vlines(arg; decorated=(...), xmin=NaN, xmax=NaN, percent=false, kwargs...)
```

Plots one or a collection of vertical lines with eventual decorations

- `ymin` & `ymax`: Limit the vertical lines to start a `ymin` and/or end at `ymax`

- `percent`: If true the `xmin` & `xmax` are interpreted as fractions of the figure width.

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

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

plot(rand(5,3), region=[0,1,0,1])
vlines!([0.2, 0.6], pen=(1, :red), show=true)
```
\end{examplefig}

See Also
--------

\myreflink{hlines}, \myreflink{plot}
