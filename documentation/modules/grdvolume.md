# grdvolume

```julia
grdvolume(cmd0::String="", arg1=nothing; kwargs...)
```

**grdvolume** - Calculate grid volume and area constrained by a contour

(**Warning: Manual translate by Claude. Needs revision**)

## Description

Reads a 2-D grid file and calculates the volume contained below the surface and above the plane specified by the given contour (or zero if not given) and reports the contour, area, volume, and maximum mean height (volume/area). Alternatively, a range of contours can be specified to determine the volume and area inside the contour for all contour values. Using **find\_max**, the contour that produced the maximum mean height (or maximum curvature of heights vs contour value) is reported as well. This feature may be used with [`grdfilter`](@ref) in designing an Optimal Robust Separator [Wessel, 1998; 2016].

## Required Arguments

A **GMTgrid** or a grid file name of a 2-D gridded data set.

## Optional Arguments

- **C** or **cont** or **contour** : -- *cont=cval* **|** *cont=(low,high,delta)* **|** *cont="r(low,high)"* **|** *cont="rcval"*\
   Find area, volume and mean height (volume/area) inside and above the *cval* contour. Alternatively, search using all contours from *low* to *high* in steps of *delta*. [Default returns area, volume and mean height of the entire grid]. The area is measured in the plane of the contour. Adding the **r** prefix computes the volume below the grid surface and above the planes defined by *low* and *high*, or below *cval* and grid's minimum. Note that this is an *outside* volume whilst the other forms compute an *inside* (below the surface) area volume. Use this form to compute for example the volume of water between two contours.

- **D** or **diff** or **difference** : -- *diff=true*\
   Append the difference between the volume calculated and the volume of the grid domain bounding box (i.e., the missing or remainder volume).

- **L** or **base_level** or **baselevel** : -- *base_level=val*\
   Also compute the area, volume and mean height from *base* up to the contour. If no **cont** is given then we compute the area and volume below the surface and above *base* [Default base is contour].

\textinput{common_opts/opt_R}

- **S** or **unit** : -- *unit=:letter*\
   For geographical grids, append a unit from **e|f|k|M|n|u**. Default calculates areas and volumes based upon a spherical Earth using great circle distances.

- **T** or **find\_max** or **findmax**: -- *find\_max=:c* **|** *find\_max=:h*\
   Determine the single contour that maximized the average height (volume/area). Select **find\_max=:c** to use the maximum curvature of heights versus contour value rather than the contour with the maximum height to pick the best contour value [Default is **:h**].

\textinput{common_opts/opt_V}

- **Z** or **scale** : -- *scale=fact* **|** *scale=(fact,shift)*\
   Optionally subtract *shift* before scaling data by *fact*. [Default is no scaling]. (Numbers with units are not supported).

\textinput{common_opts/opt_f}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_xy}

## Notes

The surface will be approximated using a bilinear expression for the z-value inside each grid box defined by four grid nodes:

``z(x,y) = z_0 + z'_x x + z'_y y + z''_{xy} xy``

where the first term is the grid value at the lower left corner of the cell (where our relative coordinates x = y = 0). The primed z-values are derivatives in x, y, and both directions, respectively. We analytically integrate this expression within each box, allowing for straight line contour intersections to go through a box and affect the integration domain and limits. We then sum up all contributions from all the grid cells.

For geographical grids we convert degrees to "Flat Earth" distances in meter. You can use **unit** to select another distance unit. The area is then reported in this unit squared while the volume is reported in ``unit^2 * z_{unit}`` quantities.

**grdvolume** distinguishes between gridline and pixel-registered grids. In both cases the area and volume are computed up to the grid boundaries. That means that in the first case the grid cells on the boundary only contribute half their area (and volume), whereas in the second case all grid cells are fully used. The exception is when the **cont** option is used: since contours do not extend beyond the outermost grid point, both grid types are treated the same.

## Examples

To determine area, volume, and mean height in km for all land areas (above zero contour) in the Hawaiian Islands from the remote grid (height in m):

```julia
using GMT
G = gmtread("@earth_relief_05m", region=(190,210,15,25))
D = grdvolume(G, cont=0, unit=:k, scale=0.001)
```

To find the volume below the surface peaks.nc and above the contour z = 250 m:

```julia
G = gmtread("peaks.nc")
D = grdvolume(G, cont=250)
```

To search for the contour, ranging from 100 to 300 in steps of 10, that maximizes the ratio of volume to surface area for the file peaks.nc:

```julia
G = gmtread("peaks.nc")
D = grdvolume(G, cont=(100,300,10), find_max=:h)
```

To see the areas and volumes for all the contours in the previous example:

```julia
G = gmtread("peaks.nc")
D = grdvolume(G, cont=(100,300,10))
```

## References

Wessel, P., 1998, An empirical method for optimal robust regional-residual separation of geophysical data, *Math. Geol.*, **30**(4), 391-408, [https://doi.org/10.1023/A:1021744224861](https://doi.org/10.1023/A:1021744224861).

Wessel, P., 2016, Regional–residual separation of bathymetry and revised estimates of Hawaii plume flux, *Geophys. J. Int.*, **204**(2), 932-947, [https://doi.org/10.1093/gji/ggv472](https://doi.org/10.1093/gji/ggv472).

## See Also

\myreflink{grdfilter}, \myreflink{grdmask}