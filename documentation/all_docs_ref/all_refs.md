
# Manuals

## \myreflink{Introduction}

## \myreflink{Quick learn}

## \myreflink{The GMT.jl types (important)}

## Core Modules Manuals

|  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{basemap} | \myreflink{blockmean} | \myreflink{blockmedian} | \myreflink{blockmode} | \myreflink{clip} | \myreflink{coast} | \myreflink{colorbar} | \myreflink{contour} |
| dimfilter  |  events  | \myreflink{filter1d} | \myreflink{fitcircle} | \myreflink{gmt2kml} | \myreflink{gmtbinstats} | \myreflink{gmtconnect} | \myreflink{gmtconvert} |
| gmtdefaults | gmtget | gmtinfo |  gmtlogo | \myreflink{gmtmath} | gmtregress | \myreflink{gmtselect} | \myreflink{gmtset} |
| \myreflink{gmtsimplify} | gmtspatial | \myreflink{gmtsplit} | gmtvector | gmtwhich | \myreflink{grd2cpt} | \myreflink{grd2kml} | \myreflink{grd2xyz} |
|  grdblend | \myreflink{grdclip} | \myreflink{grdcontour} | grdconvert | \myreflink{grdcut} |  grdedit |  grdfft | \myreflink{grdfill} |
| grdfilter | grdgdal | \myreflink{grdgradient} | \myreflink{grdhisteq} | \myreflink{grdimage} | \myreflink{grdinfo} | grdinterpolate | \myreflink{grdlandmask} |
| \myreflink{grdmask} | \myreflink{grdmath} | grdmix | \myreflink{grdpaste} |  grdproject | \myreflink{grdsample} | \myreflink{grdtrack} | \myreflink{grdtrend} |
| \myreflink{grdvector} | \myreflink{grdview} | grdvolume | greenspline | \myreflink{histogram} | \myreflink{image} | \myreflink{inset} | kml2gmt |
| \myreflink{legend} | \myreflink{makecpt} |  mapproject | \myreflink{mask} | \myreflink{movie} | \myreflink{nearneighbor} | \myreflink{plot} | \myreflink{plot3d} |
| \myreflink{project} |  psconvert | \myreflink{rose} | \myreflink{sample1d} | \myreflink{solar} | spectrum1d | sph2grd | sphdistance |
| \myreflink{sphinterpolate} | \myreflink{sphtriangulate} | \myreflink{subplot} | \myreflink{surface} | \myreflink{ternary} | \myreflink{text} | \myreflink{trend1d} | \myreflink{trend2d} |
| \myreflink{triangulate} | \myreflink{wiggle} | \myreflink{xyz2grd} |  |  |  |  |  |

## (Plot) Avatars

|  |  |  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{arrows} | \myreflink{band} | \myreflink{bar} | \myreflink{bar3} | \myreflink{boxplot} | \myreflink{bubblechart} | \myreflink{contourf} | \myreflink{cornerplot} | \myreflink{decorated} | \myreflink{earthregions} |
| \myreflink{ecdfplot} | \myreflink{feather} | \myreflink{fill_between} | \myreflink{hband} | \myreflink{hlines} | \myreflink{logo} | \myreflink{lines} | \myreflink{marginalhist} | \myreflink{parallelplot} | \myreflink{pcolor} |
| \myreflink{plotlinefit} | \myreflink{qqplot} | \myreflink{quiver} | \myreflink{radar} | \myreflink{sealand} | \myreflink{scatter} | \myreflink{scatter3} | \myreflink{stairs} | \myreflink{stem} | \myreflink{streamlines} |
| \myreflink{triplot} | \myreflink{trisurf} | \myreflink{vband} | \myreflink{violin} | \myreflink{vlines} |  |  |  |  |  |

## Web download modules

|  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{maregrams} | \myreflink{pastplates} | \myreflink{seismicity} | \myreflink{weather} | \myreflink{wmsinfo} | \myreflink{wmsread} | \myreflink{wmstest} |  |


## Supplemental Modules (Potential methods)
|  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{gravmag3d} | \myreflink{gravfft} | \myreflink{grdgravmag3d} | \myreflink{gravprisms} | \myreflink{magref} | \myreflink{parkergrav} | \myreflink{parkermag} |  |

## Supplemental Modules (short docs)

{{ generate_tablerefs supplements}}

Note: module names ending with a **\*** mean that they have not yet been ported to GMT.jl and
its use requires resorting to the \myreflink{Monolithic} mode.

## Utility functions

|  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{ablines} | \myreflink{append2fig} | \myreflink{blendimg!} | \myreflink{cart2pol} | \myreflink{cart2sph} | \myreflink{colorzones!} | \myreflink{cpt4dcw} | \myreflink{crop} |
| \myreflink{cubeplot} | \myreflink{coastlinesproj} | \myreflink{cubeslice} | \myreflink{date2doy} | \myreflink{delrows!} | \myreflink{doy2date} | \myreflink{gadm} | \myreflink{geocoder} |
| \myreflink{geodetic2enu} | \myreflink{getbyattrib} | \myreflink{gmtread} | \myreflink{gmtwrite} | \myreflink{graticules} | \myreflink{gridit} | \myreflink{gunique} | \myreflink{imagesc} |
| \myreflink{inpolygon} | \myreflink{inwhichpolygon} | \myreflink{image_alpha!} | \myreflink{image_cpt!} | \myreflink{imshow} | \myreflink{ind2rgb} | \myreflink{info} | \myreflink{isnodata} |
| \myreflink{lelandshade} | \myreflink{linearfitxy} | \myreflink{magic} | \myreflink{mat2ds} | \myreflink{mat2grid} | \myreflink{mat2img} | \myreflink{mosaic} | \myreflink{ODE2ds} |
| \myreflink{orbits} | \myreflink{pca} | \myreflink{plotgrid!} | \myreflink{plotyy} \myreflink{pol2cart} | \myreflink{polygonlevels} | \myreflink{rasterzones!} | \myreflink{regiongeog} | \myreflink{remotegrid} |
| \myreflink{rescale} | \myreflink{slicecube} | \myreflink{sph2cart} | \myreflink{stackgrids} | \myreflink{ter2cart} | \myreflink{theme} | \myreflink{uniqueind} | \myreflink{vecangles} |
| \myreflink{weather} | \myreflink{whereami} | \myreflink{worldrectgrid} | \myreflink{worldrectcoast} | \myreflink{worldrectangular} | \myreflink{xyzw2cube} | \myreflink{yeardecimal} | \myreflink{zonal_stats} |

## Solids functions

|  |  |  |  |  |  |  |  |
|:----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{cube} | \myreflink{cylinder} | \myreflink{dodecahedron} | \myreflink{ellipse3D} | \myreflink{icosahedron} | \myreflink{octahedron} | \myreflink{sphere} | \myreflink{tetrahedron} |
| \myreflink{torus} | \myreflink{extrude} | \myreflink{flatfv} | \myreflink{fv2fv} | \myreflink{grid2tri} | \myreflink{loft} | \myreflink{replicant} | \myreflink{revolve} |
| \myreflink{surf2fv} | \myreflink{torus} |  |  |  |  |  |  |


## Image Processing functions

|  |  |  |  |  |  |  |  |
|:-----|:----|:----|:----|:----|:----|:----|:----|
| \myreflink{binarize} | \myreflink{bwareaopen} | \myreflink{bwhitmiss} | \myreflink{bwperim} | \myreflink{bwskell} | \myreflink{fillsinks} | \myreflink{imbothat} | \myreflink{imclose} |
| \myreflink{imcomplement} | \myreflink{imdilate} | \myreflink{imerode} | \myreflink{imfill} | \myreflink{imfilter} | \myreflink{imhdome} | \myreflink{imhmin} | \myreflink{imhmax} |
| \myreflink{immorphgrad} | \myreflink{imopen} | \myreflink{imrankfilter} | \myreflink{imreconstruct} | \myreflink{imsegment} | \myreflink{imsobel} | \myreflink{imtophat} | \myreflink{isodata} |
| \myreflink{padarray} | \myreflink{strel} | \myreflink{rgb2gray} | \myreflink{rgb2lab} | \myreflink{rgb2ycbcr} |  |  |  |

## GDAL utility functions

{{ generate_tablerefs gdalfuns}}
