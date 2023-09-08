# mat2img

```julia
I = mat2img(mat::Array{<:Unsigned}; x=[], y=[], hdr=nothing, proj4="", wkt="", cmap=nothing, kw...)
```

Take a 2D `mat` array and a `hdr` 1x9 [xmin xmax ymin ymax zmin zmax reg xinc yinc] header descriptor
and return a \myreflink{GMTimage} type.
Alternatively to `hdr`, provide a pair of vectors, x & y, with the X and Y coordinates.
Optionally, the `hdr` arg may be omitted and it will computed from `mat` alone, but then x=1:ncol, y=1:nrow
When `mat` is a 3D UInt16 array we automatically compute a UInt8 RGB image. In that case `cmap` is ignored.
But if no conversion is wanted use option `noconv=true`

The method

```julia
I = mat2img(mat::Array{UInt16}; x=[], y=[], hdr=nothing, proj4::String="", wkt::String="", kw...)
```

Take a `mat` array of UInt16 and scale it down to UInt8. Input can be 2D or 3D.  If the `kw` variable `stretch`
is used, we stretch the intervals in `stretch` to [0 255].  Use this option to stretch the image histogram.
If `stretch` is a scalar, scale the values > `stretch` to [0 255]
- `stretch = [v1 v2]` scales all values >= v1 && <= v2 to [0 255]
- `stretch = [v1 v2 v3 v4 v5 v6]` scales first band >= v1 && <= v2 to [0 255], second >= v3 && <= v4, same for third
- `stretch = :auto | "auto" | true | 1` will do an automatic stretching from values obtained from histogram thresholds

The `kw...` kwargs search for [:layout :mem_layout], [:names] and [:metadata]


See Also
--------

\myreflink{mat2ds}, \myreflink{mat2grid}
