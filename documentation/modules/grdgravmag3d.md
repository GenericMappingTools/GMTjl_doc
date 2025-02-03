# grdgravmag3d

```julia
grdgravmag3d(cmd0::String="", arg1=nothing, kwargs...)
```

*keywords: GMT, Julia, gravity, magnetism*

Description
-----------

Compute the gravity or magnetic anomaly of a body described by one or (optionally) two grids.
The output can either be along a given set of xy locations or on a grid. This method is not
particularly fast but allows computing the anomaly of arbitrarily complex shapes.

Required Arguments
------------------

*grd_top* (and optionally *grd_bot*). Grid(s) whose gravity/mag effect is going to be computed.
If two grids are provided then the gravity/magnetic effect of the volume between them is computed.

- **C** or **density** : -- *density=??*\
    Sets body density in _SI_. Append either a constant, the name of a grid file or a \myreflink{GMTgrid}
    grid with variable densities. This option is mutually exclusive with **mag_params**

- **F** or **track** : -- *track=xy_loc*\
    Provide *xy_loc* (file name or GMTdataset) locations where the anomaly will be computed. Note,
    this option is mutually exclusive with the **save** option.

\textinput{common_opts/opt_save_grd}

Optional Arguments
------------------

- **E** or **thickness** : -- *thickness=??*\
    To provide the layer thickness in m [Default = 500 m].

- **H** or **mag_params** : -- *mag_params=f_dec/f_dip/m_int/m_dec/m_dip* **|** *mag_params="magfile"|maggrid* **|**  *mag_params="x|X|y|Y|z|Z|h|H|t|T|f|F" **|** *mag_params="+i|+n"*\
    Sets parameters for computation of magnetic anomaly (Can be used multiple times).

      - *f_dec/f_dip* -> geomagnetic declination/inclination

      - *m_int/m_dec/m_dip* -> body magnetic intensity/declination/inclination

    OR for a grid mode

      - *maggrid*, a \myreflink{GMTgrid} grid, or *magfile*, where *magfile* is the name of the magnetic intensity file.

    To compute a component, specify any of:

      - **x**|**X**|**e**|**E**  to compute the E-W component.

      - **y**|**Y**|**n**|**N**  to compute the N-S component.

      - **z**|**Z**      to compute the Vertical component.

      - **h**|**H**      to compute the Horizontal component.

      - **t**|**T**|**f**|**F**  to compute the total field.

    If we want to compute the magnetic anomalies over a large region where the ambient magnetic field
    can no longer be assumed to be constant we can set variable inclinations and declinations via IGRF.
    Set any of **mag_params="+i|+n"** to do that.

\textinput{common_opts/opt_I}

- **L** or **z_obs** or **observation_level** : -- *z_obs=0*\
    Sets level of observation [Default = 0]. That is the height (z) at which anomalies are computed.

- **Q** or **pad** : -- *pad="nn_pad" **|** *pad="pad_dist"* **|** *pad="region"*\
    Extend the domain of computation with respect to output **region** region.
      - *pad="nn_pad"* artificially extends the width of the outer rim of cells to have a fake width of *n_pad* * dx[/dy].

      - *pad="pad_dist"* extend the region by west-pad, east+pad, etc.

      - *pad="west/east/south/north"* Same syntax as **region**.

\textinput{common_opts/opt_R}

- **S** or **radius** : -- *radius=30*\
    Set search radius in km (valid only in the two grids mode OR when **thickness**) [Default = 30 km].
    This option serves to speed up the computation by not computing the effect of prisms that
    are further away than *radius* from the current node.

\textinput{common_opts/opt_V}

**Z** or **level** or **reference_level** : -- *level="b|t"* **|** *level=(bottom=true | top=true)*\
    level of reference plane [Default = 0]. Use this option when the triangles describe a non-closed
    surface and the volume is defined from each triangle and this reference level. An example will be
    the water depth to compute a Bouguer anomaly. Use **level=:b** or **level=:t** to close the body
    at its bottom (for example, to compute the effect of a dome) or at its top (to compute the effect of a *spoon*).

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_x}

Grid Distance Units
-------------------

If the grid does not have meter as the horizontal unit, append **+u**_unit_ to the input file name to convert from the
specified unit to meter. If your grid is geographic, convert distances to meters by supplying **f=:g** instead.

Examples
--------

To compute the vertical component due to a magnetization stored in *mag.grd* over a zone defined by
the surface *bat.grd*, using variable declination and inclination provided the IGRF and using 4
processors, do:

```julia
G = grdgravmag3d("bat.grd", thickness=10000, H="z -H+n -H+mmag.grd", x=4, radius=50);
```

Suppose you want to compute the gravity effect of the Gorringe bank.

\begin{examplefig}{}
```julia
using GMT

G = grdgravmag3d("@earth_relief_10m", region=(-12.5,-10,35.5,37.5),
                 density=2700, inc=0.05, pad=0.5, z_level=:bottom, f=:g);
viz(G, title="Gorringe FAA", colorbar=true)
```
\end{examplefig}


See Also
--------

gravmag3d, gravprism, talwani2d, talwani3d

Reference
---------

Okabe, M., 1979, Analytical expressions for gravity anomalies due to
polyhedral bodies and translation into magnetic anomalies, *Geophysics*,
44, 730-741.
