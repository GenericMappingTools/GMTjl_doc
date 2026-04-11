# image_alpha!

```julia
I = image_alpha!(img::GMTimage; alpha_ind::Integer, alpha_vec::Vector{Integer}, alpha_band::UInt8)
```

Change the alpha transparency of the \myreflink{GMTimage} object `img`. If the image is indexed, one can either
change just the color index that will be made transparent by using `alpha_ind=n` or provide a vector
of transaparency values in the range [0 255]; This vector can be shorter than the orginal number of colors.
Use `alpha_band` to change, or add, the alpha of true color images (RGB).


Examples
--------
    
Change to the third color in cmap to represent the new transparent color

```julia
image_alpha!(img, alpha_ind=3)
```
    
Change to the first 6 colors in cmap by assigning them random values

```julia
image_alpha!(img, alpha_vec=round.(Int32,rand(6).*255))
```

See Also
--------

\myreflink{image_cpt!}, \myreflink{ind2rgb}
