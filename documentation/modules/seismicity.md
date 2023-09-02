# Seismicity

```julia
seismicity(starttime="", endtime="", minmagnitude=3, mindepth=0, maxdepth=0, last=0, printurl=false, show=true, kw...)
```

Make automatic maps of of world-wide seismicity obtained from the USGS Earthquake Hazards Program page at
[USGS](https://earthquake.usgs.gov)

This module is a mix of \myreflink{plot}, \myreflink{coast} and \myreflink{legend} functionalities. So not all (fine)
controlling plotting parameters are listed here. For the finest control, user should consult the manuals of those modules.

Parameters
----------


\textinput{common_opts/opt_B}

\textinput{common_opts/opt_J}

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_mfc}

- `starttime`: Limit to events on or after the specified start time. NOTE: All times use ISO8601 Date/Time format
    OR a DateTime type. Default is NOW - 30 days.

- `endtime`: Limit to events on or before the specified end time. Same remarks as for `starttime`. Default is present time.

- `minmagnitude`: Limit to events with a magnitude larger than the specified minimum.

- `mindepth`: Limit to events with depth more than the specified minimum (km positive down).

- `maxdepth`: Limit to events with depth less than the specified maximum (km positive down).

- `printurl`: Print the url of the requested data.

- `circle`: A 3 elements Tuple or Array with ``lon,lat,radius``, where ``radius`` is in km, to perform a circle search.

- `data`: The default is to make a seismicity map but if the `data` option is used (containing whatever) we return
    we return the data in a ``GMTdataset`` 

- `figname`: Save the figure with the figname=name.ext where ext chooses the figure format (e.g. ``figname="name.png"``)

- `land`: By default we paint the continents with the "burlywood" color. Like in the ``coast`` module, use
   `land=`"othercolor" to replace it.

- `layers`: By default we divide depth into three layers; 1-100, 100-300 and > 300 km, Use `layers=4` to subdivide
    top layer into 0-50 and 50-100 km.

- `legend`: By default we plot a legend. Particular options for the legend command (e.g. `pos`, `box`, etc) are passed
    via the `kw...` options. Use `legend=false` to have no legend.

- `ocean`: By default we paint the oceans with the "lightblue" color. Use `ocean=`"othercolor" to replace it.

- `region`: The region of interest. By default it is [-180 180 -90 90] but one may pass a sub-region like
    all other modules that accept this option (e.g. ``coast``)

- `proj`: By default we select an appropriate projection based on the `region` extents, but that may be overridden
    by specifying a `proj=xxx` like, for example, in ``coast``.

- `size`: Can be a scalar to plot all events with same size. This size is expected to be in cm but > 1 it is interpreted
    to be in points.
    - `size=[min_sz max_sz]` will scale linearly min/max magnitude to have sizes `min_sz/max_sz`
    - `size=([min_sz max_sz], [min_mag max_mag])` will scale linearly min_mag/max_mag magnitude to have sizes `min_sz/max_sz`
    - `size=(fun, [min_sz max_sz] [, [min_mag max_mag]])` does the same as above but the transformation is determined
       by the function ``fun``. Possibles functions are ``exp10``, ``exp``, ``pow`` and ``sqrt``. In the ``pow`` case
       we must pass in also the exponent and the syntax is: `size=((pow,2), [min_sz max_sz])` to have a square scaling.

- `show`: By default this function shows the plot (when no `data` option). Use `show=false` to prevent that (and leave
    the figure open to accept more plots from posterior commands.)

\textinput{common_opts/opt_U}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_X}

\textinput{common_opts/opt_Y}

\textinput{common_opts/opt_save_fig}

Examples
--------

Make a map of the global seismicity of last 30 days..

\begin{examplefig}{}
```julia
using GMT
seismicity()
```
\end{examplefig}


See Also
--------

\myreflink{plot}, \myreflink{coast}, \myreflink{legend}