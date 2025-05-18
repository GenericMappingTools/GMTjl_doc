# binarize

```julia
    Ibw = binarize(I::GMTimage, threshold::Int=0; band=1, , threshold::Int=0, revert=false) -> GMTimage
```

Convert an image to a binary image (black-and-white) using a threshold.

### Args
- `I::GMTimage`: input image of type UInt8.

- `threshold::Int`: A number in the range [0 255]. If the default (0) is kept and the keyword
  `threshold` is not used, then the threshold is computed using the \myreflink{isodata} method.

### Kwargs
- `band`: If the `I` image has more than one band, use `band` to specify which one to binarize.
   By default the first band is used.

- `threshold`: Alternative keyword argument to the positional `threshold` argument. Meaning, one can either
  use the `binarize(I, ??)` or `binarize(I, threshold=??)`.

- `revert`: If `true`, values below the threshold are set to 255, and values above the threshold are set to 0.

### Return
A new \myreflink{GMTimage}.


Example
-------

\begin{examplefig}{}
```julia
using GMT

I = gdalread(GMT.TESTSDIR * "assets/coins.jpg");
Ibw = binarize(I, band=1)

# Show the two side-by-side
grdimage(I, figsize=6)
grdimage!(Ibw, figsize=6, xshift=6.1, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{imcomplement}
