# imagesc

```julia
I = imagesc(mat; x=, y=, hdr=, proj4=, wkt=, GI=, clim=, cmap=, kw...) --> GMTimage
```

*keywords: GMT, Julia, grid, image*

imagesc takes a Float matrix or a \myreflink{GMTgrid} type and scales it (by default) to the [0, 255] interval.
In the process it creates a GMTimage type. Those types can account for coordinates and projection
information, hence the optional arguments. Contrary to its Matlab cousin, it doesn't display the
result (that we easily do with ``imshow(mat)``) but return instead a \myreflink{GMTimage} object.

- `clim`: Specify clims as a two-element vector of the form *[cmin cmax]*, where values of the scaled image
  less than or equal to *cmin* are assigned that value. The same goes for cmax.

- `cmap`: If provided, `cmap` is a \myreflink{GMTcpt} and its contents is converted to the \myreflink{GMTimage} colormap.

- `GI`: This can be either a \myreflink{GMTgrid} or a \myreflink{GMTimage} and its contents is used
  to set spatial contents (x,y coordinates) and projection info that one may attach to the created
  image result. This is a handy alterative to the `x=, y=, proj4=...` options.

- `stretch`: This option is indicated to select an interval of the range of the `z` values and use only
  those to scale to the [0 255] interval. A `stretch=true` automatically determines good values for
  histogram stretching via a call to \myreflink{histogram}. The form `stretch=(zmin,zmax)` allows specifying the
  input limits directly. A previous plot of ``histogram(mat, show=true)`` can help determine good values.
  Note that when this option `stretch` is used, ALL OTHER options are ignored. See also the ``rescale`` function.

If `mat` is instead a UInt16 \myreflink{GMTimage} type we call `rescale(I, stretch=true, type=UInt8)` instead of
issuing an error. In this case `clim` can be a two elements vector to specify the desired stretch range.
The default is to let \myreflink{histogram} guess these values.

Examples
--------

Create a grayscale image out of the ``peaks`` function.

```julia
using GMT

viz(imagesc(GMT.peaks()))
```

See Also
--------

\myreflink{grdimage}, \myreflink{grdview}, \myreflink{rescale}
