# imopen

```julia
J = imopen(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3, sel=nothing)::GMTimage
```

*keywords: GMT, Julia, image morphology, opening*

Open the grayscale or binary image I.

The morphological opening operation is an erosion followed by a dilation, using the same structuring
element for both operations.
The opening is performed with a matrix of 0’s and 1’s with width `hsize` and height `vsize`, or, if possible,
with the structuring element \myreflink{strel}. Later case is faster but it is only available for binary images, where by
_binary_ images we mean Boolean images or images with only 0’s and 1’s of UInt8 type.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the opening applied.

Example
-------

Erosion with a disk radius of 10, 5 and 20

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/packman.png");
J = imopen(I, sel=strel("box", 20));
grdimage(I, figsize=7)
grdimage!(J, figsize=7, xshift=7.1, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{imclose}, \myreflink{strel}
