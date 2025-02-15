# flatfv

```julia
FV = flatfv(I::Union{GMTimage, AbstractString}; shape=nothing, level=0.0)::GMTfv
```

Create a flat 3D surface from an image and a set of xyz or xy coordinates.

This function creates a face for each pixel in the image that is inside the `shape` and assigns the
face's color from that of the image. So be careful that the image is not too large. As explained below,
this function creates flat surfaces in any of the xy, xz or yz planes. While this may seam a big
limitation, it can be circumvented by a posterior rotation of the image with the help of a rotation
matrix created with the `eulermat` function.

### Args
- `I`: A \myreflink{GMTimage} object or a file name of an image.

### Kwargs
- `shape`: A xyz or xy polygon defining a flat surface. When it is a 3D polygon, it must lie in the xz or yz planes.
   But it can also be a can also be a Symbol; one of `:circle`, `:circ`, `:ellipse`. In this later case, we
   compute a normalized circle or ellipse with dimensions taken from number of rows and columns in `I`.
   The ellipse (with a horizontal major) eccentricity  is computed from the ratio of the number of rows and columns.

- `level`: In case that `shape` is a polygon in the xy plane, this is the level or height of that flat surface.
   For other plane orientations, this level is extracted from the column of constant values in `shape`.

### Returns
A \myreflink{GMTfv} FacesVertices object representing the flat 3D surface.

Example
-------

\begin{examplefig}{}
```julia
using GMT
	
FV = flatfv(TESTSDIR * "/assets/table_flowers.jpg", shape=:circle, level=1.0);
viz(FV)
```
\end{examplefig}

See Also
--------

\myreflink{extrude}, \myreflink{fv2fv}, \myreflink{loft}, \myreflink{grid2tri}, \myreflink{revolve}, \myreflink{surf2fv}
