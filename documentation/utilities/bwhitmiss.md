# bwhitmiss

```julia
J = bwhitmiss(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}, interval::Matrix{<:Integer})::GMTimage
```

Performs the hit-miss operation on a binary image defined in terms of a matrix called an _interval_.

An _interval_ is a matrix whose elements are 0 or 1 or 2 and results from _joining_ two structural
elements SE1 and SE2. 0's are ignored. The 1's make up the domain of SE1 and the 2's the domain of SE2.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `hsize::Int=3`: Horizontal size of the 'box' structuring element.

- `vsize::Int=3`: Vertical size of the 'box' structuring element.

- `smooth::Int=0`: Half-width of convolution smoothing filter. The width is (2 * smoothing + 1), so 0 is a no-op.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the hitmiss applied.

Example
-------

Consider the task of locating upper-left corner pixels of objects in an bw image. We want to locate
foreground pixels that have east and south neighbors (these are 'hits') and that have no northeast, northwest,
west or southwest neighbors (these are 'misses'). These requirements lead to the following interval matrix:

\begin{examplefig}{}
```julia
using GMT

interval = [2 2 2; 2 1 1; 2 1 0];
I = gmtread(TESTSDIR * "assets/small_squares.png");
J = bwhitmiss(I, interval);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6.05, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imdilate}, \myreflink{imerode}
