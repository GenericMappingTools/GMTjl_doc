# imcomplement

```julia
J = imcomplement(I::GMTimage) -> GMTimage
```

*keywords: GMT, Julia, image processing*

Compute the complement of the image `I` and returns the result in `J`.

`I` can be a binary, intensity, or truecolor image. `J` has the same type and size as `I`. `I` can
also be just a matrix. All types numeric (but complex) are allowed.

In the complement of a binary image, black becomes white and white becomes black. In the case of a
grayscale or truecolor image, dark areas become lighter and light areas become darker.

The ``imcomplement!`` function works in-place and returns the modified ``I``.

### Returns
- A new \myreflink{GMTimage}

Example
-------

Reverse Black and White in a Binary Image.

\begin{examplefig}{}
```julia
using GMT

text(["Hello World"], region=(1.92,2.08,1.97,2.02), x=2.0, y=2.0,
     font=(30, "Helvetica-Bold", :white),
     frame=(axes=:none, bg=:black), figsize=(6,0), name="tmp.png")

# Read only one band (althouh gray scale, the "tmp.png" is actually RGB)
I = gmtread("tmp.png", band=1);
Ic = imcomplement(I);

# Show the two
grdimage(I, figsize=8)
grdimage!(Ic, figsize=8, yshift=-2.57, show=true)
```
\end{examplefig}

Create the Complement of a Color Image

\begin{examplefig}{}
```julia
using GMT

I = gmtread(GMT.TESTSDIR * "assets/table_flowers.jpg");
Ic = imcomplement(I);

grdimage(I, figsize=6)
grdimage!(Ic, figsize=6, xshift=6, show=true)
```
\end{examplefig}

See Also
--------

\myreflink{binarize}
