# bwskell

```julia
J = bwskell(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; type::Int=1, maxiters::Int=0, conn::Int=4)::GMTimage
```

*keywords: GMT, Julia, image morphology, Thinning, Skeletonize*

Reduce all objects to lines in 2-D binary image.

Reduces all objects in the 2-D binary image `I` to 1-pixel wide curved lines, without changing the essential
structure of the image. This process, called skeletonization, extracts the centerline while preserving the topology.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `type::Int=1`: 1 To thin the foreground (normal situation), or 2 to thin the background.

- `maxiters::Int=0`: Maximum number of iterations allowed. Use 0 to iterate untill completion.

- `conn::Int=4`: 4 for 4-connectivity, 8 for 8-connectivity.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the skeleton.

Example
-------

Skeletonize a binary image.

\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/bone.png");
J = bwskell(I);
grdimage(I, figsize=6)
grdimage!(J, figsize=6, xshift=6, show=true)
```
\end{examplefig}
