# lazwrite

```julia
lazwrite(FileName::AbstractString, xyz; grd_hdr=[], scaleX=nothing, scaleY=nothing, scaleZ=nothing, offX=nothing, offY=nothing, offZ=nothing)
```

or

```julia
lazwrite(FileName::AbstractString, G::GMTgrid; scaleX=nothing, scaleY=nothing, scaleZ=nothing, offX=nothing, offY=nothing, offZ=nothing)
```

Write XYZ data to a LIDAR laz (laszip compressed) or las format file. The second form is used to write a GMTgrid
to a laz file. This is a rather more compressed format that waht is achieved with netCDF, but slightly lossy.
Use \myreflink{lazread} or \myreflink{gmtread} to read the laz file back into a GMTgrid.

### Args

- `FileName`: The name of the file to write to. It must end with `.laz`

- `xyz`: A Mx3 array with the point coordinates

- `G`: A GMTgrid object.

### Kwargs

- `scaleX, scaleY`: Scale factor for the X,Y coordinates used in the laz compression. Default is 1e-7 and 1e-3
  for geographical and cartesian coordinates, respectively.

- `scaleZ`: Scale factor for the Z coordinate used in the laz compression. Default is 1e-2.

- `offX, offY, offZ`: Offsets for the X,Y,Z coordinates used in the laz compression. Default, computes these values as
  ``(floor((hdr.min_x + hdr.max_x) / scaleX / 2e7)) * 1e7 * scaleX``.

### Example

To write the x,y,z data to file "lixo.laz" do:

```julia
	lazwrite("lixo.laz", xyz)
```

See Also
--------

\myreflink{lazread}, \myreflink{gmtread}
