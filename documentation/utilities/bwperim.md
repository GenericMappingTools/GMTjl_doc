# bwperim

```julia
J = bwperim(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3, sel=nothing)::GMTimage
```

*keywords: GMT, Julia, image morphology, Gradient Morphology*

Find perimeter of objects in binary image I.

A pixel is part of the perimeter if it is nonzero and it is connected to at least one zero-valued pixel.
To detect the image's perimeter, the structuring element should a box of size `3 x 3` (or, better, use the defaults),
but a different sizes can be provided. This operation, consisting on subtracting an erosion of `I` from `I`,
is alsoknown as a morphological `internal gradient`.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `hsize::Int=3`: Horizontal size of the 'box' structuring element.

- `vsize::Int=3`: Vertical size of the 'box' structuring element.

- `sel=nothing`: Structuring element (See \myreflink{strel} function). An alternative to `hsize` and `vsize` options.
  If equal to `nothing`, a structuring box of size `hsize` x `vsize` is used.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the perimeter.

Example
-------

The result will look like the outline of the object.

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/circles.png");
J = bwperim(I);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{strel}
