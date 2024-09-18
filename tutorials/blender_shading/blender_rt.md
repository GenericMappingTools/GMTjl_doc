# Shading with Blender

This tutorial shows how we can create stunning shaded relief images using the Blender ray tracer to solve
the hard jobb of computing illumination with realist shadows of a DEM surface. The tutorial linked bellow
takes some time to follow and the time needed to compute the raytraced image is on the order of minutes.
However, as the author says at the end, once we have it set for one case it is easy and fast to adapt it
to other cases. In a posterior improvement of this tutorial we will show how to modify needed parameters
of the _.blend_ file that is run by Blender to create the raytraced image.


\begin{examplefig}{}
```julia
using GMT

# Extract a region of West Ibaria from the 15 arc sec grids stored in the GMT server
Gwib = grdcut("@earth_relief_15s", region=(-10.5, -5, 35, 44));

# Create a tint image from the Gwib grid
I = grdimage(Gwib, C=:earth, img_out=true);
viz(I, coast=true)
```
\end{examplefig}

Load the previously created raytrace image computed with Blender following the tutorial
[Creating Shaded Relief in Blender](https://somethingaboutmaps.wordpress.com/2017/11/16/creating-shaded-relief-in-blender/)
But note that the first part of that tutorial where it explains how to cretae the UInt16 _heightmap_ can be replaced by
this simple command:

```julia
gdalwrite("Gwib.tiff", rescale(Gwib, type=UInt16))
```

Load the gray scale image and show it:

\begin{examplefig}{}
```julia
using GMT

Iblend = gmtread("https://oceania.generic-mapping-tools.org/cache/wiberia_shade_blender.png");
viz(Iblend, coast=true)
```
\end{examplefig}

Now apply the techniques explained in this tutorial [Adding Shaded Relief in Photoshop](https://somethingaboutmaps.wordpress.com/2014/10/26/adding-shaded-relief-in-photoshop/)
to blend the tint, the shades and illumination


\begin{examplefig}{}
```julia
using GMT

I = grdimage(Gwib, C=:earth, img_out=true);		# Hide
Iblend = gmtread("https://oceania.generic-mapping-tools.org/cache/wiberia_shade_blender.png");	# Hide
# Blend the tint and the shades (darken)
Iburn = blendimg!(I, Iblend, mode="LinearBurn", new=true);

# Apply illunination to the previous image
Ib = blendimg!(Iburn, Iblend, mode="Screen", new=true);

viz(Ib, coast=true)
```
\end{examplefig}
