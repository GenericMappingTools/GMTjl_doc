# image_cpt!

```julia
image_cpt!(img::GMTimage, cpt::GMTcpt, clear=false)

or

image_cpt!(img::GMTimage, cpt::String, clear=false)
```

*keywords: GMT, Julia, images, colormaps*

Add (or replace) a colormap to a \myreflink{GMTimage} object from the colors in the cpt.
This should have effect only if `img` is indexed.
Use `image_cpt!(img, clear=true)` to remove a previously existant `colormap` field in `img`


See Also
--------

\myreflink{image_alpha!}, \myreflink{ind2rgb}
