# grdproject

Forward and inverse map transformation of grids

(**Warning: Manual translate by Claude. Needs revision**)

## Synopsis

**grdproject** *ingrid*
[ **G** | **outgrid** | **save** ]
[ **J** | **proj** | **projection** ]
[ **C** | **center** | **origin** ]
[ **D** | **inc** | **increment** | **spacing** ]
[ **E** | **dpi** ]
[ **F** | **scaling** | **force\_scale** ]
[ **I** | **inverse** ]
[ **M** | **unit** ]
[ **R** | **region** | **limits** ]
[ **V** | **verbose** ]
[ **j** | **spherical\_dist** | **spherical** ]
[ **n** | **interp** | **interpolation** ]
[ **r** | **reg** | **registration** ]

## Description

**grdproject** will do one of two things depending whether **inverse** has been set. If set, it will transform a gridded data set from a rectangular coordinate system onto a geographical system by resampling the surface at the new nodes. If not set, it will project a geographical gridded data set onto a rectangular grid. To obtain the value at each new node, its location is inversely projected back onto the input grid after which a value is interpolated between the surrounding input grid values. By default bi-cubic interpolation is used. Aliasing is avoided by also forward projecting the input grid nodes. If two or more nodes are projected onto the same new node, their average will dominate in the calculation of the new node value. Interpolation and aliasing is controlled with the **interpolation** option. The new node spacing may be determined in one of several ways by specifying the grid spacing, number of nodes, or resolution. Nodes not constrained by input data are set to NaN.

The **region** option can be used to select a map region larger or smaller than that implied by the extent of the grid file.

## Required Arguments

*ingrid*
:   2-D binary grid file to be projected. Can be a file name, or GMTgrid object.

\textinput{common_opts/opt_J}

## Optional Arguments

\textinput{common_opts/opt_-Grid}

\textinput{common_opts/opt_R}

- **C** or **center** : -- *center=true* **|** *center=(dx, dy)* **|** *center="dx/dy"*\
    Let projected coordinates be relative to projection center [Default is relative to lower left corner]. Optionally, add offsets in the projected units to be added (or subtracted when **inverse** is set) to (from) the projected coordinates, such as false eastings and northings for particular projection zones [0/0].

- **D** or **inc** : -- *inc=xinc* **|** *inc=(xinc, yinc)* **|** *inc="xinc[+e|n][/yinc[+e|n]]"*\
    Set the grid spacing for the new grid. If neither **inc** nor **dpi** are set then we select the same number of output nodes as there are input nodes. Available modifiers:
    
    **Geographical (degrees) coordinates**:
    - Append **m** to indicate arc minutes or **s** to indicate arc seconds.
    - If one of the units **e**, **f**, **k**, **M**, **n** or **u** is appended instead, the increment is assumed to be given in meter, foot, km, Mile, nautical mile or US survey foot, respectively, and will be converted to the equivalent degrees longitude at the middle latitude of the region (the conversion depends on PROJ\_ELLIPSOID). If *yinc* is given but set to 0 it will be reset equal to *xinc*; otherwise it will be converted to degrees latitude.
    
    **All coordinates**:
    - **exact** or **+e** : *exact=true* -- If appended then the corresponding max x (east) or y (north) may be slightly adjusted to fit exactly the given increment [by default the increment may be adjusted slightly to fit the given domain].
    - **number** or **+n** : *number=true* -- Instead of giving an increment you may specify the number of nodes desired; the increment is then recalculated from the number of nodes and the domain. The resulting increment value depends on whether you have selected a gridline-registered or pixel-registered grid.
    
    Note: If **region** is set from a grid file then the grid spacing (and registration) have already been initialized; use **inc** (and **registration**) to override the values.

- **E** or **dpi** : -- *dpi=value*\
    Set the resolution for the new grid in dots per inch.

- **F** or **one2one** : -- *scaling=:e* **|** *one2one=:f* **|** *one2one="c|i|p|e|f|k|M|n|u"*\
    Force 1:1 scaling, i.e., output (or input, see **inverse**) data are in actual projected meters [**:e**]. To specify other units, use:
    - **:f** : foot
    - **:k** : km
    - **:M** : statute mile
    - **:n** : nautical mile
    - **:u** : US survey foot
    - **:i** : inch
    - **:c** : cm
    - **:p** : point
    
    Without **scaling**, the output (or input, see **inverse**) are in the units specified by PROJ\_LENGTH\_UNIT (but see **unit**).

- **I** or **inverse** : -- *inverse=true*\
    Do the inverse transformation, from rectangular to geographical.

- **M** or **projected_unit** : -- *projected_unit=:c* **|** *projected_unit=:i* **|** *projected_unit=:p*\
    Append **:c**, **:i**, or **:p** to indicate that cm, inch, or point should be the projected measure unit [Default is set by PROJ\_LENGTH\_UNIT in gmt.conf]. Cannot be used with **scaling**.

\textinput{common_opts/opt_R}

\textinput{common_opts/opt_V}

\textinput{common_opts/opt__j}

\textinput{common_opts/opt_n}

## Examples

To transform a chunk of the geographical remote grid earth\_relief\_05m onto a pixel Mercator grid at 300 dpi given a scale of 0.25 inches per degree, run:

```julia
using GMT
G = grdproject("@earth_relief_05m", region=(20, 50, 12, 25), proj=:Mercator, 
               proj=(scale=0.25,), dpi=300, reg=:pixel, save="etopo5_merc.nc", 
               unit=:i)
```

Or using the short form:

```julia
G = grdproject("@earth_relief_05m", R=(20, 50, 12, 25), J="m0.25i", E=300, 
               r=:pixel, G="etopo5_merc.nc", M=:i)
```

To inversely transform the file topo\_tm.nc back onto a geographical grid, use:

```julia
G = grdproject("topo_tm.nc", region=(-80, -70, 20, 40), proj=:TransverseMercator, 
               proj=(center=-75, scale="1:500000"), inverse=true, inc="5m", 
               verbose=true, save="topo.nc")
```

This assumes, of course, that the coordinates in topo\_tm.nc were created with the same projection parameters.

To inversely transform the file topo\_utm.nc (which is in UTM meters) back to a geographical grid we specify a one-to-one mapping with meter as the measure unit:

```julia
G = grdproject("topo_utm.nc", region=(203, 205, 60, 65), proj=:UTM, 
               proj=(zone=5, scale="1:1"), inverse=true, 
               save="topo.nc", verbose=true)
```

To inversely transform the file data.nc (which is in Mercator meters with Greenwich as the central longitude and a false easting of -4 and produced on the ellipse WGS-72) back to a geographical grid we specify a one-to-one mapping with meter as the measure unit:

```julia
G = grdproject("data.nc", proj=:Mercator, proj=(scale="1:1"), inverse=true, 
               scaling=:e, center=(-4, 0), save="data_geo.nc", verbose=true, 
               par=("PROJ_ELLIPSOID", "WGS-72"))
```

Or in monolithic style:

```julia
G = grdproject("data.nc", J="m/1:1", I=true, F=true, C="-4/0", G="data_geo.nc", 
               V=true, par=("PROJ_ELLIPSOID", "WGS-72"))
```

## Output Region Issues

The boundaries of a projected (rectangular) data set will not necessarily give rectangular geographical boundaries (Mercator is one exception). In those cases some nodes may be unconstrained (set to NaN). To get a full grid back, your input grid may have to cover a larger area than you are interested in.

## Select Ellipsoidal versus Spherical Solution

GMT will use ellipsoidal formulae if they are implemented and the user have selected an ellipsoid as the reference shape (see PROJ\_ELLIPSOID). The user needs to be aware of a few potential pitfalls:

1. **Projection-dependent switching**: For some projections, such as Transverse Mercator, Albers, and Lambert's conformal conic we use the ellipsoidal expressions when the areas mapped are small, and switch to the spherical expressions (and substituting the appropriate auxiliary latitudes) for larger maps. The ellipsoidal formulae are used as follows:
   - **Transverse Mercator**: When all points are within 10 degrees of central meridian
   - **Conic projections**: When longitudinal range is less than 90 degrees
   - **Cassini projection**: When all points are within 4 degrees of central meridian

2. **Historical data matching**: When you are trying to match some historical data (e.g., coordinates obtained with a certain projection and a certain reference ellipsoid) you may find that GMT gives results that are slightly different. One likely source of this mismatch is that older calculations often used less significant digits. For instance, Snyder's examples often use the Clarke 1866 ellipsoid (defined by him as having a flattening f = 1/294.98). From f we get the eccentricity squared to be 0.00676862818 (this is what GMT uses), while Snyder rounds off and uses 0.00676866. This difference can give discrepancies of several tens of cm. If you need to reproduce coordinates projected with this slightly different eccentricity, you should specify your own ellipsoid with the same parameters as Clarke 1866, but with f = 1/294.97861076. Also, be aware that older data may be referenced to different datums, and unless you know which datum was used and convert all data to a common datum you may experience mismatches of tens to hundreds of meters.

3. **Scale factors**: Be aware that PROJ\_SCALE\_FACTOR have certain default values for some projections so you may have to override the setting in order to match results produced with other settings.

The decision of ellipsoidal (if available) versus spherical is taken in this order:
- The user specifies **spherical=:e** which forces the ellipsoidal solution.
- The user specifies **spherical=:g** which forces the spherical solution.
- A specific region is set via **region** which implies that portions of that region will be more than stated limit of longitude from the specific (or implied if not set) central meridian.

When a spherical solution is requested or implied, we consider the currently selected ellipsoid and substitute the relevant auxiliary latitude as latitude in the exact equation. Finally, coordinate conversion may also be affected by the selected PROJ\_SCALE\_FACTOR which is typically 0.9996 but is 1 for a sphere.

**Note**: For some projection, a spherical solution may be used despite the user having selected an ellipsoid. This occurs when the user's **region** setting implies a region that exceeds the domain in which the ellipsoidal series expansions are valid. These are the conditions:
1. Lambert Conformal Conic (**:LambertConic**) and Albers Equal-Area (**:AlbersEqualArea**) will use the spherical solution when the map scale exceeds 1.0E7.
2. Transverse Mercator (**:TransverseMercator**) and UTM (**:UTM**) will use the spherical solution when either the west or east boundary given in **region** is more than 10 degrees from the central meridian.
3. Same for Cassini (**:Cassini**) but with a limit of only 4 degrees.

## See Also

\myreflink{mapproject}