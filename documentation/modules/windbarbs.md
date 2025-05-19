# windbarbs

```julia
windbarbs(u, v; kwargs...)
```

Plot wind barb field from two component grids with the *x* and *y* components of the wind field.

---
or

```julia
windbarbs(arg1; kwargs...)
```

Plot wind barb field from a data table with the *x* and *y* components of the wind field.

Description
-----------

Read two 2-D grid files which represents the *x*- and *y*-components of a wind field and produces
a wind field plot by drawing wind barbs with orientation and barbs according to the information in
the files. Alternatively, polar coordinate *r*, *theta* grids may be given instead. Alternatively,
a data table with the *x* and *y* components of the wind field may be given.

Required Arguments
------------------

- *compx* Contains the x-components of the wind field.

- *compy* Contains the y-components of the wind field.


Optional Arguments
------------------

- **A** or **polar** : -- *polar=true*\
    The grid files contain polar (r, theta) components instead of Cartesian (x, y) [Default is Cartesian components].
    This option is valid only when the input files are 2-D grids.

\textinput{common_opts/opt_B}

\textinput{common_opts/use_cpt_grd}

- **G** or **fill** : -- *fill=fill*\
    Sets color or shade for wind barb interiors (see \myreflink{Fill color/pattern}) [Default is no fill].

- **I** or **inc** or **increment** or **spacing** : -- *inc=x_inc* **|** *inc=(x_inc, y_inc)* **|** *inc="x""multx"["/multy"]*\
    Only plot wind barbs at nodes every *x\_inc*, *y\_inc* apart (must be multiples of original grid spacing).
    Append **m** for arc minutes or **s** for arc seconds. Alternatively, use **inc="x"** to specify the
    multiples *multx*[/*multy*] directly [Default plots every node]. Example **inc="x10/5"** to select every other
    10 nodes in *x* and 5 nodes in *y*. **_NOTE_**: by default we estimate good values so that the arrows do no
    overlap so you may start by jumping this option unless some fine control is desired.

\textinput{common_opts/opt_J}

- **N** or **noclip** or **no\_clip** : *noclip=true*\
    Do NOT clip wind barbs at map boundaries [Default will clip].

- **Q** or **barbs** : -- *barbs=(length=length, angle=angle, fill=fill, pen=pen, justify="b|e|c", speed=speed, width=width)*\
    Modify wind barb parameters. Append wind barb *length* [Default is 0.5c]. Several modifiers may be
    appended to specify the placement of barbs, their shapes, and the justification of the wind barb.
    Below, left and right refers to the side of the wind barb line when viewed from the start point to
    the end point of the segment. Chose among these modifiers:

    - **angle** - Set the angle of the wind barb [120].
    - **fill** - Turn off *fill* (if -) or set the wind barb fill [Default fill is used, which may be no fill].
    - **pen** - Sets the wind barb pen attributes. If *pen* has a leading **-** then the outline is not drawn
       [Default pen is used, and outline is drawn].
    - **justify** - Determines how the input *x*, *y* point relates to the wind barb. Choose from **b**eginning
       [default], **e**nd, or **c**enter.
    - **speed** - Set the wind speed which corresponds to a long barb [default 5].
    - **width** - Set the *width* of wind barbs.
 
\textinput{common_opts/opt_R}

- **T** or **sign_scale** : -- *sign_scale=true*\
    Means the azimuths of Cartesian data sets should be adjusted according to the
    signs of the scales in the x- and y-directions [Leave alone]. This option can
    be used to convert vector azimuths in cases when a negative scale is used in
    one of both directions (e.g., positive down).

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_pen}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

- **Z** or **azimuth** : -- *azimuth=true*\
    The theta grid provided contains azimuths rather than directions (implies `polar=true`).
    This option is valid only when the input files are 2-D grids.

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

Examples
--------

To draw the wind field given by the files ``r.nc`` and ``theta.nc`` on a
barb plot with 0.25 cm length and centered on the node locations, run:

```julia
windbarb("r.nc", "theta.nc", polar=true, barbs=(len=0.25, justify=:c), show=true)
```

To plot a geographic data sets given the files comp_x.nc and comp_y.nc,
and only plot every 3rd node in either direction, try:

```julia
windbarb("comp_x.nc", "comp_y.nc", inc="x3", proj=:guess, barbs=(len=0.25, justify=:c), show=true)
```

\begin{examplefig}{}
```julia
using GMT

ecmwf(:forecast, var=["10u", "10v"], R="IHO23", prefix="vel")
windbarbs("vel_10u.grd", "vel_10v.grd", barbs=(length=0.25, width=0.15),
          inc="x10", coast=true, proj=:guess, show=true)
```
\end{examplefig}

See Also
--------

\myreflink{grdcontour}, \myreflink{grdvector}
