# imclose

```julia
J = imclose(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3, sel=nothing)::GMTimage
```

Close the grayscale or binary image I.

The morphological close operation is a dilation followed by an erosion, using the same structuring element
for both operations.
The closing is performed with a matrix of 0’s and 1’s with width `hsize` and height `vsize`, or, if possible,
with the structuring element \myreflink{strel}. Later case is faster but it is only available for binary images, where by
_binary_ images we mean Boolean images or images with only 0’s and 1’s of UInt8 type.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `hsize::Int=3`: Horizontal size of the 'box' structuring element.

- `vsize::Int=3`: Vertical size of the 'box' structuring element.

- `sel=nothing`: Structuring element (See \myreflink{strel} function). An alternative to `hsize` and `vsize` options.
  If equal to ``nothing``, a structuring box of size `hsize` x `vsize` is used.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the closing applied.

Example
-------

Illustration of closing with a structuring box of width 20

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/packman.png");
J = imclose(I, sel=strel("box", 20));
grdimage(I, figsize=7)
grdimage!(J, figsize=7, xshift=7.1, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{imopen}, \myreflink{strel}
