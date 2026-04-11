# rgb2YCbCr

```julia
YCbCr = rgb2YCbCr(I::GMTimage{UInt8, 3}; Y=false, Cb=false, Cr=false, BT709=false)

or

Y,Cb,Cr = rgb2YCbCr(I::GMTimage{UInt8, 3}; Y=false, Cb=false, Cr=false, BT709=false)
```

Convert RGB color values to luminance (Y) and chrominance (Cb and Cr) values of a YCbCr image.

Optionally, return only one to three of Y, Cb and Cr in separate images. For that use the `keywords`:
`Y`, `Cb` or `Cr`. Each ``true`` occurence makes it return that component, otherwise it returns an empty image.
The alternative ``rgb2ycbcr`` alias (all lowercase) is also accepted.

### Args
- `I::GMTimage{UInt8, 3}`: input RGB image.

### Kwargs
- `Y`: If `true` return the luminance (Y) component.

- `Cb`: If `true` return the Cb component.

- `Cr`: If `true` return the Cr component.

- `BT709`: If `true` use the ``ITU-R BT.709`` conversion  instead of the default ``ITU-R BT.601``.
  See https://en.wikipedia.org/wiki/YCbCr

### Returns
A RGB \myreflink{GMTimage} or up to three ``GMTimages`` grayscales images with the luminance (Y), Cb and Cr components.


Example
-------

\begin{examplefig}{}
```julia
using GMT

# Read an RGB image
I = gmtread(GMT.TESTSDIR * "assets/seis_section_rgb.jpg");
Iycbcr = rgb2YCbCr(I);

# The Cb and Cr components
_,Cb,Cr = rgb2YCbCr(I, Cb=true, Cr=true);

# Show the four.
grdimage(I, figsize=6)
grdimage!(Iycbcr, figsize=6, yshift=-2.84)
grdimage!(Cb, figsize=6, yshift=-2.84)
grdimage!(Cr, figsize=6, yshift=-2.84, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{rgb2lab}
