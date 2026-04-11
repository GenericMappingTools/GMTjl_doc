# imregionalmax

**Regional maxima**

---

## Description

```julia
BW = imregionalmax(I)
```

Returns the binary image `BW` that identifies the regional maxima in the 2-D grayscale image `I`.
Regional maxima are connected components of pixels with a constant intensity value, surrounded by pixels with a lower value.

```julia
BW = imregionalmax(I, conn)
```

Computes the regional maxima using the specified connectivity `conn`.

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

Locations of regional maxima, returned as a logical array of the same size as `I`. Pixels with the value `true` (or `1`)
indicate regional maxima; all other pixels are set to `false` (or `0`).

**Data Types:** `Bool`


---

## Notes

> **Regional Maxima vs. Local Maxima:** A regional maximum is a connected component of pixels with constant intensity, all of whose neighbors have a strictly lower value. This is different from a local maximum, which is a single pixel whose value is greater than or equal to all its neighbors.

> **Flat Regions:** If an image contains large flat regions at the maximum intensity level, the entire flat region will be marked as a regional maximum.

> **Connectivity Impact:** Higher connectivity values (e.g., 8 vs 4 in 2-D) can merge what would be separate regional maxima under lower connectivity, reducing the total number of detected maxima.

> **Noise Sensitivity:** `imregionalmax` can be sensitive to noise and may detect many spurious maxima. Consider preprocessing with `imhmax` (h-maxima transform) or post-processing with `bwareaopen` to remove small or shallow maxima.

---

## Tips

- Use `imhmax` to suppress shallow regional maxima before detection
- Apply `bwareaopen` to remove small spurious regional maxima
- Combine with `watershed` for marker-based image segmentation
- For elevation data, regional maxima identify peaks and summits
- Use `imextendedmax` to apply the H-maxima transform and find regional maxima in one step
- The complement operation can be used to find regional minima: `imregionalmax(-I)` or use `imregionalmin(I)`

---

## Examples

### Find Regional Maxima in Simple Array

Create a simple sample array with several regional maxima:

```julia
A = 10 * ones(10, 10)
A[2:4, 2:4] .= 22
A[6:8, 6:8] .= 33
A[2, 7] = 44
A[3, 8] = 45
A[4, 9] = 44
```

Output:
```
10×10 Matrix{Float64}:
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0  22.0  22.0  22.0  10.0  10.0  44.0  10.0  10.0  10.0
 10.0  22.0  22.0  22.0  10.0  10.0  10.0  45.0  10.0  10.0
 10.0  22.0  22.0  22.0  10.0  10.0  10.0  10.0  44.0  10.0
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  33.0  33.0  33.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  33.0  33.0  33.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  33.0  33.0  33.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
 10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0  10.0
```

Calculate the regional maxima. The function returns a binary image, the same size as the input image, in which pixels with the value `true` (or `1`) represent the regional maxima. `imregionalmax` sets all other pixels to `false` (or `0`):

```julia
regmax = imregionalmax(A)
```

Output:
```
10×10 BitMatrix:
 0  0  0  0  0  0  0  0  0  0
 0  1  1  1  0  0  0  0  0  0
 0  1  1  1  0  0  0  1  0  0
 0  1  1  1  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  1  1  1  0  0
 0  0  0  0  0  1  1  1  0  0
 0  0  0  0  0  1  1  1  0  0
 0  0  0  0  0  0  0  0  0  0
 0  0  0  0  0  0  0  0  0  0
```

Note that the pixel at position (3, 8) with value 45 is identified as a regional maximum because it is higher than all its neighbors.

### Find Regional Maxima in Grayscale Image

Load a grayscale image:

```julia
I = gmtread("coins.png")
imshow(I)
```

Find the regional maxima:

```julia
BW = imregionalmax(I)
imshow(BW)
```

Overlay the regional maxima on the original image:

```julia
# Create an overlay showing maxima in green
imshow(I)
overlay!(BW, color=:green)
```

### Compare Different Connectivity Settings

Create a test image with a ridge structure:

```julia
# Create an image with a ridge
I = zeros(UInt8, 15, 15)
I[8, :] .= 100  # Horizontal ridge
I[:, 8] .= 100  # Vertical ridge
I[8, 8] = 150   # Peak at intersection
```

Compute regional maxima with different connectivity:

```julia
# 4-connectivity (edges only)
BW4 = imregionalmax(I, 4)

# 8-connectivity (edges and corners)
BW8 = imregionalmax(I, 8)

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

### Use Regional Maxima for Marker-Based Watershed Segmentation

Regional maxima are often used to identify seed points for marker-based watershed segmentation:

```julia
# Load image
I = gmtread("coins.png")

# Compute distance transform
D = bwdist(.!imbinarize(I))

# Find regional maxima in distance transform
maxima = imregionalmax(D)

# Remove small regional maxima (noise)
maxima_filtered = bwareaopen(maxima, 10)

# Label the maxima as markers
markers = label_components(maxima_filtered)

# Impose maxima on negative distance for watershed
D_comp = -D
D_mod = imimposemin(D_comp, maxima_filtered)

# Perform watershed segmentation
L = watershed(D_mod)

# Display results
subplot(1, 3, 1)
imshow(I)
title!("Original")

subplot(1, 3, 2)
imshow(maxima_filtered)
title!("Filtered Maxima")

subplot(1, 3, 3)
imshow(label2rgb(L))
title!("Watershed Segmentation")

showfig()
```

### Detect Peaks in Elevation Data

(These are Claude.ai dreams but maybe worth including)

Use regional maxima to find peaks in a digital elevation model:

```julia
# Load elevation data
DEM = gmtread("elevation.tif")

# Find regional maxima (peaks, summits)
peaks = imregionalmax(DEM)

# Remove small spurious maxima
peaks_clean = bwareaopen(peaks, 20)

# Overlay peaks on elevation map
imshow(DEM, cmap=:terrain)
overlay!(peaks_clean, color=:red, alpha=0.8)
colorbar!()
title!("Peaks in Elevation Data")
```

### Pre-process Image with H-Maxima Transform

Suppress shallow maxima before finding regional maxima:

```julia
# Load image
I = gmtread("rice.png")

# Original regional maxima (many spurious maxima)
maxima_orig = imregionalmax(I)

# Apply H-maxima transform to suppress shallow maxima
I_hmax = imhmax(I, 10)

# Find regional maxima after suppression
maxima_filtered = imregionalmax(I_hmax)

# Compare results
subplot(1, 3, 1)
imshow(I)
title!("Original")

subplot(1, 3, 2)
imshow(maxima_orig)
title!("Original Maxima ($(sum(maxima_orig)) regions)")

subplot(1, 3, 3)
imshow(maxima_filtered)
title!("Filtered Maxima ($(sum(maxima_filtered)) regions)")

showfig()
```

### Count Number of Regional Maxima

To count the number of regional maxima pixels:

```julia
I = gmtread("sample.png")
BW = imregionalmax(I)

# Count maxima pixels
n_pixels = sum(BW)
println("Number of regional maxima pixels: $n_pixels")

# Count maxima regions (connected components)
CC = bwconncomp(BW)
n_regions = CC.NumObjects
println("Number of regional maxima regions: $n_regions")
```

---

## See Also

\myreflink{imregionalmin}, \myreflink{imhmax}, \myreflink{watershed}, \myreflink{imreconstruct}, \myreflink{bwareaopen}, \myreflink{bwdist}