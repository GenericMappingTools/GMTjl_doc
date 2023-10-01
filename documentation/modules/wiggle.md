# wiggle

```julia
	wiggle(cmd0::String="", arg1=nothing; kwargs...)
```

Plot z = f(x,y) anomalies along tracks

*keywords: GMT, Julia, wiggle plots*

Description
-----------

Reads (*x, y,z*) triplets from file or table and plots z as a function of distance along track. This means
that two consecutive (*x, y*) points define the local distance axis,
and the local *z* axis is then perpendicular to the distance axis,
forming a right-handed coordinate system. The
user may set a preferred positive anomaly plot direction, and if the
positive normal is outside the ±90 degree window around the
preferred direction, then 180 degrees are added to the direction. Either
the positive or the negative wiggle (or both) may be shaded.

Required Arguments
------------------

- *table*\
    One or more data tables holding a number of data columns.

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_R_3D}

- **Z** or **ampscale** or **amp_scale** : -- *ampscale=??*\
    Gives anomaly scale in data-units/distance-unit. Append **c**, **i**, or **p** to indicate
    the distance unit (cm, inch, or point); if no unit is given we use the default unit that
    is controlled by `PROJ_LENGTH_UNIT`.

Optional Arguments
------------------

- **A** **azimuth** : -- *azimuth=az*\
    Sets the preferred positive azimuth. Positive wiggles will "gravitate" towards that direction, i.e., azimuths of the normal direction to the track will be flipped into the -90/+90 degree window centered on *azimuth* and that defines the positive wiggle side. If no azimuth is given the no preferred azimuth is enforced.

\textinput{common_opts/opt_B}

- **C** or **center** : -- *center=??*\
    Subtract *center* from the data set before plotting [0].

- **D** or **scale_bar** : -- *pos=(map=(lon,lat), inside=true, outside=true, norm=(x,y), paper=(x,y), justify=code, offset=XX, anchor=XX, label="the-label", label_left=true)*\
    Defines the reference point on the map for the vertical scale bar using one of four coordinate systems:
    (1) Use **map=true** for map (user) coordinates, (2) use **inside=true** or **outside=true** (the default) for setting **anchor** via a 2-char justification code that refers to the (invisible) map domain rectangle, (3) use **norm=true** for normalized (0-1) coordinates, or (4) use **paper=true** for plot coordinates (inches, cm, etc.). All but **paper=true** requires both **region** and **proj** to be specified.

    Use `width=(width,height)` to set the *length* (and *height*) of the scale bar in data (*z*) units.
    By default, the anchor point on the legend is assumed to be the bottom left corner (:ML), but this
    can be changed by appending `justify` followed by a 2-char justification code *justify* (see \myreflink{text}).
    **Note**: If `inside` is used (the default) then *justify* defaults to the same as `refpoint`,
    if `outside` is used then `justify` defaults to the mirror opposite of `refpoint`.
    Move scale label to the left side with `label_left=true` [Default is to the right of the scale].
    Use `label="The label"` to set the *z* unit label that is used in the scale label [no unit].
    The `FONT_ANNOT_PRIMARY` is used for the font setting, while `MAP_TICK_PEN_PRIMARY`
    is used to draw the scale bar.

\textinput{common_opts/opt_pen}

- **G** or **fill** : -- *fill=fill[+n][+p]*\
    Set fill shade, color or pattern for positive and/or negative wiggles [Default is no fill]. Optionally,
    append **+p** to fill positive areas (this is the default behavior). Append **+n** to fill negative areas.
    Append **+n+p** to fill both positive and negative areas with the same fill. **Note**: You will need to
    repeat this option to select different fills for the positive and negative wiggles, but sie we cannot repeat
    keywords the solution is to pass in a tuple of tuples or of NamedTuples. For simpler cases one can pass also
    a 2 elements vector of strings thet will be used as is, that is, without any further parsing. See example below.

- **I** or **fixed_azim** : *fixed_azim=az*\
    Set a fixed azimuth projection for wiggles [Default uses track azimuth, but see |-A|]. With this option, the calculated track-normal azimuths are overridden by *fixed_az*.

- **T** or **track** : -- *track=pen*\
    Draw track [Default is no track]. Append pen attributes to use
    [Defaults: width = 0.25p, color = black, style = solid].

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

\textinput{common_opts/opt__w}

\textinput{common_opts/opt_xy}

\textinput{common_opts/opt_save_fig}

Examples
--------

To demonstrate a basic wiggle plot we create some synthetic data with
\myreflink{gmtmath} and pipe it through **wiggle**:

\begin{examplefig}{}
```julia
using GMT

x = -8:0.01:6;
y = 0.15 .* x;
z = 50 .* exp.(-((x ./ 3) .^ 2)) .* cos.(2pi .* x) .+ y;
wiggle([x y z], region=(-10,10,-3,3), proj=:Merc, ampscale=100,
       scale_bar=(refpoint=:RM, width=100, label=:nT),
       track=:faint, fill=["red+p", "blue+n"], pen=1, show=1)
```
\end{examplefig}

To plot the magnetic anomaly stored in the file track.xym along track at 500 nTesla/cm
(after removing a mean value of 32000 nTesla), using a 15-cm-wide Polar Stereographic map
ticked every 5 degrees, with positive anomalies in red on a blue track of width 0.25 points, use

```julia
    wiggle("track.xym", region=(-20,10,-80,-60), proj=(name=:stere, center=(0,90)),
           ampscale=500, frame=(annot=5,), center=32000, fill=:red, track=(0.25,:blue),
           scale_bar=(refpoint=:RM, width=100, label=:nT), show=1)
```

and the positive anomalies will in general point in the north direction.
We used **scale_bar** to place a vertical scale bar indicating a 1000 nT anomaly.
To instead enforce a fixed azimuth of 45 for the positive wiggles, we add **fixed_azim**
and obtain

```julia
    wiggle("track.xym", region=(-20,10,-80,-60), proj=(name=:stere, center=(0,90)),
           ampscale=1000, frame=(annot=5,), center=32000, fill=:red, track=(0.25,:blue),
           fixed_azim=45, scale_bar=(refpoint=:RM, width=100, label=:nT), show=1)
```

See Also
--------

\myreflink{filter1d},
\myreflink{psbasemap},
\myreflink{gmtsplit}
