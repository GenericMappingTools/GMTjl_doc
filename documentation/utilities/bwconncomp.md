# bwconncomp

```julia
CC = bwconncomp(BW; conn=8)
```

Find and count connected components in binary image.

## Description

Finds and counts the connected components in the binary image `BW`. The function returns a structure
containing the total number of connected components, such as regions of interest (ROIs), in the image
and the pixel indices assigned to each component.

## Parameters

- **BW**: Binary 2D image. For numeric input, any nonzero pixels are considered to be 1 (true).
  - **Type**: `Array{<:Real}` or `GMTgrid`

## Keyword Arguments

- **conn**: Connectivity for connected components
  - **Type**: `Integer` or `Array`
  - **Default**: `8`
  - **Options**:
    - For 2D images:
      - `4` — 4-connected neighborhood (edge connectivity)
      - `8` — 8-connected neighborhood (edge and corner connectivity)
    - Alternatively, can be a connectivity array of 0s and 1s with the same dimensionality as `BW`. The 1-valued elements define neighborhood locations relative to the center element. The center element must be 1. The connectivity array size must be odd along each dimension.

## Returns

Connected components, specified as a structure with the following fields:

| Field | Description |
|-------|-------------|
| `connectivity` | Connectivity of the connected components |
| `image_size` | Size of the binary image |
| `num_objects` | Number of connected components in the binary image |
| `range` | Range of the image coordinates |
| `inc` | Image's increment (!= 1 whem image is referenced) |
| `registration` | Registration of the image |
| `x` | X coordinates of the image |
| `y` | Y coordinates of the image |
| `layout` | Memory layout of the image |
| `proj4` | Projection definition (optional) |
| `wkt` | Well-known text definition (optional) |
| `epsg` | EPSG code of the image |
| `bbox` | The bounding boxes as a vector of GMTdataset |
| `pixel_list` | Vector where each element contains the linear indices of the pixels in each object |
| `centroid` | A Float64 Matrix with the x,y coordinates of the centroids for each component |
| `area` | A vector of Float64 with the areas of each component |

- To compute a label matrix with a memory-efficient data type (for instance, `UInt8` versus `Float64`),
  use the `labelmatrix` function on the output of `bwconncomp`:

```julia
CC = bwconncomp(BW)
L = labelmatrix(CC)
```

## Examples

### Find Connected Components in Binary Image

```julia
using GMT

# Create a binary image
BW = [1 1 0 0 0 0 0 0
      1 1 0 1 1 0 0 0
      0 0 0 1 1 0 0 0
      0 0 0 0 0 1 1 0
      0 0 0 0 0 1 1 0
      0 0 0 0 0 0 0 0]

# Find connected components
CC = bwconncomp(BW)

println("Number of connected components: ", CC.num_objects)
```

### Specify Connectivity

Find connected components using 4-connectivity instead of the default 8-connectivity:

```julia
using GMT

BW = [1 1 0 0 0 0 0 0
      1 1 0 1 1 0 0 0
      0 0 0 1 1 0 0 0
      0 0 0 0 0 1 1 0
      0 0 0 0 0 1 1 0
      0 0 0 0 0 0 0 0]

# 4-connectivity
CC4 = bwconncomp(BW, conn=4)
println("Number of components (4-conn): ", CC4.num_objects)

# 8-connectivity
CC8 = bwconncomp(BW, conn=8)
println("Number of components (8-conn): ", CC8.num_objects)
```

### Extract Properties of Connected Components

Use the output structure to analyze individual components:

```julia
using GMT

BW = [1 1 0 0 0 0 0 0
      1 1 0 1 1 0 0 0
      0 0 0 1 1 0 0 0
      0 0 0 0 0 1 1 0
      0 0 0 0 0 1 1 0
      0 0 0 0 0 0 0 0]

CC = bwconncomp(BW)

# Number of pixels in each component
numPixels = [length(CC.pixel_list[i]) for i in 1:CC.num_objects]
println("Pixels per component: ", numPixels)

# Find the largest component
largest = argmax(numPixels)
println("Largest component is #", largest, " with ", numPixels[largest], " pixels")
```

## See Also

\myreflink{cc2bw}