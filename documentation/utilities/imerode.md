# imerode

```julia
J = imerode(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3, sel=nothing)::GMTimage
```

*keywords: GMT, Julia, image morphology, erosion*

Erode the grayscale or binary image I.

The erosion is performed with a matrix of 0’s and 1’s with width `hsize` and height `vsize`, or, if possible,
with the structuring element \myreflink{strel}. Later case is faster but it is only available for binary images,
where by _binary_ images we mean Boolean images or images with only 0’s and 1’s of UInt8 type.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `hsize::Int=3`: Horizontal size of the 'box' structuring element.

- `vsize::Int=3`: Vertical size of the 'box' structuring element.

- `sel=nothing`: Structuring element (See \myreflink{strel} function). An alternative to `hsize` and `vsize` options.
  If equal to ``nothing``, a structuring box of size `hsize` x `vsize` is used.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the erosion applied.

Examples
--------

Erosion with a disk radius of 10, 5 and 20

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/chip.png");
J1 = imerode(I, sel=strel("disk", 10));
J2 = imerode(I, sel=strel("disk", 5));
J3 = imerode(I, sel=strel("disk", 20));
grdimage(I, figsize=6)
grdimage!(J1, figsize=6, xshift=6.1)
grdimage!(J2, figsize=6, xshift=-6.1, yshift=-6.1)
grdimage!(J3, figsize=6, xshift=6.1, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imdilate}, \myreflink{imopen}, \myreflink{imclose}, \myreflink{strel}
