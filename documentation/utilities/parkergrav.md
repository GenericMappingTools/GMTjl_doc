# parkergrav

```julia
G = parkergrav(G, dir::String="dir"; nnx=0, nny=0, nterms=6, depth=0.0, zobs=0.0,
               pct=30, wshort=25.0, rho=1000.0, maxiter=50, min_err=1e-4, padtype::String="taper",
               isKm::Bool=false, verbose=false)::GMTgrid
```

*keywords: GMT, Julia, Gravity inversion*

Calculate the gravity direct or inverse problem using Parker's [1973] Fourier series summation approach.

Depending on the value of `dir` it will calculate the direct or inverse problem. The direct problem
calculates gravity anomaly given the topography of an interface. The inverse calculates interface (in meters)
from the gravity anomaly and a mean depth of that interface.

This function, for the direct problem, is equivalent to the GMT's \myreflink{gravfft} module. The inverse problem follows
the aproach of the magnetic case and the description in Parker's paper and should give the ~same results of
the `3DINVER.M` program (https://doi.org/10.1016/j.cageo.2004.11.004) although I did not check it (couldn't find the package).
It does, however, reproduce very well the tests from the `Grav3D.m` program (https://github.com/PhamLT/Grav3D),
of which we are using its test synthetic interface grid.

### Args
- `G`: GMTgrid or filename of the interface (meters or km positive up) for the direct problem
   or gravity anomaly (mGal) for the inverse problem.

- `dir`: "dir" for direct problem or "inv" for inverse problem.

### Kwargs

- `nnx, nny`: suitable grid dimensions for FFT. By default they are calculated as the next _good FFT number_ that
   is 20% larger than the size of the input grids. But this value can be set via the `pct` option. To the list of
   the _good FFT numbers_ run this command: ``gmt("grdfft -Ns")``

- `nterms`: number of terms in the Parker summation (default is 6)

- `depth`: Average depth in km of the interface. We compute that from `G` for the direct problem but have no way
   of knowing it for the inverse problem, so it **MUST** be set in that case.

- `zobs`: Level of observation in km. This is zero for marine magnetics surveys.

- `pct`: percentage of grid size to augment. See also the `nnx` and `nny` options. Use `pct=0` to force
   `nnx` and `nny` to be the same as the size of the input grids

- `wshort`: short wavelength cutoff (for the inverse problem only). By default we comput it automatically from
   the grid increments, but often it may require a finer tunning. 

- `rho`: The density contrast across the interface in kg/m^3 or g/cc.

- `maxiter`: The maximum number of iterations used in the inverse problem until the error is below `min_err`.

- `min_err`: The std error threshold used in the inverse problem between iterations. When changes are below
   this value the iterations are stopped.

- `padtype`: Strategy used when padding an array. The default is to use ``taper`` Hanning window. Alternative is
   ``zeros`` that pads with zeros.

- `isKm`: Set this to true to force that `G` is in km (including the grid increments). This overrides the units guessing.

- `verbose`: verbose mode


### Returns
A \myreflink{GMTgrid} with gravity anomaly (mGal) or interface (m)

Example
-------

A synthetic example. Make a Kaba like magnetization distribution of 10 A/m, compute the
magnetic field created by it and invert this field.

```julia
using GMT, FFTW

Gbat = gmtread(GMT.TESTSDIR * "/assets/model_interface_4parker.grd");

# Compute the gravity due to the interface. The direct problem
Ggrv = parkergrav(Gbat, rho=400, nterms=10)

# Compute the interface from the gravity. The inverse problem.
Gbat_inv = parkergrav(Ggrv, "inv", rho=400, depth=20.0)

# Recompute the gravity from inverted topography
Ggrv_rec = parkergrav(Gbat_inv, rho=400, nterms=10)

# The residues 
Gres = Ggrv - Ggrv_rec;

# Plot the results
grdimage(Gbat, figsize=7, title="Initial topography (m)", contour=true, colorbar=true)
grdimage!(Ggrv, figsize=7, xshift=9, title="Gravity anomaly (mGal)",
          cmap=:auto, contour=true, colorbar=true)
grdimage!(Gbat_inv, figsize=7, xshift=-9, yshift=-9.0, title="Calculated Interface (m)",
          cmap=:auto, contour=true, colorbar=true)
grdimage!(Gres, figsize=7, xshift=9, title="Residues (mGal)", cmap=:auto,
          contour=true, colorbar=true, show=true)
```

~~~
<img src="/assets/Parker_grav.png" width="1000" class="center"/>
~~~

See Also
--------

\myreflink{parkermag}, \myreflink{gravfft}
