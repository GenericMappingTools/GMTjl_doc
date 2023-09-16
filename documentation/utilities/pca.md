# pca

```julia
score, coeff, latent, explained, mu, ems = pca(X; DT::DataType=Float32, npc=0)
```

- `X`: A n-by-p data matrix X. Rows of X correspond to observations and columns correspond to variables.
  Must be a Float type (either 32 or 64).
  
- `npc`: The number of eigenvectors used to construct the solution. Its value must be in the range [1, npc].
  The default `npc=0` means we use the full solution, that is npc = p. Use this option when `X` is *big* and
  you want to save some resources (time, memory) by not computing components that will have a very small
  explained variance.

- `DT`: The Data Type. Internally, the algorithm makes a copy of the input `X` matrix because it will be
  modified. `DT` controls what type that copy will assume. ``Float32`` or ``Float64``? By default, we use the same
  data type as in `X`, but for big matrices it may be desirable to use ``Float32`` if that saves memory.
  Note: the default is different in the methods referred below, where it defaults to ``Float32`` because image
  data is almost always ``UInt8`` or ``UInt16`` and grids are ``Float32``.
  
Returns
-------
  
- `score`: The principal components.

- `coeff`: The principal component coefficients for the matrix X. Rows of X correspond to observations and
  columns correspond to variables. The coefficient matrix is npc-by-n. Each column of coeff contains coefficients
  for one principal component, and the columns are in descending order of component variance.

- `latent`: The principal component variances. (The eigenvalues of cov(X))

- `explained`: The percentage of the total variance explained by each principal component.

- `mu`: The mean of each variable in X.

- `ems`: The mean square error incurred in using only the `npc` eigenvectors corresponding to the largest
  eigenvalues. `ems` is 0 if npc = n (the default). 


```julia
Ipca = pca(I::GMTimage; DT::DataType=Float32, npc=0) -> GMTimage{UInt8}
```

This method takes a \myreflink{GMTimage} cube, normally satellite data of ``UInt16`` type created with the ``RemoteS`` package,
and returns a \myreflink{GMTimage} cube of ``UInt8`` of the principal components in decreasing order of explained variance.
The ``truecolor(Ipca)`` (from ``RemoteS``) will show a false color image made of the three largest components.

```julia
Gpca = pca(G::GMTgrid; DT::DataType=Float32, npc=0) -> GMTgrid{DT}
```

This method takes a \myreflink{GMTgrid} cube and returns another grid, of type `DT` (``Float32`` by default), with principal
components in decreasing order of explained variance.
