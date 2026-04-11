# imtophat

```julia
J = imtophat(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3)::GMTimage
```

Do a morphological top-hat operation on a grayscale or binary image.

Top-hat computes the morphological opening of the image and does a: `orig_image - opening`

This transform can be used to enhance contrast in a grayscale image with nonuniform
illumination. It can also isolate small bright objects in an image.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `hsize::Int=3`: Horizontal size of the 'box' structuring element.

- `vsize::Int=3`: Vertical size of the 'box' structuring element.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the tophat applied.

Example
-------

Perform the top-hat filtering and display the image.

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/rice.png");
J = imtophat(I, hsize=11, vsize=11);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{imopen}, \myreflink{imbothat}
