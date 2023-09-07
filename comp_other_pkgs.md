## Comparison with other plotting packages

- Q - Is GMT.jl different from the other plotting packages in Julia?
- A - Yes and No.

### No

  - GMT.jl uses a `Plots` like syntax and is a general purpose plotting package but doesn't provide (yet)
    the more exotic plot types that can be found in `Plots`, `Makie`, `PyPlot`, etc...
  - It is not interactive like [GLMakie](https://makie.juliaplots.org/stable/documentation/backends/glmakie/).
  - It works in a similar way of [Luxor](https://juliagraphics.github.io/Luxor.jl/stable/) and
    [CairoMakie](https://makie.juliaplots.org/stable/documentation/backends/cairomakie/) in the sense that a
    vector graphics is generated and at the end rasterized for displaying. The plot quality should be similar
    to that of those packages (they use the Cairo library and GMT uses its own PostScript library). A prof of
    this quality is that GMT has been used for the last 30 years in publishing papers in the highest ranked journals.

### Yes

  - GMT.jl builds on 30 years of experience in fine-tunning details for producing highest quality maps (*BTW* `GMT` stands
    for `Generic Mapping Tools`) with lots of mapping projections and a deep knowledge that the Earth is **round**.
  - The figure dimensions in GMT are stated in physical units of cm (or inch), not pixels. The internal PS machinery
    uses integer numbers at an effective DPI of 1200. This allows to keep PostScript files reasonably small
    and at same time permits to create figures that can go as big as 11 x 11 meters.
  - GMT.jl is not a map/plotting package only. It has innumerous tools for grid and vector data processing.
    *e.g.* read virtually almost all formats (directly or via GDAL), grid interpolations, 1 and 2D filtering,
    coordinate conversions, direct access to many of GDAL, PROJ, GEOS functions, dedicated tools for seismology,
    geodesy, potential methods (gravity and geomagnetism), etc...
  - Thanks to Julia's FFI (Foreign Function Interface) GMT.jl can interface with the 
    [MB-system](https://www.mbari.org/products/research-software/mb-system/) software from swath-bathymetry
    data processing.

## Comparison with other packages

- Q - Does GMT.jl offer the same functionality of other packages in Julia?
- A - Yes.

The list is long, non exaustive, but we are not going to do a comparison here and, besides, for many cases
the overlap is only partial.  And why is there such a overlap with other packages? Well, GMT (the C lib)
already existed before most of them.

- [ArchGDAL](https://github.com/yeesian/ArchGDAL.jl)
- [FITSIO](https://github.com/JuliaAstro/FITSIO.jl)
- [GADM](https://github.com/JuliaGeo/GADM.jl)
- [GeoJSON](https://github.com/JuliaGeo/GeoJSON.jl)
- [Geodesy](https://github.com/JuliaGeo/Geodesy.jl)
- [HDF5](https://github.com/JuliaIO/HDF5.jl)
- [Interpolations](https://github.com/JuliaMath/Interpolations.jl)
- [LibGEOS](https://github.com/JuliaGeo/LibGEOS.jl)
- [NetCDF](https://github.com/JuliaGeo/NetCDF.jl)
- [Proj](https://github.com/JuliaGeo/Proj.jl)
- [Rasters](https://github.com/rafaqz/Rasters.jl)
- [Shapefile](https://github.com/JuliaGeo/Shapefile.jl)
- [TriangleMesh](https://github.com/konsim83/TriangleMesh.jl), [Triangulate.jl](https://github.com/JuliaGeometry/Triangulate.jl), [Triangle.jl](https://github.com/cvdlab/Triangle.jl)
