# imsobel

```julia
J = imsobel(I::GMTimage{<:UInt8, 2}; direction::Int=2)::GMTimage
```

Sobel edge detecting filter.

Returns a binary \myreflink{GMTimage} containing 1s where the function finds edges in the grayscale or binary image I and 0s elsewhere.

### Args
- `I::GMTimage`: Input grayscale image.

### Kwargs
- `direction::Int=2`: Orientation flag: `0` means detect horizontal edges, `1` means vertical and `2` means all edges.

### Returns
- A new \myreflink{GMTimage} grayscale image `I` with the edge detection, edges are brighter.

Example
-------

Let us vectorize the rice grains in the image "rice.png". The result is not perfect because
the grains in the image's edge are not closed and therefore not filled. And those get poligonized
twice (in and outside) making the red lines look thicker (but they are not, they are just doubled).

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/rice.png");
J = imsobel(I);
BW = binarize(J);
BW = bwskell(BW);	# Skeletize to get a better approximation of the shapes.
BW = imfill(BW);	# Fill to avoid "double" vectorization (outside and inside grain outline)
D = polygonize(BW);
grdimage(I, figsize=5)
grdimage!(J, figsize=5, xshift=5.05)
grdimage!(BW, figsize=5, xshift=-5.05, yshift=-5.05)
grdimage!(I, figsize=5, xshift=5.05, plot=(data=D, lc=:red), show=true)
```
\end{examplefig}

See Also
--------

\myreflink{imfill}, \myreflink{bwskell}, \myreflink{imerode}, \myreflink{imfilter}
