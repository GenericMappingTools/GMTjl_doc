# radar

```julia
radar(cmd0="", arg1=nothing; axeslimts=Float64[], annotall=false, axeslabels=String[], kwargs...)
```

Radar plots are a useful way for seeing which variables have similar values or if there are outliers
amongst each variable. By default we expect a matrix, or a GMTdatset (or a vector of them) with normalized
values. This is so because a radar plot has multiple axis that each have different limits. So the options are
to pass normalized variables or set each axis limits via the `axeslimts` option.

---
radar(A, ...) plots the elements in the rows of `A` if it is a mtrix creating a polygon per row, or just one
polygon if `A` is a vector.

-----------
This module is a subset of `plot` to make it simpler to draw stair plots. So not all (fine)
controlling parameters are not listed here. For the finest control, user should consult the \myreflink{plot} module.

Parameters
----------

- **axeslabels** or **labels** : -- *axeslabels=["??","??",...]* **|** *labels=["??","??",...]*\
   String vector with the names of each variable axis. Plot a default "Label?" if not provided..

- **axeslimts** : -- *axeslimts=[...]*\
   A vector with the same size as columns in the input matrix with the max extent of each variable.
   NOTE that if you don't provide this option we assume input data is normalized.

- **annotall** : -- *annotall=true*\
    By default only the first axis is annotated, which is all it needs when variables are normalized.
    However, when using non-normalized variables it may be useful to show the limits of each axis.

By default the polygons are not filled but that is often not so nice. To fill with the default cyclic color
use just `fill=true`. Other options are to use:

- **fill** or **fillcolor** : -- *fill=true* **|** fill=["color1", "color2", ...]*\ 
    A string vector with polygon colors. If number of colors is less then number of polygons we cycle through
    the number of provided colors.

- **fillalpha** : -- *fillalpha=[0.5, 0.7, ...]*\
    The default is to paint polygons with a transparency of 70%. For other transparency values pass in a
    vector of transparencies (between [0-1] or ]1-100]) via this option.

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

Create a 

\begin{examplefig}{}
```julia
using GMT
radar([0.5 0.5 0.6 0.9 0.77; 0.6 0.5 0.8 0.2 0.9], show=true, marker=:circ, fill=true)
```
\end{examplefig}

Plot 

\begin{examplefig}{}
```julia
using GMT
radar([10.5 20.5 30.6 40.9 46], axeslimts=[15, 25, 50, 90, 50], annotall=true, marker=:circ, fill=true, 
      labels=["Spoons","Forks","Knifes","Dishes","Oranges"], show=1)
```
\end{examplefig}