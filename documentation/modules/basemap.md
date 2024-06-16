# basemap

```julia
basemap(; kwargs...)
```

Plot base maps and frames

Description
-----------

Creates a basic or fancy basemap with axes, fill, and titles. Several map projections are available,
and the user may specify separate tick-mark intervals for boundary annotation, ticking, and (optionally)
gridlines. A simple map scale (**map_scale**) or directional rose (**rose**) may also be plotted.
At least one of the options \myreflink{frame}, **map_scale**, or **rose** must be specified.

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_R_3D}

- **A** or **polygon** : *polygon=true* or *polygon=fname*\
    No plotting is performed. Instead, we determine the geographical coordinates of the polygon outline
    for the (possibly oblique) rectangular map domain. The plot domain must be given via \myreflink{limits}
    and \myreflink{proj}, with no other options allowed. The sampling interval is controlled via `MAP_LINE_STEP`
    parameter. The coordinates are return in a \myreflink{GMTdataset} or written to *fname* if a file
    name is specified.

\textinput{common_opts/opt_B}

\textinput{common_opts/opt_box}

\textinput{common_opts/opt_map_scale}

\textinput{common_opts/opt_rose}

\textinput{common_opts/opt_compass}

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_p}

\textinput{common_opts/opt_t}

Examples
--------

The following section illustrates the use of the options by giving some examples for the available
map projections. Note how scales may be given in several different ways depending on the projection.
Also note the use of upper case letters to specify map width instead of map scale.

WARNING: the examples have not yet been translated to GMT.jl

Non-geographical Projections
----------------------------

### Linear x-y plot

To make a linear x/y frame with all axes, but with only left and bottom
axes annotated, using xscale = yscale = 1 cm per unit, ticking every 1 unit and
annotating every 2, and using xlabel = "Distance" and ylabel = "No of samples", use

\begin{examplefig}{}
```julia
using GMT
basemap(region=(0,9,0,5), figscale=1,
        frame=(axes=:WeSn, annot=2, ticks=1, xlabel=:Distance, ylabel="No of samples"), show=true)
```
\end{examplefig}

### Log-log plot

To make a log-log frame with only the left and bottom axes, where the
x-axis is 25 cm and annotated every 1-2-5 and the y-axis is 15 cm and
annotated every power of 10 but has tick-marks every 0.1, run

\begin{examplefig}{}
```julia
using GMT
    basemap(region=(1,10000,1e20,1e25), figsize=(25,15), proj=:logxy, frame=(axes=:WS,),
    xaxis=(annot=2, label=:Wavelength),
    yaxis=(annot=1, ticks=3, label=:Power, scale=:pow), show=1)
```
\end{examplefig}

### Power axes

To design an axis system to be used for a depth-sqrt(age) plot with depth positive down, ticked and
annotated every 500m, and ages (in millions of years) annotated at 1 My, 4 My, 9 My etc., use

\begin{examplefig}{}
```julia
using GMT
    # This still fails to generate the intended GMT command. (maybe let scale="pow0.5")
    #basemap(region=(0,100,0,5000), figscale=(1,-0.001), xaxis=(annot=1, label="Crustal age", scale=:pow), yaxis=(annot=500, label=:Depth), show=true)
    basemap(region=(0,100,0,5000), frame="x1p+l\"Crustal age\" y500+lDepth", proj="x1cp0.5/-0.001c", show=true)
```
\end{examplefig}

### Polar (theta,r) plot

For a base map for use with polar coordinates, where the radius from 0 to 1000 should
correspond to 5 cm and with gridlines and ticks intervals automatically determined, use

\begin{examplefig}{}
```julia
using GMT
    basemap(region=(0,360,0,1000), figsize=10, frame=:afg, proj=:polar, show=true)
```
\end{examplefig}

Cylindrical Map Projections
---------------------------

### Cassini

A 10-cm-wide basemap using the Cassini projection may be obtained by

```julia
    gmt basemap -R20/50/20/35 -JC35/28/10c -Bafg -B+tCassini
```

### Mercator [conformal]

A Mercator map with scale 0.025 inch/degree along equator, and showing
the length of 5000 km along the equator (centered on 1/1 inch), may be
plotted as

```julia
    gmt basemap -R90/180/-50/50 -Jm0.025i -Bafg -B+tMercator -Lx1i/1i+c0+w5000k
```

### Miller

A global Miller cylindrical map with scale 1:200,000,000 may be plotted as

```julia
    gmt basemap -Rg -Jj180/1:200000000 -Bafg -B+tMiller
```

### Oblique Mercator [conformal]

To create a page-size global oblique Mercator basemap for a pole at
(90,30) with gridlines every 30 degrees, run

```julia
    gmt basemap -R0/360/-70/70 -Joc0/0/90/30/0.064cd -B30g30 -B+t"Oblique Mercator"
```

### Transverse Mercator [conformal]

A regular Transverse Mercator basemap for some region may look like

```julia
    gmt basemap -R69:30/71:45/-17/-15:15 -Jt70/1:1000000 -Bafg -B+t"Survey area"
```

### Equidistant Cylindrical Projection

This projection only needs the central meridian and scale. A 25 cm wide
global basemap centered on the 130E meridian is made by

```julia
    gmt basemap -R-50/310/-90/90 -JQ130/25c -Bafg -B+t"Equidistant Cylindrical"
```

### Universal Transverse Mercator [conformal]

To use this projection you must know the UTM zone number, which defines
the central meridian. A UTM basemap for Indo-China can be plotted as

```julia
    gmt basemap -R95/5/108/20+r -Ju46/1:10000000 -Bafg -B+tUTM
```

### Cylindrical Equal-Area

First select which of the cylindrical equal-area projections you want by deciding on the
standard parallel. Here we will use 45 degrees which gives the Gall projection. A 9 inch
wide global basemap centered on the Pacific is made by

```julia
    gmt basemap -Rg -JY180/45/9i -Bafg -B+tGall
```

Conic Map Projections
---------------------

### Albers [equal-area]

A basemap for middle Europe may be created by

```julia
    gmt basemap -R0/90/25/55 -Jb45/20/32/45/0.25c -Bafg -B+t"Albers Equal-area"
```

### Lambert [conformal]

Another basemap for middle Europe may be created by

```julia
    gmt basemap -R0/90/25/55 -Jl45/20/32/45/0.1i -Bafg -B+t"Lambert Conformal Conic"
```

### Conic Equidistant

Yet another basemap of width 6 inch for middle Europe may be created by

```julia
    gmt basemap -R0/90/25/55 -JD45/20/32/45/6i -Bafg -B+t"Equidistant conic"
```

### Polyconic

A basemap for north America may be created by

```julia
    gmt basemap -R-180/-20/0/90 -JPoly/4i -Bafg -B+tPolyconic
```

Azimuthal Map Projections
-------------------------

### Lambert [equal-area]

A 15-cm-wide global view of the world from the vantage point -80/-30 will give the following basemap:

```julia
    basemap -Rg -JA-80/-30/15c -Bafg -B+t"Lambert Azimuthal"
```

Follow the instructions for stereographic projection if you want to
impose rectangular boundaries on the azimuthal equal-area map but
substitute \myreflink{proj} **a** for \myreflink{proj} **s**.

### Azimuthal Equidistant

A 15-cm-wide global map in which distances from the center (here 125/10)
to any point is true can be obtained by:

```julia
    gmt basemap -Rg -JE125/10/15c -Bafg -B+tEquidistant
```

### Gnomonic

A view of the world from the vantage point -100/40 out to a horizon of
60 degrees from the center can be made using the Gnomonic projection:

```julia
    gmt basemap -Rg -JF-100/40/60/6i -Bafg -B+tGnomonic
```

### Orthographic

A global perspective (from infinite distance) view of the world from the
vantage point 125/10 will give the following 6-inch-wide basemap:

```julia
    gmt basemap -Rg -JG125/10/6i -Bafg -B+tOrthographic
```

### General Perspective

The \myreflink{proj} **G** option can be used in a more generalized form, specifying
altitude above the surface, width and height of the view point, and
twist and tilt. A view from 160 km above -74/41.5 with a tilt of 55 and
azimuth of 210 degrees, and limiting the viewpoint to 30 degrees width
and height will product a 6-inch-wide basemap:

```julia
    gmt basemap -Rg -JG-74/41.5/6i+z160+a210+t55+v30 -Bafg -B+t"General Perspective"
```

### Stereographic [conformal]

To make a polar stereographic projection basemap with radius = 12 cm to
-60 degree latitude, with plot title "Salinity measurements", using 5
degrees annotation/tick interval and 1 degree gridlines, run

```julia
    gmt basemap -R-45/45/-90/-60 -Js0/-90/12c/-60 -B5g1 -B+t"Salinity measurements"
```

To make a 12-cm-wide stereographic basemap for Australia from an
arbitrary view point (not the poles), and use a rectangular boundary, we
must give the pole for the new projection and use the \myreflink{limits} option to
indicate the lower left and upper right corners (in lon/lat) that will
define our rectangle. We choose a pole at 130/-30 and use 100/-45 and
160/-5 as our corners. The command becomes

```julia
    gmt basemap -R100/-45/160/-5+r -JS130/-30/12c -Bafg -B+t"General Stereographic View"
```

Miscellaneous Map Projections
-----------------------------

### Hammer [equal-area]

The Hammer projection is mostly used for global maps and thus the
spherical form is used. To get a world map centered on Greenwich at a
scale of 1:200000000, use

```julia
    gmt basemap -Rd -Jh0/1:200000000 -Bafg -B+tHammer
```

### Sinusoidal [equal-area]

To make a sinusoidal world map centered on Greenwich, with a scale along
the equator of 0.02 inch/degree, use

```julia
    gmt basemap -Rd -Ji0/0.02i -Bafg -B+tSinusoidal
```

To make an interrupted sinusoidal world map with breaks at 160W, 20W,
and 60E, with a scale along the equator of 0.02 inch/degree, run the
following sequence of commands:

```julia
    gmt begin
    gmt basemap -R-160/-20/-90/90 -Ji-90/0.02i -Bx30g30 -By15g15 -BWesn
    gmt basemap -Bx30g30 -By15g15 -Bwesn -X2.8i
    gmt basemap -Bx30g30 -By15g15 -BwEsn -X1.6i
    gmt end show
```

### Eckert IV [equal-area]

Pseudo-cylindrical projection typically used for global maps only. Set
the central longitude and scale, e.g.,

```julia
    gmt basemap -Rg -Jkf180/0.064c -Bafg -B+t"Eckert IV"
```

### Eckert VI [equal-area]

Another pseudo-cylindrical projection typically used for global maps
only. Set the central longitude and scale, e.g.,

```julia
    gmt basemap -Rg -Jks180/0.064c -Bafg -B+t"Eckert VI"
```

### Robinson

Projection designed to make global maps "look right". Set the central
longitude and width, e.g.,

```julia
    gmt basemap -Rd -JN0/8i -Bafg -B+tRobinson
```

### Winkel Tripel

Yet another projection typically used for global maps only. You can set the central longitude, e.g.,

```julia
    gmt basemap -R90/450/-90/90 -JR270/25c -Bafg -B+t"Winkel Tripel"
```

### Mollweide [equal-area]

The Mollweide projection is also mostly used for global maps and thus the
spherical form is used. To get a 25-cm-wide world map centered on the Dateline:

```julia
    gmt basemap -Rg -JW180/25c -Bafg -B+tMollweide
```

### Van der Grinten

The Van der Grinten projection is also mostly used for global maps and
thus the spherical form is used. To get a 18-cm-wide world map centered on the Dateline:

```julia
    gmt basemap -Rg -JV180/18c -Bafg -B+t"Van der Grinten"
```

### Arbitrary rotation

If you need to plot a map but have it rotated about a vertical axis then
use the |-p| option.  For instance, to rotate the basemap below 90
degrees about an axis centered on the map, try

```julia
    gmt basemap -R10/40/10/40 -JM10c -Bafg -B+t"I am rotated" -p90+w25/25 -Xc
```

Custom Labels or Intervals
--------------------------

The \myreflink{frame} option sets up a regular annotation interval and the annotations derive
from the corresponding *x*, *y*, or *z* coordinates.  However, some applications requires special
control on which annotations to plot and even replace the annotation with other labels. This is
achieved by using **c** *intfile* in the \myreflink{frame} option, where *intfile* contains all
the information about annotations, ticks, and even gridlines. Each record is of the form
*coord* *type* [*label*], where *coord* is the coordinate for this annotation (or tick or gridline),
*type* is one or more letters from **a** (annotation), **i** interval annotation, **f** tickmark,
and **g** gridline. Note that **a** and **i** are mutually exclusive and cannot both appear in the
same *intfile*. Both **a** and **i** requires you to supply a *label* which is used as the plot
annotation. If not given then a regular formatted annotation based on the coordinate will occur.

Restrictions
------------

For some projections, a spherical earth is implicitly assumed. A warning
will notify the user if **verbose** is set.

Bugs
----

The \myreflink{frame} option is somewhat complicated to explain and comprehend.
However, it is fairly simple for most applications (see examples).
