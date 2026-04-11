# binarize

```julia
    Ibw = binarize(I::GMTimage, threshold::Int=0; band=1, threshold::Int=0, revert=false, bool::Bool=false) -> GMTimage
```

---
or

```julia
Ibw = binarize(I::GMTimage, threshold::Vector{Int}; band::Int=1, revert::Bool=false, bool::Bool=false)
```

Convert an image to a binary image (black-and-white) using a threshold.

### Args
- `I::GMTimage`: input image of type UInt8.

- `threshold`: A number in the range [0 255]. If the default (0) is kept and the keyword
  `threshold` is not used, then the threshold is computed using the \myreflink{isodata} method.
   Alternatively, a vector of two numbers in the range [0 255] can be used. In this case, the
   threshold is set to the first value and the second value is used to set the upper limit of the
   threshold range. That is, values between the two values are set to 255 and the rest to 0
   (or `true` and false respectively when the `bool` keyword is set to `true`). Note that with
   this second form, the `threshold` keyword does not exist.

### Kwargs
- `band`: If the `I` image has more than one band, use `band` to specify which one to binarize.
   By default the first band is used.

- `bool`: If `true`, the output image is of type Bool, otherwise it is of type UInt8.

- `threshold`: Alternative keyword argument to the positional `threshold` argument. Meaning, one can either
  use the `binarize(I, ??)` or `binarize(I, threshold=??)`.

- `revert`: If `true`, values below the threshold are set to 255, and values >= the threshold are set to 0.

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
