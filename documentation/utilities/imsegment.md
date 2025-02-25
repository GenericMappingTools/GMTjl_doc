# imsegment

```julia
J = function imsegment(I::GMTimage{<:UInt8, 3}; maxdist::Int=0, maxcolors::Int=0, selsize::Int=3, colors::Int=5)::GMTimage
```

Unsupervised RGB color segmentation.

For more details see the docs in Leptonica's function ``pixColorSegment`` (in src/colorseg.c).

### Args
- `I::GMTimage{<:UInt8, 3}`: Input RGB image.

### Kwargs
- `maxdist::Int=0`: Maximum euclidean dist to existing cluster.

- `maxcolors::Int=0`: Maximum number of colors allowed in first pass.

- `selsize::Int=3`: Size of the structuring element for closing to remove noise.

- `colors::Int=5`: Number of final colors allowed after 4th pass.

As a very rough guideline (Leptonica docs), given a target value of `colors`, here are
approximate values of `maxdist` and `maxcolors`:

| `colors` | `maxcolors` | `maxdist` |
|----------|-------------|-----------|
| 2        | 4           | 150       |
| 3        | 6           | 100       |
| 4        | 8           | 90        |
| 5        | 10          | 75        |
| 6        | 12          | 60        |
| 7        | 14          | 45        |
| 8        | 16          | 30        |

### Returns
A new, indexed, \myreflink{GMTimage} with the segmentation.

Examples
--------

This was thought as a simple example but turned out to show a bit tricky result. The image
"bunny_cenora.jpg" is simple and we can clearly see that it has only 6 colors, so we would
expect that `colors=6` would do the job. But in fact we need to set `colors=7` because
the outline (black) is in fact picked as two different (dark) colors.

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/bunny_cenora.jpg");
J = imsegment(I, colors=7);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6, show=true)
```
\end{examplefig}
