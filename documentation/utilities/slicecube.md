# slicecube

```julia
slicecube(I::GMTimage, layer::Union{Int, AbstractVector{<:Int}})
```

Take a slice of a multi-layer \myreflink{GMTimage}. Return the result still as a GMTimage. `layer` is the z slice number.

```julia
slicecube(G::GMTgrid, slice::Union{Int, AbstractVector{<:Int}}; axis="z")
```

Extract a slice from a \myreflink{GMTgrid} cube.

*keywords: GMT, Julia, cube slice*

- `slice`: If it is an Int it will return a GMTgrid corresponding to that layer.
  However, if `slice` is a float this is interpreted to mean: search that dimension (see the `axis` below)
  coordinates and find the closest layer that has coordinate = `slice`. If the `slice` value is not within
  10 % of the coordinate of closest layer, the returned layer is obtained by linear interpolation of the
  neighboring layers. For example, `slice=2.5` on a cube were layers are one unit apart will interpolate
  between layers 2 and 3 where each layer weights 50 % in the end result. NOTE: the return type is
  still a cube but with one layer only (and the corresponding axis coordinate).
  `slice` can also be a vector of integers representing the slices we want to extract. The output is another cube.

- `axis`: denotes the dimension being sliced. The default, "z", means the slices are taken from the
  vertical axis. `axis="x"` means slice along a column, and `axis="y"` slice along a row.

```julia
slicecube(GI::GItype; slice::Int=0, angle=0.0, axis="x", cmap=GMTcpt())
```

Take a slice of a GMTgrid or GMTimage in an oblique direction. Take the cube's layer `slice` and rotate it
by `angle` degrees about the `axis`. This one can only be `axis=:x` or `axis=:y`. Depending on the data
type of input a different output is produces. If `GI` is a GMTgrid, the output is 2 GMTgrids: one with `z`
levels and the other with cube's z levels along that plane. On the other hand, if GI isa GMTimage the
first output is similar to previus case but the second will be a GMTimage. In this case the `cmap` option
may be used to assign a colortable to the image type.

The value at the slice point, P(x[i,j], y[i,j], z[i,j]), is the interpolated value of the two nearest
voxels on the same vertical.


Examples
--------

Get the fourth layer of the multi-layered `I` \myreflink{GMTimage} object 

```julia
I = slicecube(I, 4)
```

See Also
--------

\myreflink{cubeplot}, \myreflink{xyzw2cube}
