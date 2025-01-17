# imhmin

```julia
J = imhmin(I::GMTimage{<:UInt8, 2}, H; conn=4)::GMTimage
```

*keywords: GMT, Julia, image morphology, H-minima transform*

Suppress regional minima in image using H-minima transform.

The H-minima transform decreases the depth of all regional minima by an amount up to `H`. As a result,
the transform fully suppresses regional minima whose depth is less than `H`. Regional minima are
connected pixels with the same intensity value, t, that are surrounded by pixels with an intensity
value greater than t.

### Args
- `I::GMTimage{<:UInt8, 2}`: Input image.

- `H`: Bump's maximum regional depth.

### Kwargs
- `conn::Int=4`: Connectivity value used to identify the regional maxima in I (4 or 8). Default is 4.

### Returns
A new \myreflink{GMTimage} of the same type as `I`.

Example
-------

The result will look like the outline of the object.

```julia
using GMT

a = fill(UInt8(10),10,10);
a[2:4,2:4] .= 7;  
a[6:8,6:8] .= 2;
a[1:3,7:9] .= 13;
a[2,8] .= 10;
I = imhmin(mat2img(a), 4);
```

See Also
--------

\myreflink{imhdome}, \myreflink{imhmax}
