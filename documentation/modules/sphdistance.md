# sphdistance

```julia
sphdistance(cmd0::String="", arg1=nothing; kwargs...)
```

**sphdistance** - Create Voronoi distance, node, or natural nearest-neighbor grid on a sphere

## Description

Reads one or more data files (or standard input) containing lon, lat coordinates and performs the construction of Voronoi polygons. These polygons are then processed to calculate the nearest distance to each node of the lattice and written to the specified grid. The Voronoi algorithm used is STRIPACK [Renka, 1997]. As an option, you may provide pre-calculated Voronoi polygon information, thus bypassing the memory- and time-consuming triangularization.

## Required Arguments

- *table*\
   A \myreflink{GMTdataset} (or matrix) or a data file name containing lon, lat coordinates.

- **G** or **save** or **outgrid** or **outfile** : -- *outgrid=name*\
   Output grid file name. Note that this is optional and to be used only when saving the result directly on disk. Otherwise, just use the `G = sphdistance(...)` form.

\textinput{common_opts/opt_I}

\textinput{common_opts/opt_R}

## Optional Arguments

- **C** or **save\_mem** : -- *save\_mem=true*\
   For large data sets you can save some memory (at the expense of more processing) by only storing one form of location coordinates (geographic or Cartesian) at the time [Default keeps both arrays in memory].

- **D** or **duplicates** : -- *duplicates=true*\
   Delete any duplicate points [Default assumes there are no duplicates]. Note: The STRIPACK algorithm and implementation expect that there are no duplicate points in the input. It is best that the user ensures this is the case. This option provides a brute-force yet exact comparison that is very slow for large data sets.

- **E** or **quantity** : -- *quantity=:d* **|** *quantity=:n* **|** *quantity="z[dist]"*\
   Specify the quantity to assign to the grid nodes:
   - **:d** : Distance to the nearest data point (default).
   - **:n** : Node ID of the nearest data point.
   - **:z** : Compute the natural nearest-neighbor gridding. Append *dist* (in same units as the grid spacing) to set the distance threshold beyond which we do not assign a value [Default is infinity, but typically using twice the node spacing yields good results].

- **L** or **dist\_unit** : -- *dist\_unit=:letter*\
   Specify distance unit for output grid. Choose among **e|f|k|M|n|u** for meter, foot, km, Miles, nautical miles, or survey foot. Requires that the input data are lon, lat coordinates.

- **N** or **nodes** : -- *nodes=nodetable*\
   Read a multisegment file with node information from \myreflink{sphtriangulate}. This bypasses the construction of the Voronoi polygons. The table may be a file name, a GMTdataset, or a matrix.

- **Q** or **voronoi** : -- *voronoi=file*\
   Append the name of a file with pre-calculated Voronoi polygons in the format written by \myreflink{sphtriangulate}. This bypasses the memory- and time-consuming triangularization [Default performs Delaunay triangulation on input data to set up the Voronoi polygons].

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_di}

\textinput{common_opts/opt_e}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt_qi}

\textinput{common_opts/opt__i}

\textinput{common_opts/opt__j}

\textinput{common_opts/opt_r}

\textinput{common_opts/opt_xy}


## Notes

The STRIPACK algorithm and implementation expect that there are no duplicate points in the input. It is best that the user ensures that this is the case. GMT has tools, such as \myreflink{blockmean} and others, to combine close points into single entries. Also, **sphdistance** has the **duplicates** option to determine and exclude duplicates, but it is a very brute-force yet exact comparison that is very slow for large data sets.

## Examples

To generate a grid with distances (in km) to the nearest points in the hotspots file:

```julia
# Using sphtriangulate to pre-compute the Voronoi polygons
V = sphtriangulate("@hotspots.txt", voronoi=true, skip=true)
G = sphdistance(voronoi=V, region=:global, inc=1, outgrid="globedist.nc", dist_unit=:k)
```

To construct Voronoi polygons from the points in testdata.txt and then calculate distances from the data to a global 1×1 degree grid:

```julia
D = gmtread("testdata.txt")
G = sphdistance(D, region=:global, inc=1)
```

To generate the same grid in two steps using [`sphtriangulate`](@ref) separately:

```julia
# First create the Voronoi polygon information
V = sphtriangulate("testdata.txt", voronoi=true)

# Then compute the distances
G = sphdistance(voronoi=V, region=:global, inc=1)
```

To create a natural nearest-neighbor grid from hotspots.txt with max interpolation distance of 2 degrees:

```julia
G = sphdistance("@hotspots.txt", quantity="z2", region=:global, inc=1)
```

## References

Renka, R. J., 1997, Algorithm 772: STRIPACK: Delaunay Triangulation and Voronoi Diagram on the Surface of a Sphere, *ACM Trans. Math. Software*, **23**(3), 416-434, [https://doi.org/10.1145/275323.275329](https://doi.org/10.1145/275323.275329).

## See Also

\myreflink{sphtriangulate}, \myreflink{triangulate}