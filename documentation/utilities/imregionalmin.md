# imregionalmin

**Regional minima**

---

## Description

```julia
BW = imregionalmin(I)
```

Returns the binary image `BW` that identifies the regional minima in the 2-D grayscale image `I`.
Regional minima are connected components of pixels with a constant intensity value, surrounded by pixels with a higher value.

```julia
BW = imregionalmin(I, conn)
```

Computes the regional minima using the specified connectivity `conn`.

---

## Input Arguments

### `I` — GMTgrid|image or Matrix

Grayscale 2-D image, specified as a numeric matrix.

**Data Types:** `UInt8` and Floating point types. In this later case an UInt8 representation is used internally.

### `conn` — Pixel connectivity

Pixel connectivity, specified as one of the values in this table. The default connectivity is `8` for 2-D images.

#### Two-Dimensional Connectivities

| Value | Meaning |
|-------|---------|
| `4` | Pixels are connected if their edges touch. The neighborhood of a pixel are the adjacent pixels in the horizontal or vertical direction. |
| `8` | Pixels are connected if their edges or corners touch. The neighborhood of a pixel are the adjacent pixels in the horizontal, vertical, or diagonal direction. |

Connectivity can also be defined by specifying a 3-by-3 matrix of `0`s and `1`s. The `1`-valued elements define
neighborhood locations relative to the center element of `conn`. Note that `conn` must be symmetric about its center element.

**Data Types:** `Int`, or array of `Bool`

---

## Output Arguments

### `BW` — GMTimage with locations of regional minima

Locations of regional minima, returned as a logical array of the same size as `I`. Pixels with the value
`true` (or `1`) indicate regional minima; all other pixels are set to `false` (or `0`).

**Data Types:** `Bool`

---

## Examples

### Find Regional Minima in Simple Array

Create a simple sample array with several regional minima:

```julia
A = 10 * ones(10, 10)
A[2:4, 2:4] .= 3
A[6:8, 6:8] .= 8
```

Output:
```
10×10 Matrix{Float64}:
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0   3.0   3.0   3.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0   3.0   3.0   3.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0   3.0   3.0   3.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0   8.0   8.0   8.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0   8.0   8.0   8.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0   8.0   8.0   8.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
```

Calculate the regional minima. The function returns a binary image, the same size as the input image,
in which pixels with the value `true` (or `1`) represent the regional minima. `imregionalmin` sets all other pixels to `false` (or `0`):

```julia
regmin = imregionalmin(A)
```

Output:
```
10×10 BitMatrix:
 0  0  0  0  0  0  0  0  0  0
 0  1  1  1  0  0  0  0  0  0
 0  1  1  1  0  0  0  0  0  0
 0  1  1  1  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  1  1  1  0  0
 0  0  0  0  0  1  1  1  0  0
 0  0  0  0  0  1  1  1  0  0
 0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0
```

### Find Regional Minima in Grayscale Image

Load a grayscale image:

```julia
I = gmtread("coins.png")
imshow(I)
```

Find the regional minima:

```julia
BW = imregionalmin(I)
imshow(BW)
```

Overlay the regional minima on the original image:

```julia
# Create an overlay showing minima in red
imshow(I)
# Mark regional minima
overlay!(BW, color=:red)
```

### Compare Different Connectivity Settings

Create a test image with a saddle point:

```julia
# Create an image with a valley structure
I = zeros(15, 15)
I[8, :] .= 5  # Horizontal ridge
I[:, 8] .= 5  # Vertical ridge
I[8, 8] = 3   # Saddle point
```

Compute regional minima with different connectivity:

```julia
# 4-connectivity (edges only)
BW4 = imregionalmin(I, 4)

# 8-connectivity (edges and corners)
BW8 = imregionalmin(I, 8)

# Display results
subplot(1, 3, 1)
imshow(I)
title!("Original Image")

subplot(1, 3, 2)
imshow(BW4)
title!("4-Connectivity")

subplot(1, 3, 3)
imshow(BW8)
title!("8-Connectivity")

showfig()
```

### Detect Valleys in Elevation Data

(These are Claude.ai dreams but maybe worth including)

Use regional minima to find valleys in a digital elevation model:

```julia
# Load elevation data
DEM = gmtread("elevation.tif")

# Find regional minima (valleys, depressions)
valleys = imregionalmin(DEM)

# Remove small spurious minima
valleys_clean = bwareaopen(valleys, 50)

# Overlay valleys on elevation map
imshow(DEM, cmap=:terrain)
overlay!(valleys_clean, color=:blue, alpha=0.7)
colorbar!()
title!("Valleys in Elevation Data")
```

### Pre-process Image with H-Minima Transform

Suppress shallow minima before finding regional minima:

```julia
# Load image
I = gmtread("rice.png")

# Original regional minima (many spurious minima)
minima_orig = imregionalmin(I)

# Apply H-minima transform to suppress shallow minima
I_hmin = imhmin(I, 10)

# Find regional minima after suppression
minima_filtered = imregionalmin(I_hmin)

# Compare results
subplot(1, 3, 1)
imshow(I)
title!("Original")

subplot(1, 3, 2)
imshow(minima_orig)
title!("Original Minima ($(sum(minima_orig)) regions)")

subplot(1, 3, 3)
imshow(minima_filtered)
title!("Filtered Minima ($(sum(minima_filtered)) regions)")

showfig()
```

---

## Notes

> **Regional Minima vs. Local Minima:** A regional minimum is a connected component of pixels with constant intensity, all of whose neighbors have a strictly greater value. This is different from a local minimum, which is a single pixel whose value is less than or equal to all its neighbors.

> **Flat Regions:** If an image contains large flat regions at the minimum intensity level, the entire flat region will be marked as a regional minimum.

> **Connectivity Impact:** Higher connectivity values (e.g., 8 vs 4 in 2-D) can merge what would be separate regional minima under lower connectivity, reducing the total number of detected minima.

> **Noise Sensitivity:** `imregionalmin` can be sensitive to noise and may detect many spurious minima. Consider preprocessing with `imhmin` (h-minima transform) or post-processing with `bwareaopen` to remove small or shallow minima.

---

## Tips

- Use `imhmin` to suppress shallow regional minima before detection
- Apply `bwareaopen` to remove small spurious regional minima
- Combine with `watershed` for marker-based image segmentation
- For elevation data, regional minima identify valleys, sinks, and depressions
- Use `imimposemin` to force specific minima before watershed segmentation
- The complement operation can be used to find regional maxima: `imregionalmin(-I)` or use `imregionalmax(I)`

---

## See Also

\myreflink{imregionalmax}, \myreflink{imhmin}, \myreflink{watershed}, \myreflink{imreconstruct}, \myreflink{bwareaopen}