# replicant

```julia
D = replicant(FV, kwargs...)::Vector{GMTdataset}
```

Take a Faces-Vertices dataset describing a 3D body and replicate it N number of times with the option of
assigning different colors and scales to each copy. The end result is a single Vector{GMTdataset} with
the replicated body.

### Args
- `FV`: A Faces-Vertices dataset describing a 3D body.

### Kwargs
- `replicate`: A NamedTuple with one or more of the following fields: `centers`, a Mx3 Matrix with the centers of the copies;
  `zcolor`, a vector of length ``size(centers, 1)``, specifying a variable that will be used together with the `cmap`
  option to assign a color of each copy (default is the ``1:size(centers, 1)``); `cmap`, a GMTcpt object; `scales`,
  a scalar or a vector of ``size(centers, 1)``, specifying the scale factor of each copy.

- `replicate`: A Mx3 Matrix with the centers of the each copy.

- `replicate`: A Tuple with a Matrix and a scalar or a vector. The first element is the centers Mx3 matrix and the
   second is the scale factor (or vector of factors).

- `scales`: Scale the copies by this factor, or vector of scales (same length as number of copies)

- `view or perspective`: Set the view angle for the replication. The default is `217.5/30`. Surface elements
   that are not visible from this persective are eliminated.

### Returns
A Vector{GMTdataset} with the replicated body. Normally, a triangulated surface.

Example
-------

\begin{examplefig}{}
```julia
using GMT
	
FV = sphere();
D  = replicant(FV, replicate=(centers=rand(10,3), scales=0.1));

# or, to plot them
viz(FV, replicate=(centers=rand(10,3)*10, scales=0.2))
```
\end{examplefig}

See Also
--------

\myreflink{extrude}, \myreflink{flatfv}, \myreflink{fv2fv}, \myreflink{grid2tri}, \myreflink{revolve}, \myreflink{surf2fv}
