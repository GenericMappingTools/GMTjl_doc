# xyzw2cube

```julia
xyzw2cube(fname::AbstractString; datatype::DataType=Float32, proj4::String="", wkt::String="",
	        epsg::Int=0, tit::String="", names::Vector{String}=String[])
```

*keywords: GMT, Julia, grid cube*

Convert data table containing a cube into a \myreflink{GMTgrid} cube. The input data must contain a completelly filled
3D matrix and the data layout is guessed from file analysis (if it fails ... bad luck). 

- `fname`: The filename of the cube in text format

- `datatype`:  The data type where the data will be stored. The default is Float32.

- `tit`:  A title string to describe this cube.

- `proj4`:  A proj4 string for dataset SRS.

- `wkt`:  Projection given as a WKT SRS.

- `epsg`: Same as `proj` but using an EPSG code

- `names`: used to give a description for each layer (also saved to file when using a GDAL function).

Returns
-------

A \myreflink{GMTgrid} cube object.


See Also
--------

\myreflink{cubeplot}, \myreflink{slicecube}, \myreflink{stackgrids}
