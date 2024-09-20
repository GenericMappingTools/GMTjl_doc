# remotegrid

```julia
    remotegrid(name, res_p::String=""; res::String="", reg::String="", info=false)
```

Generate the full name of a GMT "Remote Data Grid" convenient to use in other GMT functions that deal with grids.

A "Remote Data Sets" set is a grid that is stored on one or more remote servers.
It may be a single grid file or a collection of subset tiles making up a larger grid. They are not distributed with GMT
or installed during the installation procedures. GMT offers several remote global data grids that you can access via
our remote file mechanism. The first time you access one of these files, GMT will download the file (or a subset tile)
from the selected GMT server and save it to the server directory under your GMT user directory [~/.gmt]. From then on
we read the local file from there. See more at: 
[GMT Remote Data Sets](https://docs.generic-mapping-tools.org/dev/datasets/remote-data.html#currently-available-remote-data-sets)

This function lets you access the GMT "Remote Data Sets" grids via simplified syntax. Note that it won't download the
data but generates and returns the full grid name that can be used in other GMT functions (``gmtread``, ``grdimage``,
``grdcontour``, ``grdcut``, etc...).

Parameters
----------

- `name`: The grid name. One of:

  - `earth_age`, `earth_geoid`, `earth_mag`, `earth_gebco`, `earth_gebcosi`, `earth_mask`, `earth_dist`, `earth_faa`, `earth_faaerror`, `earth_edefl`, `earth_ndefl`, `earth_mss`, `earth_mdt`, `earth_relief`, `earth_synbath`, `earth_vgg`, `earth_wdmam`, `earth_day`, `earth_night`, 
  - `mars_relief`, `mercury_relief`, `moon_relief`, `pluto_relief`, `venus_relief`.

Keyword Arguments
-----------------

- `rest_p` or `res`: Grid resolution. One of "01d", "30m", "20m", "15m", "10m", "06m", "05m", "04m", "03m" or higher
  for the grids that have finer resolution. Use the `info` option to inquiry all available resolutions of a grid.
  The suffix ``d``, ``m``, and ``s`` stand for arc-degrees, arc-minutes, and arc-seconds, respectively.
	
- `reg`: Grid registration. Choose between 'g'rid or 'p'ixel registration or leave blank for modules to picking the indicated one.
  By default, a gridline-registered grid is selected unless only the pixel-registered grid is available.
	
- `info`: Print grid information (true) or just the full grid name (false). Cannot be used with the option `res`.

To get only the list of available grid names, type ``remotegrid()``.

As sated above this function does not download any data but is a convenient helper for those who do. However, one need
to be very carefull with the grid sizes. For example, the ``earth_relief`` at "15s" weights 2.6 GB ... and 45 GB at "01s".
So, for those high resolution grids you should use the the ``region`` option provided by the ``grdcut`` or ``gmtread``.

Examples
--------

See the Moon grid at "6m" resolution

\begin{examplefig}{}
```julia
using GMT

G = gmtread(remotegrid("moon", res="6m"))
viz(G, shade=true)
```
\end{examplefig}

See a region over Oman of the "earth_relief" at "15s" resolution

\begin{examplefig}{}
```julia
using GMT

G = grdcut(remotegrid("earth_relief", res="15s"), region=(55,60,23,28))
viz(G, proj=:guess, shade=true, coast=true, colorbar=true)
```
\end{examplefig}


See all details of the "earth_relief" grid (open the GMT site page)

```julia
@? remotegrid("earth_relief", info=true)
```

See Also
--------

\myreflink{gmtread}, \myreflink{grdcut}
