# imfill

```julia
I2 = imfill(I; conn=4, is_transposed=true, layout="TRBa")
```

*keywords: GMT, Julia, fill image regions and holes*

Fill holes in the grayscale \myreflink{GMTimage} I or UInt8 matrix I.

Here, a hole is defined as an area of dark pixels surrounded by lighter pixels.

### Args
- `I::Union{GMTimage{UInt8, 2}, GMTimage{Bool, 2}, Matrix{UInt8}, Matrix{Bool}, BitMatrix}`: Input image.

### Kwargs
- `conn::Int`: Connectivity for the image filling (4 or 8). Default is 4.

- `is_transposed::Bool`: If `true`, it informs that the input image array is transposed. Default is `true`.
   Normally the \myreflink{GMTimage} carries information to know about the transposition (which is `true` when the layout is "TRB").
   When passing a matrix in column-major order (the default in Julia), `is_transposed` must be set to `false`.
   NOTE: The deaful is `true` because that is the normal case when reading a file image with \myreflink{gmtread} or \myreflink{gdalread}.
  
- `layout::String`: Layout of the input Matrix (default is "TRBa"). If the input is a GMTimage,
   this argument should have been set automatically and can normally be ignored.

### Returns
- A new \myreflink{GMTimage} (or Matrix) with the holes filled.

Examples
--------

Example from Matlab imfill.

\begin{examplefig}{}
```julia
using GMT

I = gmtread(getpath4docs("coins.jpg");
Ibw1 = binarize(I);
Ibw2 = imfill(Ibw);
grdimage(I, figsize=5)
grdimage!(Ibw1, figsize=5, xshift=5)
grdimage!(Ibw2, figsize=5, xshift=5, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{fillsinks}, \myreflink{binarize}
