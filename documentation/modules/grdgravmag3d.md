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
