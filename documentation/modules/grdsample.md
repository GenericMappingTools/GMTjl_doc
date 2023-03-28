# grdsample

```julia
grdsample(cmd0::String="", arg1=nothing, kwargs...)
```

Description
-----------

Read a grid file and interpolates it to create a new grid file with either: a different
registration (**reg** or **toggle**); or, a new grid-spacing or number of nodes (**inc**),
and perhaps also a new sub-region (**region**). A bicubic [Default], bilinear, B-spline or
nearest-neighbor interpolation is used; see **interp** for settings. Note that using **region**
only is equivalent to `grdcut` or `grdedit` **-S**. **grdsample** safely creates a fine mesh
from a coarse one; the converse may suffer aliasing unless the data are filtered using `grdfft` or `grdfilter`.

When the **region** is omitted, the output grid will cover the same region as
the input grid. When **inc** is omitted, the grid spacing of the output
grid will be the same as the input grid. Either **reg** or **toggle** can be
used to change the grid registration. When omitted, the output grid will
have the same registration as the input grid.

Required Arguments
------------------

The 2-D gridded data set to be contoured.

Optional Arguments
------------------

\textinput{common_opts/opt_save_grd}

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}

- **T** or **toggle** : *toggle=true*\
   Translate between grid and pixel registration; if the input is grid-registered, the output will be
   pixel-registered and vice-versa. This is a *destructive* grid change; see 
   [Switching registrations](https://docs.generic-mapping-tools.org/dev/cookbook/options.html#switch-registrations).

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_n}

\textinput{common_opts/opt_r}

\textinput{common_opts/opt_x}


Grid Values Precision
----------------------

Regardless of the precision of the input data, GMT programs that create grid files will internally
hold the grids in 4-byte floating point arrays. This is done to conserve memory and furthermore
most if not all real data can be stored using 4-byte floating point values. Data with higher precision
(i.e., double precision values) will lose that precision once GMT operates on the grid or writes out
new grids. To limit loss of precision when processing data you should always consider normalizing the
data prior to processing.

Consequences of grid resampling
-------------------------------

Resample or sampling of grids will use various algorithms (see **interp**) that may lead to possible distortions
or unexpected results in the resampled values. One expected effect of resampling with splines is the
tendency for the new resampled values to slightly exceed the global min/max limits of the original grid.
If this is unacceptable, you can impose clipping of the resampled values values so they do not exceed the
input min/max values by adding **+c** to your **interp** option.


Hints
-----

If an interpolation point is not on a node of the input grid, then a NaN at any node in the
neighborhood surrounding the point will yield an interpolated NaN. Bicubic interpolation [default]
yields continuous first derivatives but requires a neighborhood of 4 nodes by 4 nodes. Bilinear
interpolation [**interp**] uses only a 2 by 2 neighborhood, but yields only zero-order continuity.
Use bicubic when smoothness is important. Use bilinear to minimize the propagation of NaNs.

Notes
-----

As an alternative to bicubic spline, linear spline or nearest neighbor interpolation one can
instead send the entire dataset through `surface` for re-gridding. This approach allows
more control on aspects such as tension but it also leads to a solution that
is not likely to have fully converged. The general approach would be something like

```julia
grd2xyz old.grd | gmt surface -Rold.grd -Inewinc -Gnew.grd [other options]
```

For moderate data set one could also achieve an exact solution with `greenspline`,
such as

```julia
grd2xyz old.grd | gmt greenspline -Rold.grd -Inewinc -Gnew.grd [other options]
```

Examples
--------

To resample a sub-region of the 5 x 5 minute remote grid earth_relief_05m onto a 1 minute grid::

```julia
grdsample @earth_relief_05m -R0/20/0/20 -I1m -Gtopo_1m.nc
```

To translate the gridline-registered remote grid earth_relief_05m to pixel
registration while keeping the same region and grid interval::

```julia
grdsample @earth_relief_05m -T -Gpixel.nc
```

See Also
--------