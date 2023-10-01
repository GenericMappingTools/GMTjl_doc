# lines

```julia
lines(cmd0::String="", arg1=[]; kwargs...)
```

*keywords: GMT, Julia, line plots, mapping*

Reads (x,y) pairs and plot lines with different levels of decoration. The input can either be a file
name of a file with at least two columns (x,y), but optionally more, a GMTdatset object with also two
or more columns.

This module plots a large variety of lines and polygons. It goes from *simple* lines and polygons
(color/pattern filled or not) to the so called *decorated* lines. That is, lines decorated with
symbols and text patterns.

This module is a subset of `plot` to make it simpler to draw line plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

\textinput{common_opts/opt_pen}

- **decorated**\
   For all types of line decorations: symbols \myreflink{Decorated lines}, fronts \myreflink{Front lines},
   text \myreflink{Quoted lines}, etc... see \myreflink{Line decorations}

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

Examples
--------

Decorated curve with blue stars

\begin{examplefig}{}
```julia
using GMT
xy = gmt("gmtmath -T0/180/1 T SIND 4.5 ADD");
lines(xy, axes=:af, pen=(1,:red), decorated=(dist=(2.5,0.25), marker=:star,
      ms=1, pen=(0.5,:green), fill=:blue, dec2=true), aspect="4:2", show=true)
```
\end{examplefig}
