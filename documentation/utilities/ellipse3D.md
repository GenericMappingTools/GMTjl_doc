# ellipse3D

```julia
xyz = ellipse3D(a=1.0, b=a; center=(0.0, 0.0, 0.0), ang1=0.0, ang2=360.0, rot=0.0, e=0.0, f=0.0, plane=:xy, is2D=false, np=72)::Matrix{Float64}
```

Create an ellipse in 2D or 3D space. Attention, this is a 2D body, not an ellipsoid.

### Args
- `a`: The semi-major axis length of the ellipse.

- `b`: The semi-minor axis length of the ellipse. Defaults to `a` if not provided (that is, a circle).

### Kwargs
- `center`: A 3-element array or tuple defining the center of the ellipse.

- `ang1`: The starting angle of the ellipse in degrees.

- `ang2`: The ending angle of the ellipse in degrees.

- `rot`: The rotation angle of the ellipse in degrees. Positive means counterclockwise.

- `e`: The eccentricity of the ellipse, between 0 and 1.

- `f`: The flattening of the ellipse, defined as `(a-b)/a`.

- `plane`: The plane in which to create the ellipse, one of `:xy`, `:xz`, or `:yz`.

- `is2D`: If true, create a 2D ellipse (no z-coordinate).

- `np`: The number of points to use to define the ellipse.

### Returns
A matrix of points defining the ellipse, with each row representing a point in 3D space.
