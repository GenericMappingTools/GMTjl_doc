# anaglyph

```julia
I = anaglyph(G|fname; vscale=1, sscale=2, kw...)
```

---

```julia
	I = anaglyph(G|fname; view3d::Bool=false, zsize=4, azim=190, dazim=2, cmap="gray", kw...)
```

---

Generate an anaglyph image from the input \myreflink{GMTgrid} `G` or grid's file name `fname`.

An anaglyph 3D is the stereoscopic 3D effect achieved by means of encoding each eye's image using
filters of different (usually chromatically opposite) colors, typically red and cyan. Anaglyph 3D
images contain two differently filtered colored images, one for each eye. When viewed through the
"color-coded" "anaglyph glasses", each of the two images is visible to the eye it is intended for,
revealing an integrated stereoscopic image (ref [Wiki](https://en.wikipedia.org/wiki/Anaglyph_3D)).

This function offers two methods to create anaglyphs from a gridded terrain model. The first one,
based on a simple gradient of the surface elevation, is very fast, takes a little while to fool
the brain (that is, to make it think it's looking into a true 3D surface) but gives a very impressive
feeling of depth. The second method, that generates 2 3D views using the \myreflink{grdview} program
and construct the anaglyph from those two images, is slower and creates a less perceptually depth
image but it is easier to see and displays more 3D info. 

### Args
- `G`: The input \myreflink{GMTgrid} or filename of data to be processed.

### Kwargs
- `vscale`: Terrain vertical scale factor (default: 1). Applies only to first method.

- `sscale`: Stereo separation scale factor (default: 2). Applies only to first method.

- `R`: Region of interest when reading a grid from disk (default: entire grid).
   Ignored when `G` is a GMTgrid.

- `view3d`: If true, selects an alternative and slower method that generates 2 3D views using
   the \myreflink{grdview} program and construct the anaglyph from those two images (default: false).

- `zsize`: z-axis size of the 3D view. Same as in \myreflink{grdview} (default: 4 cm).

- `azim`: Azimuth of the 3D view (default: 190).

- `dazim`: Azimuth step (default: 2). It means, create the anaglyph from the pair of images obtained
   with `azim` and `azim - dazim`.

- `cmap`: Color map (default: "gray").

### Returns
An anaglyph \myreflink{GMTimage} suitable for viewing with red-cyan glasses.

### Credits
The method that uses the grid's gradient is based on an ancient program called ManipRaster by Tierrt Souriot.
The second method, the one that uses the \myreflink{grdview} program, was proposed by Tim Hume in the GMT forum.
(https://forum.generic-mapping-tools.org/t/bringing-the-third-dimension-to-gmt-stereograms/6189)


Examples
--------

Create an anaglyph of first type overt the Iberian peninsula.

\begin{examplefig}{}
```julia
using GMT

I = anaglyph("@earth_relief_30s", region="-13/-5.5/35/44")
viz(I)
```
\end{examplefig}

Now let us see the Tonga Trench using the second method.


\begin{examplefig}{}
```julia
using GMT

I = anaglyph("@earth_relief_30s", R="-175.8/-171/-23/-14", view3d=true)
viz(I)
```
\end{examplefig}
