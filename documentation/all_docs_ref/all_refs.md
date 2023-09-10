
# Manuals

## \myreflink{Introduction}

## \myreflink{Quick learn}

## \myreflink{The GMT.jl types (important)}

## Core Modules Manuals

|  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|
| \myreflink{basemap} | \myreflink{blockmean} | \myreflink{blockmedian} | \myreflink{blockmode} | \myreflink{clip} | \myreflink{coast} |
| \myreflink{colorbar} | \myreflink{contour} | dimfilter  |  events  | \myreflink{filter1d} | |
| \myreflink{fitcircle} | \myreflink{gmt2kml} | \myreflink{gmtbinstats} | \myreflink{gmtconnect} | \myreflink{gmtconvert} | gmtdefaults |
| gmtget |  gmtinfo |  gmtlogo | \myreflink{gmtmath} | gmtregress | \myreflink{gmtselect} |
| \myreflink{gmtset} | \myreflink{gmtsimplify} |  gmtspatial | \myreflink{gmtsplit} |  gmtvector |  gmtwhich |
| \myreflink{grd2cpt} | \myreflink{grd2kml} | \myreflink{grd2xyz} |  grdblend | \myreflink{grdclip} | \myreflink{grdcontour} |
| grdconvert | \myreflink{grdcut} |  grdedit |  grdfft | \myreflink{grdfill} |  grdfilter |
| grdgdal | \myreflink{grdgradient} | \myreflink{grdhisteq} | \myreflink{grdimage} | \myreflink{grdinfo} | grdinterpolate |
| \myreflink{grdlandmask} | \myreflink{grdmask} | \myreflink{grdmath} | grdmix | \myreflink{grdpaste} |  grdproject |
| \myreflink{grdsample} | \myreflink{grdtrack} | \myreflink{grdtrend} | \myreflink{grdvector} | \myreflink{grdview} | grdvolume |
| greenspline | \myreflink{histogram} | \myreflink{image} | \myreflink{inset} | kml2gmt | \myreflink{legend} |
| \myreflink{makecpt} |  mapproject | \myreflink{mask} | \myreflink{movie} | \myreflink{nearneighbor} | \myreflink{plot} |
| \myreflink{plot3d} | \myreflink{project} |  psconvert | \myreflink{rose} | \myreflink{sample1d} | \myreflink{solar} |
| spectrum1d | sph2grd | sphdistance | \myreflink{sphinterpolate} | \myreflink{sphtriangulate} | \myreflink{subplot} |
| \myreflink{surface} | \myreflink{ternary} | \myreflink{text} | \myreflink{trend1d} | \myreflink{trend2d} | \myreflink{triangulate} |
| \myreflink{wiggle} | \myreflink{xyz2grd} |  |  |  |  |

## (Plot) Avatars

|  |  |  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{arrows} | \myreflink{band} | \myreflink{bar} | \myreflink{bar3} | \myreflink{boxplot} | \myreflink{bubblechart} | \myreflink{contourf} | \myreflink{cornerplot} | \myreflink{decorated} | \myreflink{earthregions} |
| \myreflink{ecdfplot} | \myreflink{feather} | \myreflink{fill_between} | \myreflink{hband} | \myreflink{lines} | \myreflink{marginalhist} | \myreflink{parallelplot} | \myreflink{pcolor} | \myreflink{plotlinefit} | \myreflink{qqplot} |
| \myreflink{quiver} | \myreflink{radar} | \myreflink{scatter} | \myreflink{scatter3} | \myreflink{seismicity} | \myreflink{stairs} | \myreflink{stem} | \myreflink{triplot} | \myreflink{trisurf} | \myreflink{vband} |
| \myreflink{violin} | |  |  |  |  |  |  |  |  |  |


## Supplemental Modules

{{ generate_tablerefs supplements}}

Note: module names ending with a **\*** mean that they have not yet been ported to GMT.jl and
its use requires resorting to the \myreflink{Monolithic} mode.

## Utility functions*

|  |  |  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{blendimg!} | \myreflink{colorzones!} | \myreflink{cubeplot} | \myreflink{imagesc} | \myreflink{lelandshade} | \myreflink{coastlinesproj} | \myreflink{cubeslice} | \myreflink{lelandshade} | \myreflink{gmtread} | \myreflink{gmtwrite} |
| \myreflink{graticules} | \myreflink{mat2ds} | \myreflink{mat2grid} | \myreflink{mat2img} | \myreflink{orbits} | \myreflink{plotgrid!} | \myreflink{rasterzones!} | \myreflink{slicecube} | \myreflink{worldrectgrid} | \myreflink{worldrectcoast} |
| \myreflink{worldrectangular} | \myreflink{xyzw2cube} |  |  |  |  |  |  |  |  |

## Utility functions

{{ generate_tablerefs utilfuns}}

Note: This table contains links to the manuals that were automatically generated from the docstrings.
Idealy, they should all be converted to individual man pages and moved to table above.

## GDAL utility functions

{{ generate_tablerefs gdalfuns}}
