# ecdfplot

```julia
ecdfplot(x::AbstractVector{AbstractFloat}, y::AbstractVector{AbstractFloat}; kwargs...)
```

ecdfplot(x, ...) plot the empirical cumulative distribution function (ECDF) of `x`.

*keywords: GMT, Julia, statistical plots*

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.


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
ecdfplot(randn(100), show=true)
```
\end{examplefig}
