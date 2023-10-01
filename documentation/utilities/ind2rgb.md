# ind2rgb

```julia
I = ind2rgb(I::GMTimage, cmap::GMTcpt=GMTcpt(), layout="BRPa")
```

*keywords: GMT, Julia, image, indexed, RGB*

Convert an indexed \myreflink{GMTimage} I to RGB. If `cmap` is not provided, it uses the internal colormap to do the conversion.
If neither them exists, the layer is replicated 3 times thus resulting in a gray scale image.

This function mimics the Matlab's [ind2rgb](https://www.mathworks.com/help/matlab/ref/ind2rgb.html) cousin.


See Also
--------

\myreflink{imagesc}, \myreflink{image_cpt!}, \myreflink{image_alpha!}, \myreflink{makecpt}
