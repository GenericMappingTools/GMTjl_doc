# 3D models with side walls

These examples show a GMT.jl version of a PyGMT post in the GMT forum and that can be found at the original
author's, JiahongLuo, Github [site](https://github.com/Luojiahong/PyGMT_3D_mapview/blob/main/mapview_3d_earthquake.ipynb)

The \myreflink{cubeplot} function let us easily plot images on the sides of a cube. That function can also be used
to create those side figures directly from a 3D cube grid.

```julia
using GMT

# Download data from:
model = gmtread("https://github.com/ShouchengHan/USTClitho2.0/blob/main/USTClitho2.0.wrst.sea_level.txt");

# Create two data cubes (grids) with the Vp and Vs velocities
Cvp = xyzw2cube(model);
Cvs = xyzw2cube(model, zcol=5);

# Add names to the cube layers to be used as titles in next figure
Cvp.names = ["Depth = $(Int(i)) km" for i in Cvp.v];
Cvs.names = ["Depth = $(Int(i)) km" for i in Cvs.v];
```

Show all 12 layers of the P-waves velocity in a figure. We use a diffent colormap for each layer to avoid that
layers become too monochromatic.

```julia
viz(Cvp, colorbar=true, cmap=:same, title="Vp model")
```

~~~
<img src="/assets/Vp_mosaic.png" width="280" class="center"/>
~~~

Show the P and S velocities with a slight variation of the top layer. For the P-velocity we plot the topography on top
and for the S-velocity we show the superficial S velocity but apply a shading effect calculated from the topography
grid.

```julia
using GMT	# Hide
cubeplot(Cvp, top="@earth_relief_05m", colorbar=("xlabel=P-wave velocity", "ylabel=km/s"), zdown=true, title="Vp model")
cubeplot!(Cvs, top="@earth_relief_05m", topshade=true, zdown=true, colorbar=("xlabel=S-wave velocity", "ylabel=km/s"), xshift=18, title="Vs model", show=true)
```

~~~
<img src="/assets/Vp_Vs_cubes.png" width="1000" class="center"/>
~~~

To finish we show how to make an inset view in the 3D model.

```julia
using GMT	# Hide
cubeplot(Cvp, top="@earth_relief", inset=(lon=100, lat=35), topshade=true, zdown=true,
         colorbar=("xlabel=P-wave velocity", "ylabel=km/s"), show=true)
```

~~~
<img src="/assets/Vp_inset.png" width="800" class="center"/>
~~~
