# imrankfilter

```julia
J = imrankfilter(I::GMTimage; width::Int=3, height::Int=0, rank=0.5)::GMTimage
```

Rank order filter.

This defines, for each pixel, a neighborhood of pixels given by a rectangle "centered" on the pixel.
This set of ``width x height`` pixels has a distribution of values, and if they are sorted in increasing
order, we choose the pixel such that rank*(wf*hf-1) pixels have a lower or equal value and (1-rank)*(wf*hf-1)
pixels have an equal or greater value. In other words, `rank=0` returns the minimun, `rank=1` returns
the maximum in box and `rank=0.5` returns the median. Other values return the quantile.

### Args
- `I::GMTimage`: Input image. This can be a RGB, grayscale or a binary image.

### Kwargs
- `width::Int=3`: Width of the filter.

- `height::Int`: Height of the filter (defaults to `width`).

- `rank=0.5`: Rank.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the filtered image.

Example
-------

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/small_squares.png");
J = imrankfilter(I, width=10);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6, show=true)
```
\end{examplefig}

See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{imopen}, \myreflink{imclose}
