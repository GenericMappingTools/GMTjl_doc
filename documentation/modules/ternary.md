# ternary

```julia
ternary(cmd0::String="", arg1=[]; kwargs...)
```

*keywords: GMT, Julia, ternary plots*

Plot data on ternary diagrams

Description
-----------

Reads (*a*, *b*, *c* [, *z*]) records from *table* and plots symbols at those locations on a
ternary diagram. If a symbol is selected and no symbol size given, then we will interpret the
fourth column of the input data as symbol size. Symbols whose *size* is <= 0 are skipped.
If no symbols are specified then the symbol code (see **marker** below) must be present as
last column in the input. If **marker** is not specified then we instead plot lines or polygons.

Parameters
----------

- **B** or **axes** or **frame** : -- *frame=??*\
    For ternary diagrams the three sides are referred to as a, b, and c. Thus, to give specific
    settings for one of these axis you must include the axis letter before the arguments. If all
    axes have the same arguments then only give one option without the axis letter. For more details,
    see the example at the bottom of this page and the general \myreflink{frame} docs.

- **C** or **color** or **cmap** : -- *color=cpt*\
    Give a CPT or specify **color="color1,color2 [,color3 ,...]"** or **color=((r1,g1,b1),(r2,g2,b2),...)**
    to build a linear continuous CPT from those colors automatically, where *z* starts at 0 and is incremented
    by one for each color. In this case *color_n* can be a [r g b] triplet, a color name, or an HTML
    hexadecimal color (e.g. #aabbcc). If **symbol** is set, let symbol fill color be determined by
    the z-value in the fourth column. Additional fields are shifted over by one column (optional size
    would be 5th rather than 4th field, etc.).

\textinput{common_opts/opt_mfc}

- **J** or **proj** or **projection** : -- *proj=width*\
    The only valid projection is linear plot with specified ternary width.
    Use a negative *width* to indicate that positive axes directions be clock-wise
    [Default lets the *a, b, c* axes be positive in a counter-clockwise direction].

- **L** or **vertex_labels** : -- *vertex_labels="Lab1/lab2/Lab3"* **|** *vertex_labels=("Lab1", "lab2", "Lab3")*\
    Set the labels for the three diagram vertices where the component is 100% [none].
    These are placed a distance of three times the `MAP_LABEL_OFFSET`
    setting from their respective corners. To skip any one of then, specify that label as "-".

- **M** or **dump** : -- *dump=true*\
    Do no plot. Instead, convert the input (*a*, *b*, *c* [, *z*]) records
    to Cartesian (*x*, *y*, [, *z*]) records, where *x, y* are normalized coordinates
    on the triangle (i.e., 0–1 in *x* and 0–sqrt(3)/2 in *y*).

- **N** or **noclip** or **no\_clip** : *noclip=true*\
    Do NOT clip symbols that fall outside map border [Default plots points
    whose coordinates are strictly inside the map border only].

\textinput{common_opts/opt_R}

- **S** or **marker** or **symbol** : -- *symbol=(symb=name, size=val, unit=unity)* or *marker|Marker|shape=name*, *markersize|MarkerSize|ms|size=val*\
    Plot individual symbols in a ternary diagram. If **marker** is not given then we will instead
    plot lines (requires **markerline**) or polygons (requires **cmap** or **fill**). For details on symbols
    see the **symbol** option in \myreflink{plot}

Other than the above options, the `kwargs` input accepts still the following options:

- **image** : -- *image=true*\
    Fills the ternary plot with an image computed automatically with \myreflink{grdimage} from a grid
    interpolated with \myreflink{surface}

- **contour** : -- *contour=??*\
    This option works in two different ways. If used together with `image` it overlays a contour
    by doing a call to \myreflink{grdcontour}. However, if used alone it will call `contour` to do the contours.
    The difference is important because this option can be used in *default mode* with `contour=true`
    where the number and annotated contours is picked automatically, or the use can exert full control
    by passing as argument a NamedTuple with all options appropriated to that module. *e.g.*
    `contour=(cont=10, annot=20, pen=0.5)`

- **contourf** : -- *contourf=??*\
    Works a bit like the _standalone_ `contour`. If used with `contourf=true` call make a filled contour
    using automatic parameters. The form `contourf=(...)` let us selects options of the \myreflink{contourf} module.

- **clockwise** : -- *clockwise=true*\`
    Set it to `true` to indicate that positive axes directions be clock-wise
    [Default lets the a, b, c axes be positive in a counter-clockwise direction].

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

\textinput{common_opts/opt_q}

\textinput{common_opts/opt_s}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

Examples
--------

To plot circles (diameter = 0.1 cm) on a 6-inch-wide ternary diagram at the positions listed
in the file ternary.txt, with default annotations and gridline spacings, using the
specified labeling, try

\begin{examplefig}{}
```julia
using GMT

makecpt(cmap=:turbo, range=(0,80,10))
ternary("@ternary.txt", region=(0,100,0,100,0,100), marker=:circ, ms=0.1, vertex_labels="Water/Air/Limestone",
    frame=(annot=:auto, grid=:a, ticks=:a, alabel="Water component", blabel="Air component", clabel="Limestone component", suffix=" %", fill=:ivory, title="Example data from MATLAB Central"), show=true)
```
\end{examplefig}

See other examples at [Ternary plots](https://www.generic-mapping-tools.org/GMTjl_doc/examples/ternary/)

See Also
--------

\myreflink{plot}
