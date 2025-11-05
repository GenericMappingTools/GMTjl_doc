# bwdist

**Distance transform of binary image**

---

## Description

```julia
D = bwdist(BW; weights=nothing, nthreads=Threads.nthreads())
```

Computes the Euclidean distance transform of the binary image `BW`. For each pixel in `BW`,
the distance transform assigns a number that is the distance between that pixel and the nearest nonzero pixel of `BW`.

Optionally specify the weight `w` assigned to each coordinate. For example, if `BW` corresponds
to an image where voxels are anisotropic, `w` could be the voxel spacing along each coordinate axis.
The default value of `nothing` is equivalent to `w=(1,1,...)`.

```julia
idx = bwdist_idx(BW)
```

Computes the closest-pixel map (also called the feature map, feature transform, or nearest-neighbor transform) and returns it as an index array. Each element of `idx` contains the linear index of the nearest nonzero pixel of `BW`.

---

## Input Arguments

### `BW` — GMTimage/GMTgrid or Matrix Binary image

Binary image, specified as a numeric or logical array. Can be of any numeric type and must be nonsparse.

**Data Types:** `Float64`, `Float32`, `Int`, `UInt8`, `Bool`

---

## Output Arguments

### `D` — Distance transform

Distance transform, returned as an GMTgrid/array the same size as `BW`. Each element represents the distance
from the corresponding pixel to the nearest nonzero pixel of `BW`.

### `idx` — Closest-pixel map

Closest-pixel map, returned as an array of linear indices with the same size as `BW`.
Each element contains the linear index of the nearest nonzero pixel of `BW`.

**Data Types:** `Int` or `CartesianIndex`

---

## References
This implementation was slightly adapted from the ImageMorphology.jl package.

Maurer, Calvin R., Rensheng Qi, and Vijay Raghavan. "A Linear Time Algorithm for Computing Exact Euclidean Distance Transforms of Binary Images in Arbitrary Dimensions." *IEEE Transactions on Pattern Analysis and Machine Intelligence*. Vol. 25, No. 2, February 2003, pp. 265-270.

---

## Examples

### Compute Distance Transform and Closest-Pixel Map

Create a binary image:

```julia
bw = zeros(5, 5)
bw[2, 2] = 1
bw[4, 4] = 1
```

Output:
```
5×5 Matrix{Float64}:
 0.0  0.0  0.0  0.0  0.0
 0.0  1.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  1.0  0.0
 0.0  0.0  0.0  0.0  0.0
```

Calculate the distance transform:

```julia
D = bwdist(bw)
```

Output:
```
5×5 Matrix{Float32}:
 1.41421  1.0      1.41421  2.23607  3.16228
 1.0      0.0      1.0      2.0      2.23607
 1.41421  1.0      1.41421  1.0      1.41421
 2.23607  2.0      1.0      0.0      1.0
 3.16228  2.23607  1.41421  1.0      1.41421
```

Calculate the closest-pixel map:

```julia
idx = bwdist_idx(bw)
```

Output:
```
5×5 Matrix{Int}:
 7  7   7   7  19
 7  7   7   7  19
 7  7   7  19  19
 7  7  19  19  19
 7 19  19  19  19
```

In the closest-pixel map `idx`, the values 7 and 19 represent the position of the nonzero elements using linear matrix indexing. If a pixel contains a 7, its closest nonzero neighbor is at linear position 7 (which is `bw[2, 2]`), and a pixel containing 19 has its closest nonzero neighbor at linear position 19 (which is `bw[4, 4]`).


### Use Closest-Pixel Map to Find Nearest Features

Create a binary image with multiple features:

```julia
# Create an image with some objects
bw = zeros(100, 100)
bw[20:25, 20:25] .= 1
bw[50:55, 70:75] .= 1
bw[75:80, 40:45] .= 1

# Compute distance and indices
D = bwdist(bw)
idx = bwdist_idx(bw)

# Create a test point at (60, 60)
test_point_idx = 60 + (60-1)*100  # Linear index for [60, 60]

# Find which feature is closest
closest_feature_idx = idx[60, 60]
println("Closest feature is at linear index: $closest_feature_idx")
```

### Computing Distance to Background Pixels

By default, `bwdist` computes distances to nonzero (foreground) pixels. To compute distances
to zero (background) pixels, invert the image:

```julia
# Load binary image
BW = gmtread("text.png")

# Distance to foreground pixels
D_foreground = bwdist(BW)

# Distance to background pixels (invert first)
D_background = bwdist(.!BW)

# Visualize both
subplot(1, 2, 1)
imshow(D_foreground)
title!("Distance to Foreground")

subplot(1, 2, 2)
imshow(D_background)
title!("Distance to Background")

showfig()
```

---

## Tips

- Use the Euclidean metric for most applications requiring accurate distance measurements
- The quasi-Euclidean method provides a good approximation to Euclidean distance with comparable performance
- City block and chessboard metrics can be faster for large multidimensional images
- Invert binary images (`.!BW`) to compute distances to background pixels instead of foreground pixels
- Combine with `watershed` for image segmentation applications
- Use `bwdist_idx` to track which feature each pixel is closest to
- The closest-pixel map is useful for Voronoi tessellation and nearest-neighbor classification

---

## See Also

\myreflink{graydist}, \myreflink{watershed}