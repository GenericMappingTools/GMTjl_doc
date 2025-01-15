# rgb2lab

```julia
    img = rgb2lab(I::GMTimage{UInt8, 3})

or

    L, a, b = rgb2lab(I::GMTimage{UInt8, 3}, L=false, a=false, b=false)
```

Convert RGB to CIE 1976 L*a*b*

Optionally, return only one to three of: L, a* and b* separate images. For that use the `keywords`:
`L`, `a` or `b`. Each ``true`` occurence makes it return that component, otherwise it returns an empty image.

### Args
- `I::GMTimage{UInt8, 3}`: input RGB image.

### Kwargs
- `L`: If `true` return the `L` component.

- `a`: If `true` return the `a` component.

- `b`: If `true` return the `b` component.

### Returns
A RGB \myreflink{GMTimage} or up to three ``GMTimages`` grayscales images with the L, a* and b* components.


Example
-------

\begin{examplefig}{}
```julia
using GMT

# Read an RGB image and compute the Lab transform.
I = gmtread(GMT.TESTSDIR * "assets/seis_section_rgb.jpg");
Ilab = rgb2lab(I);

# The L, a* and b* components
L,a,b = rgb2lab(I, L=true, a=true, b=true);

# Show the five.
grdimage(I, figsize=8)
grdimage!(Ilab, figsize=8, yshift=-3.8)
grdimage!(L, figsize=8, yshift=-3.8)
grdimage!(a, figsize=8, yshift=-3.8)
grdimage!(b, figsize=8, yshift=-3.8, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{rgb2ycbcr}
