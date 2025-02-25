# imhdome

```julia
J = imhdome(I::GMTimage{<:UInt8, 2}, H; conn=4)::GMTimage
```

Suppress regional minima in image using H-minima transform.

The H-minima transform decreases the depth of all regional minima by an amount up to `H`. As a result,
the transform fully suppresses regional minima whose depth is less than `H`. Regional minima are
connected pixels with the same intensity value, t, that are surrounded by pixels with an intensity
value greater than t.

### Args
- `I::GMTimage{<:UInt8, 2}`: Input image.

- `H`: height below the filling maskhdome; must be >= 0 (words of the Leptonica pixHDome() docs)

### Kwargs
- `conn::Int=4`: Connectivity value used to identify the regional maxima in I (4 or 8). Default is 4.

### Returns
A new \myreflink{GMTimage} of the same type as `I`.


See Also
--------

\myreflink{imhmax}, \myreflink{imhmin}
