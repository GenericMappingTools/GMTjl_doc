# arrows

```julia
arrows(cmd0::String="", arg1=nothing; kwargs...)
```

*keywords: GMT, Julia, arrow plots*

Reads (x,y,a,b) data and make arrow plots. The input can either be a file name of a file with at least
four columns, but optionally more, or an MxN array or GMTdatset object with the same characteristics in
terms of number of columns.

This module is a subset of \myreflink{plot} to make it simpler to draw arrow plots. So not all (fine)
controlling parameters are listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

\textinput{common_opts/opt_pen}

- **arrow**\
   Direction (in degrees counter-clockwise from horizontal) and length must be found in columns 3 and 4,
   and size, if not specified on the command-line, should be present in column 5. The size is the length of
   the vector head. Vector stem width is set by *pen*. By default, a vector head of 0.5 cm is set but see
   \myreflink{Vector Attributes} for overwriting this default and specifying other attributes. Note: when
   columns 3 and 4 the *u,v* components one **must** specify `uv=true` as an `arrows` option. Likewise, if
   they represent the arrows end points then use `endpoint=true` (or `endpt`). The default is also to plot
   arrow heads (with a `shape=0.5`). If no heads are wanted, use `nohead=true`.

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

Examples
--------

Plot a single arrow with head and tail.

\begin{examplefig}{}
```julia
using GMT
arrows([0.0 0 5 5], limits=(0,5,0,5), figsize=10, frame=(annot=:a, grid=1),
       arrow=(start=:tail, stop=true), uv=true, fill=0, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{plot}, \myreflink{lines}, \myreflink{scatter}