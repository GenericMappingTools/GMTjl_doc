# clip

```julia
clip(cmd0::String="", arg1=[]; kwargs...)
```

Initialize or terminate polygonal clip paths

Description
-----------

Reads (x,y) tables (or a file) and draws polygons that are activated as clipping paths.
Several files may be read to create complex paths consisting of several non-connecting segments.
Only marks that are subsequently drawn inside the clipping path will be shown. To determine what
is inside or outside the clipping path, we use the even-odd rule. When a ray drawn from any point,
regardless of direction, crosses the clipping path segments an odd number of times, the point is
inside the clipping path. If the number is even, the point is outside. The **invert** option,
reverses the sense of what is the inside and outside of the paths by plotting a clipping path along
the map boundary. After subsequent plotting, which will be clipped against these paths, the clipping
may be deactivated by running the module a second time with the **endclip** option only.

Required Arguments
------------------
- *table*\
    One or more data tables holding a number of data columns.

- **C** or **endclip** or **end_clip_path** : -- *endclip=true* or *endclip=n*\
    Mark end of existing clip path(s). No input file will be processed. No projection information
    is needed unless \myreflink{frame} has been selected as well. With no arguments we terminate
    all active clipping paths. Experts may restrict the termination to just *n* of the active
    clipping path by passing that as the argument.

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_R_3D}

\textinput{common_opts/opt_Asteps}

\textinput{common_opts/opt_B}

- **N** or **invert** : -- *invert=true*\
    Invert the sense of what is inside and outside. For example, when
    using a single path, this means that only points outside that path
    will be shown. Cannot be used together with \myreflink{frame}.

- **T** or **clip_limits** : -- *clip_limits=*\
    Rather than depending on input data, simply turn on clipping for the
    current map region. Cannot be used together with \myreflink{frame}.

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_pen}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_g}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_t}

\textinput{common_opts/opt_xy}

Examples
--------

To see the effect of a simple clip path which result in some symbols
being partly visible or missing altogether, try:

\begin{examplefig}{}
```julia
using GMT
clip([0 0; 5 1; 5 5], region=(0,6,0,6), figscale=2.5, pen=(1,:blue))
plot("@tut_data.txt", fill=:red, marker=:circ, ms=2)
clip!(endclip=true, frame=:same, show=true)
```
\end{examplefig}

where we activate and deactivate the clip path.  Note we also draw the
outline of the clip path to make it clear what is being clipped.

See Also
--------

\myreflink{basemap}
