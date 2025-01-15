# imdilate

```julia
J = imdilate(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3, sel=nothing)::GMTimage
```

*keywords: GMT, Julia, image morphology, dilation*

Dilate the grayscale or binary image I.

The dilation is performed with a matrix of 0’s and 1’s with width `hsize` and height `vsize`, or, if possible,
with the structuring element \myreflink{strel}. Later case is faster but it is only available for binary images,
where by _binary_ images we mean Boolean images or images with only 0’s and 1’s of UInt8 type.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the dilation applied.

### Example
Dilation with a square of width 3 (the default when neither `sel`, nor `hsize` or `vsize` are specified)

Examples
--------

Erosion with a disk radius of 10, 5 and 20

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/fig_text_bw.png");
J = imdilate(I);
grdimage(I, figsize=7)
grdimage!(J, figsize=7, xshift=7.1, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imerode}, \myreflink{imopen}, \myreflink{imclose}, \myreflink{strel}
