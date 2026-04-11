# rasterzones!

```julia
rasterzones!(GI::GItype, shapes::Vector{GMTdataset}, fun::Function)
```

Apply a unidimensional function `fun` to to the elements of the grid or image `GI` that lies inside the polygons
of the \myreflink{GMTdataset} `shapes`. The `GI` array is modified in place.

- `GI`: A grid (\myreflink{GMTgrid}) or image (\myreflink{GMTimage}) type that will be modified by
  applying `fun` to the elements that fall inside the polygons of `shapes`.

- `shapes`: A vector of \myreflink{GMTdataset} containing the polygons inside which the elements if `GI`
  will be assigned a single value obtained by applying the function `fun`.

- `fun`: A unidemensional function name used to compute the contant value for the `GI` elements that fall
  inside each of the polygons of `shapes`.

Returns
-------

It does't return anything but the input `GI` is modified.


Examples
--------

Take the Peaks grid and replace the elements that fall inside a triangle at the center by their average.

\begin{examplefig}{}
```julia
using GMT

G = GMT.peaks();
D = mat2ds([-1 -1; 0 1; 1 -1; -1 -1]);
rasterzones!(G, D, mean)
viz(G)
```
\end{examplefig}


See Also
--------

\myreflink{colorzones!}
