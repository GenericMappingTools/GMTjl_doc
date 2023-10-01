# cubeplot

```julia
cubeplot(img1::Union{GMTimage, String}, img12::Union{GMTimage, String}="", img1e3::Union{GMTimage, String}="";
         back::Bool=false, show=false, notop::Bool=false, kw...)
```

*keywords: GMT, Julia, image cube plots*

Plot images on the sides of a cube. Those images can be provided as file names, or \myreflink{GMTimage} objects.

- `img1,2,3`: File names or GMTimages of the images to be plotted on the three cube sides. Of those three, only
  `img1` is mandatory, case in which it will be repeated in the thre visible sides of the cube. If `img1` and
  `img2`, this second image is plotted on the two vertical sides. When the three images are provided, the first
  goes to top (or bottom if `back=true`) the second to the *xz* and third to *yz* planes. 

- `back`: Boolean that defaults to false, meaning that images are printed on the front sides of the cube. If `false`,
  the images are printed in the back sides. Use this option when wanting to plot on the walls of a 3D lines/scatter
  or grid views. The default is to print on the front facades.

- `notop`: If true, do not plot the top side (implies `back=false`)

- `show`: If `true`, finish and display the figure.

The `kw...` keyword/value options may be used to pass:

- `region`: The limits extents that will be used to annotate the *x,y,z* axes. It uses the same syntax as all
  other modules that accept this option (*e.g.* \myreflink{coast}). It defaults to "0/9/0/9/0/9"

- `figsize`: Select the horizontal size(s). Defaults to 15x15 cm.

- `zsize`: Sets the size of *z* axis in cm. The default is 15.

- `view`: The view point. Default is `(135,30)`. WARNING: only azimute views from the 4rth quadrant are implemented.

- `transparency`: Sets the image's transparency level in the [0,1] or [0 100] intervals. Default is opaque.


See Also
--------

\myreflink{slicecube}, \myreflink{xyzw2cube}
